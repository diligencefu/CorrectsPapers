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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "保存", style: .plain, target: self, action: #selector(pushToSetting(sender:)))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
    }
    
    @objc func pushToSetting(sender:UIBarButtonItem) {
        let setVC = SettingViewController()
        self.navigationController?.pushViewController(setVC, animated: true)
        
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
            return cell
        }else{
            let cell : EditInfoCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable1, for: indexPath) as! EditInfoCell

            if indexPath.section == 1 && indexPath.row == 1 {
                cell.EditInfoCellForFill(title: dataArr[indexPath.section][indexPath.row])
         
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
        
    }
}
