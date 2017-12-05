//
//  EditInfoViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/21.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class EditInfoViewController: BaseViewController {

    var dataArr = [Array<String>]()
    var infoArr = [Array<String>]()
    var model = PersonalModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "保存", style: .plain, target: self, action: #selector(edittingInfoDone(sender:)))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem?.isEnabled = false

        if model.user_name != nil {
            
            infoArr = [[""],[model.user_name,model.user_phone],[model.user_area,model.user_fit_class],[model.user_num]]
        }
        addTagsView()
    }
    
    @objc func edittingInfoDone(sender:UIBarButtonItem) {
        
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        
        let cell = mainTableView.cellForRow(at: IndexPath.init(row: 0, section: 1)) as! EditInfoCell
        let headCell = mainTableView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as! EditHeadCell
        
        let params =
            [
                "SESSIONID":SESSIONID,
                "mobileCode":mobileCode,
                "imagePaths":"2",
                "phone":cell.textfield.text!,
                "area":infoArr[2][0],
                "fit_class":infoArr[2][1],
                ]
        
        var imgArr = [UIImage]()
        var nameArr = [String]()
        
        imgArr.append(headCell.userIcon.image!)
        
        nameArr.append("User_headImage")
        
        upLoadImageRequest(params: params, data: imgArr, name: nameArr, success: { (datas) in
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        }) { (error) in
            deBugPrint(item: error)
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }
    
    
    override func requestData() {
        
    }
    
    override func configSubViews() {
        self.navigationItem.title = "我的"
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        dataArr = [["我的头像"],["我的名称","联系方式"],["所在地区","我的年级"],["学生学号"]]
        infoArr = [[""],["吴某某",""],["武汉","八年级"],["001"]]
        
        mainTableView = UITableView.init(frame: CGRect(x: 0,
                                                       y: 0,
                                                       width: kSCREEN_WIDTH,
                                                       height: kSCREEN_HEIGHT - 64),
                                         style: .grouped)
        mainTableView.dataSource = self;
        mainTableView.delegate = self;
        mainTableView.estimatedRowHeight = 44
        mainTableView.register(UINib(nibName: "EditHeadCell", bundle: nil), forCellReuseIdentifier: identyfierTable)
        mainTableView.register(UINib(nibName: "EditInfoCell", bundle: nil), forCellReuseIdentifier: identyfierTable1)
        self.view.addSubview(mainTableView)
        mainTableView.backgroundColor = kSetRGBColor(r: 239, g: 239, b: 244)
        mainTableArr = []
    }
    
    //    ******************代理 ： UITableViewDataSource,UITableViewDelegate  ************
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return  dataArr[section].count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return dataArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell : EditHeadCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable, for: indexPath) as! EditHeadCell
            cell.setUserIconBlock = {
                
                deBugPrint(item: $0)
                self.navigationItem.rightBarButtonItem?.isEnabled = true
            }
            return cell
        }else{
            let cell : EditInfoCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable1, for: indexPath) as! EditInfoCell

            if indexPath.section == 1 && indexPath.row == 1 {
                cell.EditInfoCellForFill(title: dataArr[indexPath.section][indexPath.row], content: infoArr[indexPath.section][indexPath.row])
         
            }else if indexPath.section == 2 {
                cell.EditInfoCellForNormal(title: dataArr[indexPath.section][indexPath.row], subStr: infoArr[indexPath.section][indexPath.row], is1: false)
                cell.accessoryType = .disclosureIndicator
            }else{
                cell.EditInfoCellForNormal(title: dataArr[indexPath.section][indexPath.row], subStr: infoArr[indexPath.section][indexPath.row], is1: true)
            
            }
            return cell

        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 19 * kSCREEN_SCALE))
        
        if section == 0 {
            view.height = 0
        }
        
        view.backgroundColor = UIColor.blue
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 19 * kSCREEN_SCALE))
        view.backgroundColor = kSetRGBColor(r: 239, g: 239, b: 244)
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 {
            return 0
        }
        return 19 * kSCREEN_SCALE
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01 * kSCREEN_SCALE
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
//        选择地区
        if indexPath.section == 2 && indexPath.row == 0 {
            showAreaView()
        }
