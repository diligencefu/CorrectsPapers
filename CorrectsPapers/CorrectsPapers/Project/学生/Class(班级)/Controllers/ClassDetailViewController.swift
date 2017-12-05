//
//  ClaswDetailViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/19.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class ClassDetailViewController: BaseViewController,UITextFieldDelegate {
    var typeArr = ["课时目录","班级成员","班级信息","成绩统计"]
    var headView = UIView()
    var buttonView = UIView()
    
    var underLine = UIView()
    var NofitICLabel = UILabel()

    var currentIndex = 1
    
    var searchTextfield = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configSubViews() {

        self.navigationItem.title = "少年班"
        
        headView = UIView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 165*kSCREEN_SCALE))
        headView.backgroundColor = UIColor.white
        NofitICLabel = UILabel.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 64 * kSCREEN_SCALE))
        NofitICLabel.textColor = kSetRGBColor(r: 255, g: 153, b: 0)
        NofitICLabel.textAlignment = .center
        NofitICLabel.text = "通知栏信息通知栏信息通知栏信息通知栏信息通知栏信息通知栏信息"
        NofitICLabel.font = kFont34
        headView.addSubview(NofitICLabel)
        updateButtons(titleArr: typeArr)
        self.view.addSubview(headView)
        
        mainTableView = UITableView.init(frame: CGRect(x: 0, y: 162 * kSCREEN_SCALE, width: kSCREEN_WIDTH, height: kSCREEN_HEIGHT - 64 - 165 * kSCREEN_SCALE), style: .plain)
        mainTableView.dataSource = self;
        mainTableView.delegate = self;
        mainTableView.estimatedRowHeight = 342
        mainTableView.tableFooterView = UIView.init()
        
        mainTableView.register(UINib(nibName: "ShowPeriodsCell", bundle: nil), forCellReuseIdentifier: identyfierTable)
        mainTableView.register(UINib(nibName: "ShowClassMemberCell", bundle: nil), forCellReuseIdentifier: identyfierTable1)
        mainTableView.register(UINib(nibName: "TClassInfoCell", bundle: nil), forCellReuseIdentifier: identyfierTable2)
        mainTableView.register(UINib(nibName: "ClassGradeCell", bundle: nil), forCellReuseIdentifier: identyfierTable3)

        self.view.addSubview(mainTableView)
    }
    
    
    func updateButtons(titleArr:[String]) {
        
        mainTableView.reloadData()
        
        _ = buttonView.subviews.map {
            $0.removeFromSuperview()
        }
        
        let kHeight = CGFloat(80 * kSCREEN_SCALE)
        var contentWidth = CGFloat()
        var totalWidth = CGFloat()
        
        buttonView = UIView.init(frame: CGRect(x: 0, y: 64*kSCREEN_SCALE, width: kSCREEN_WIDTH, height: 88*kSCREEN_SCALE))
        
        //MARK: 因为按钮字数不一样，长短有别，所以我先看看一共有多长再平分space
        for index in 0...typeArr.count-1{
            
            let kWidth = getLabWidth(labelStr: typeArr[index], font: kFont32, height: kHeight) + 10
            totalWidth += kWidth
            
        }
        
        let kSpace = CGFloat(kSCREEN_WIDTH - totalWidth)/CGFloat(typeArr.count+1)
        
        for index in 0...typeArr.count-1{
            
            let kWidth = getLabWidth(labelStr: typeArr[index], font: kFont32, height: kHeight) + 10
            let markBtn = UIButton.init(frame: CGRect(x: kSpace + (contentWidth + kSpace * CGFloat(index)) , y: 0, width: kWidth, height: kHeight))
            //            markBtn.center.y = headView.center.y
            markBtn.setTitle(typeArr[index], for: .normal)
            markBtn.setTitleColor(kGaryColor(num: 117), for: .normal)
            markBtn.titleLabel?.font = kFont28
            markBtn.addTarget(self, action: #selector(goodAtProject(sender:)), for: .touchUpInside)
            contentWidth += kWidth
            markBtn.tag = 131 + index
            buttonView.addSubview(markBtn)
        }
        
        let view = buttonView.viewWithTag(131) as! UIButton
        view.setTitleColor(kMainColor(), for: .normal)
        underLine = UIView.init(frame: CGRect(x: 0, y: 88 * kSCREEN_SCALE - 1, width: getLabWidth(labelStr: typeArr[0], font: kFont32, height: 1) - 5, height: 2))
        underLine.backgroundColor = kMainColor()
        underLine.layer.cornerRadius = 1
        underLine.clipsToBounds = true
        underLine.center.x = view.center.x
        buttonView.addSubview(underLine)
        
        headView.addSubview(buttonView)

    }

    
    //MARK:   顶部选择栏选择事件
    @objc func goodAtProject(sender:UIButton) {
        
        let view = headView.viewWithTag(currentIndex+130) as! UIButton
        
        if view == sender {
            return
        }
        
        view.setTitleColor(kGaryColor(num: 117), for: .normal)
        sender.setTitleColor(kMainColor(), for: .normal)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.underLine.bounds.size.width = getLabWidth(labelStr: (sender.titleLabel?.text)!, font: kFont32, height: 2)-5
            
            self.underLine.center = CGPoint(x:  sender.center.x, y:  self.underLine.center.y)
        })
        
        currentIndex = sender.tag - 130
        
        mainTableView.reloadData()
    }
    
    
    //MARK:  ******代理 ：UITableViewDataSource,UITableViewDelegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if currentIndex == 3 {
            return 1
        }
        
        return 10
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if currentIndex == 1 {
            let cell : ShowPeriodsCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable, for: indexPath) as! ShowPeriodsCell