//        选择年级
        if indexPath.section == 2 && indexPath.row == 1 {
            showGradeTagsView()
        }

    }
    
    
    var BGView = UIView()
    var gradeTagsView = ShowTagsView()
    var areaView = ShowTagsView()
    
    @objc func showChooseCondi(tap:UITapGestureRecognizer) -> Void {
        if tap.view?.alpha == 1 {
            
            UIView.animate(withDuration: 0.5) {
                tap.view?.alpha = 0
                self.gradeTagsView.transform = .identity
                self.areaView.transform = .identity
            }
        }
    }
    
    func hiddenViews() {
        UIView.animate(withDuration: 0.5) {
            self.BGView.alpha = 0
            self.gradeTagsView.transform = .identity
            self.areaView.transform = .identity
        }
        
    }
    
    
    //    视图TagView
    func addTagsView() {
        
        //        弹出视图弹出来之后的背景蒙层
        BGView = UIView.init(frame: self.view.frame)
        BGView.backgroundColor = kSetRGBAColor(r: 5, g: 5, b: 5, a: 0.5)
        BGView.alpha = 0
        //        BGView.isHidden = true
        
        let tapGes1 = UITapGestureRecognizer.init(target: self, action: #selector(showChooseCondi(tap:)))
        tapGes1.numberOfTouchesRequired = 1
        BGView.addGestureRecognizer(tapGes1)
        self.view.addSubview(BGView)
        
        
        gradeTagsView = UINib(nibName:"ShowTagsView",bundle:nil).instantiate(withOwner: self, options: nil).first as! ShowTagsView
        gradeTagsView.ShowTagsViewForGrades(title: "选择年级", total: 1)
        gradeTagsView.frame =  CGRect(x: 0, y: kSCREEN_HEIGHT, width: kSCREEN_WIDTH, height: 190+287*kSCREEN_SCALE)
        gradeTagsView.layer.cornerRadius = 24*kSCREEN_SCALE
        gradeTagsView.selectBlock = {
            if !$1 {
                self.infoArr[2][1] = $0
                self.mainTableView.reloadRows(at: [IndexPath.init(row: 1, section: 2)], with: .automatic)
                self.navigationItem.rightBarButtonItem?.isEnabled = true

            }
            self.hiddenViews()
        }
        
        gradeTagsView.clipsToBounds = true
        self.view.addSubview(gradeTagsView)
        

        areaView = UINib(nibName:"ShowTagsView",bundle:nil).instantiate(withOwner: self, options: nil).first as! ShowTagsView
        areaView.ShowTagsViewForChooseEdu(title: "选择城市", index: 0)
        areaView.frame =  CGRect(x: 0, y: kSCREEN_HEIGHT, width: kSCREEN_WIDTH, height: 350)
        areaView.layer.cornerRadius = 24*kSCREEN_SCALE
        areaView.selectBlock = {
            if !$1 {
                self.infoArr[2][0] = $0
                self.mainTableView.reloadRows(at: [IndexPath.init(row: 0, section: 2)], with: .automatic)
                self.navigationItem.rightBarButtonItem?.isEnabled = true

            }
            self.hiddenViews()
        }
        
        areaView.clipsToBounds = true
        self.view.addSubview(areaView)
        
    }
    
    
    
    func showGradeTagsView() -> Void {
        let y = 180+287*kSCREEN_SCALE
        
        UIView.animate(withDuration: 0.5) {
            self.gradeTagsView.transform = .init(translationX: 0, y: -y)
            self.BGView.alpha = 1
        }
    }
    
    
    func showAreaView() -> Void {
        let y = CGFloat(330)
        UIView.animate(withDuration: 0.5) {
            self.areaView.transform = .init(translationX: 0, y: -y)
            self.BGView.alpha = 1
        }
    }
    
}