//            cell.setValueForShowPeriodsCell(index: 10-indexPath.row)
            return cell
        }else if currentIndex == 2 {
            let cell : ShowClassMemberCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable1, for: indexPath) as! ShowClassMemberCell
            return cell

        }else if currentIndex == 3 {
            let cell : TClassInfoCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable2, for: indexPath) as! TClassInfoCell
            cell.TClassInfoCellForStudent()
            return cell
            
        }else{
            let cell : ClassGradeCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable3, for: indexPath) as! ClassGradeCell
            
            if indexPath.row == 0 {
                cell.is1thCell()
            }else{
                cell.setValueForClassGradeCell(index: 10-indexPath.row)
            }
            
            return cell
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if currentIndex == 1 {
            let periodsVC = PeriodsDetailViewController()
            periodsVC.workState = indexPath.row+1
            self.navigationController?.pushViewController(periodsVC, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 && currentIndex == 2 {
            //        密码
            searchTextfield.frame = CGRect(x: 30, y: 150, width: kSCREEN_WIDTH - 110, height: 32)
            searchTextfield.borderStyle = .roundedRect
            searchTextfield.leftViewRect(forBounds: CGRect(x: 0, y: 0, width: 26, height: 17))
            searchTextfield.placeholder = "搜索班级"
            searchTextfield.leftViewMode = .always
            searchTextfield.returnKeyType = .search
            searchTextfield.delegate = self
            
            let view = UIView.init(frame: CGRect(x: 0, y: 0, width: 26, height: 17))
            
            let leftImage = UIImageView.init(frame: CGRect(x: 8, y: 0, width: 17, height: 17))
            leftImage.image = #imageLiteral(resourceName: "search_icon_default")
            
            view.addSubview(leftImage)
            searchTextfield.leftView = view
            return searchTextfield
        }
        
        return UIView()
        
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 && currentIndex == 2 {
            return  80 * kSCREEN_SCALE
        }
        
        if section == 0 && currentIndex == 2 {
            return 30
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 0 && currentIndex == 2 {
            return true
        }
        return false
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
//            mainTableArr.removeObject(at: indexPath.row)
//            tableView.reloadData()
            deBugPrint(item: "删除了---\(indexPath.section)分区-\(indexPath.row)行")
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        
        return "退出班级"
    }

    
    override func viewWillDisappear(_ animated: Bool) {
    }
}
