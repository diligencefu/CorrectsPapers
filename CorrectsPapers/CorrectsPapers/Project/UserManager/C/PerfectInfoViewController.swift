//
//  PerfectInfoViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/31.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class PerfectInfoViewController: BaseViewController {

    var isTeacher = false
    
    var phoneNum = ""
    var Thecode = ""
    var passWord = ""
    
    
    
    
    var dataArr = [Array<String>]()
    var infoArr = [Array<String>]()
    
    var proArr = [String]()
    var gradeArr = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTagsView()
        
        
        
    }
    
    
    override func configSubViews() {
        
        mainTableArr =  []
        
        if isTeacher {
            self.navigationItem.title = "老师基本信息录入"
            
            dataArr = [["我的名称","邮箱账号","当前学历","所在城市"],["批改科目","适合年级","工作时间"]]
            infoArr = [["付耀辉","diligencefu@sina.com","三年级","武汉"],["语文数学","一二三年级","12：00-14：00"]]
        }else{
            self.navigationItem.title = "学生基本信息录入"
            
            dataArr = [["我的名称","所在地区","所在年级"]]
            infoArr = [["付耀辉","武汉","三年级"]]
        }
        
        mainTableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: kSCREEN_HEIGHT - 64 ), style: .plain)
        mainTableView.dataSource = self;
        mainTableView.delegate = self;
        mainTableView.estimatedRowHeight = 143 * kSCREEN_SCALE;
        mainTableView.register(UINib(nibName: "TeacherInfoCell1", bundle: nil), forCellReuseIdentifier: identyfierTable)
        self.view.addSubview(mainTableView)
        
        
        let footView = UIView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 120))
        //        footView.backgroundColor = kSetRGBColor(r: 239, g: 239, b: 244)
        let login = UIButton.init(frame: CGRect(x: 60 * kSCREEN_SCALE, y: 50, width: kSCREEN_WIDTH - 120 * kSCREEN_SCALE, height: 86 * kSCREEN_SCALE))
        //        footView.backgroundColor = UIColor.brown
        login.layer.cornerRadius = 6
        login.clipsToBounds = true
        login.setTitle("完成注册", for: .normal)
        login.setTitleColor(UIColor.white, for: .normal)
        login.setBackgroundImage((getNavigationIMG(27, fromColor: kSetRGBColor(r: 0, g: 200, b: 255), toColor: kSetRGBColor(r: 0, g: 162, b: 255))), for: .normal)
        login.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        footView.addSubview(login)
        mainTableView.tableFooterView = footView
        
    }
    
    
    override func requestData() {
        
    }
    
    @objc func loginAction() {
        Defaults[username] = "nil"
        Defaults[userToken] = "nil"
        
        if isTeacher {
            Defaults[userIdentity] = kTeacher
        }else{
            Defaults[userIdentity] = kStudent
        }
        
        //        self.view.window?.rootViewController = MainTabBarController()
        
        var params = [String:Any]()
        
        
        if isTeacher {
            //            params = ["phone":phoneNum,
            //                      "password":passWord,
            //                      "content":Thecode,
            //                      "name":infoArr[0][0],
            //                      "area_id":"1",
            //                      "class_id":"1",
            //                      "email":infoArr[0][1],
            //                      "subject_id":"1",
            //                      "education":"1",
            //                      "working_time":infoArr[1][2],
            //                      "user_type":"2",
            //                      "type":"1",
            //                     ]
            
            params =
                ["phone":"18939636603",
                 "password":"123456",
                 "content":"256485",
                 "name":"我的",
                 "area_id":"1",
                 "userFitClass":"1",
                 "user_type":"1",
                 "type":"1",
                 "email":"diligencefu@sina.com",
                 "subject_id":"1",
                 "education":"1",
                 "working_time":"14:00-18:00"
            ]
            
        }else{
            //            params =
            //                ["phone":phoneNum,
            //                 "password":passWord,
            //                 "content":Thecode,
            //                 "name":infoArr[0][0],
            //                 "area_id":"1",
            //                 "class_id":"1",
            //                 "user_type":"1",
            //                 "type":"1"
            //                ]
            
            params =
                ["phone":phoneNum,
                 "password":"123456",
                 "content":"256485",
                 "name":"我的",
                 "area_id":"1",
                 "userFitClass":"1",
                 "user_type":"1",
                 "type":"1"
            ]
        }
        
        netWorkForRegistAccount(params: params) { (code) in
            Defaults[username] = "nil"
            Defaults[userToken] = "nil"
            
            if code == "haha" {
                
            }
        }
        
        if self.isTeacher {
            Defaults[userIdentity] = kTeacher
        }else{
            Defaults[userIdentity] = kStudent
        }
        
        self.view.window?.rootViewController = MainTabBarController()

        
    }
    
    
    //MARK:  ******代理 ：UITableViewDataSource,UITableViewDelegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataArr[section].count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        if isTeacher {
            return 2
        }
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : TeacherInfoCell1 = tableView.dequeueReusableCell(withIdentifier: identyfierTable, for: indexPath) as! TeacherInfoCell1
        
        let title = dataArr[indexPath.section][indexPath.row]
        let subTitle = infoArr[indexPath.section][indexPath.row]
        
        if isTeacher {
            if indexPath.section == 0 && indexPath.row < 2{
                cell.selectionStyle = .none
                cell.TeacherInfoCellForSection2(title: title, subStr: subTitle)
            }else{
                cell.TeacherInfoCellForNormal(title: title, subStr: subTitle)
            }
        }else{
            if indexPath.row == 0   {
                cell.TeacherInfoCellForSection2(title: title, subStr: subTitle)
            }else{
                cell.TeacherInfoCellForNormal(title: title, subStr: subTitle)
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        if isTeacher {
            if indexPath.section == 0 {
                
                if indexPath.row == 2 {
                    showAreaView()
                    
                }
                
            }else {
                
                if indexPath.row == 0 {
                    showTheProjectTagsView()
                }
                
                if indexPath.row == 1 {
                    showGradeTagsView()
                }
                
                if indexPath.row == 2 {
                    
                    showTimeView()
                }
                
            }
        }else{
            
            if indexPath.row == 1 {
                showAreaView()
            }else if indexPath.row == 2 {
                showGradeTagsView()
            }
            
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 19 * kSCREEN_SCALE))
        
        view.backgroundColor = kSetRGBColor(r: 239, g: 239, b: 244)
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
    
    
    var BGView = UIView()
    
    var projectTagsView = ShowTagsView()
    var gradeTagsView = ShowTagsView()
    var timeView = ShowTagsView()
    var areaView = ShowTagsView()
    var totalNum = 1
    
    
    @objc func showChooseCondi(tap:UITapGestureRecognizer) -> Void {
        if tap.view?.alpha == 1 {
            
            UIView.animate(withDuration: 0.5) {
                tap.view?.alpha = 0
                self.projectTagsView.transform = .identity
                self.gradeTagsView.transform = .identity
                self.timeView.transform = .identity
                self.areaView.transform = .identity
            }
        }
    }
    
    func hiddenViews() {
        UIView.animate(withDuration: 0.5) {
            self.BGView.alpha = 0
            self.projectTagsView.transform = .identity
            self.gradeTagsView.transform = .identity
            self.timeView.transform = .identity
            self.areaView.transform = .identity
        }
        
    }
    
    
    //    视图TagView
    func addTagsView() {
        
        if isTeacher {
            totalNum = 3
        }else{
            totalNum = 1
        }
        //        弹出视图弹出来之后的背景蒙层
        BGView = UIView.init(frame: self.view.frame)
        BGView.backgroundColor = kSetRGBAColor(r: 5, g: 5, b: 5, a: 0.5)
        BGView.alpha = 0
        //        BGView.isHidden = true
        
        let tapGes1 = UITapGestureRecognizer.init(target: self, action: #selector(showChooseCondi(tap:)))
        tapGes1.numberOfTouchesRequired = 1
        BGView.addGestureRecognizer(tapGes1)
        self.view.addSubview(BGView)
        
        
        projectTagsView = UINib(nibName:"ShowTagsView",bundle:nil).instantiate(withOwner: self, options: nil).first as! ShowTagsView
        projectTagsView.ShowTagsViewForProjects(title: "选择批改科目")
        projectTagsView.frame =  CGRect(x: 0, y: kSCREEN_HEIGHT, width: kSCREEN_WIDTH, height: 190+206*kSCREEN_SCALE)
        projectTagsView.layer.cornerRadius = 24*kSCREEN_SCALE
        projectTagsView.selectBlock = {
            if !$1 {
                self.infoArr[1][0] = $0
                self.mainTableView.reloadRows(at: [IndexPath.init(row: 0, section: 1)], with: .automatic)
            }
            self.hiddenViews()
        }
        projectTagsView.clipsToBounds = true
        self.view.addSubview(projectTagsView)
        
        gradeTagsView = UINib(nibName:"ShowTagsView",bundle:nil).instantiate(withOwner: self, options: nil).first as! ShowTagsView
        gradeTagsView.ShowTagsViewForGrades(title: "选择适合年级",total: totalNum)
        gradeTagsView.frame =  CGRect(x: 0, y: kSCREEN_HEIGHT, width: kSCREEN_WIDTH, height: 190+287*kSCREEN_SCALE)
        gradeTagsView.layer.cornerRadius = 24*kSCREEN_SCALE
        gradeTagsView.selectBlock = {
            if !$1 {
                
                if self.isTeacher {
                    self.infoArr[1][1] = $0
                    self.mainTableView.reloadRows(at: [IndexPath.init(row: 1, section: 1)], with: .automatic)
                    
                }else{
                    self.infoArr[0][2] = $0
                    self.mainTableView.reloadSections([0], with: .automatic)
                }
                
            }
            self.hiddenViews()
        }
        
        gradeTagsView.clipsToBounds = true
        self.view.addSubview(gradeTagsView)
        
        timeView = UINib(nibName:"ShowTagsView",bundle:nil).instantiate(withOwner: self, options: nil).first as! ShowTagsView
        timeView.ShowTagsViewForChooseEdu(title: "选择工作时间", index: 1)
        timeView.frame =  CGRect(x: 0, y: kSCREEN_HEIGHT, width: kSCREEN_WIDTH, height: 280)
        timeView.layer.cornerRadius = 24*kSCREEN_SCALE
        timeView.selectBlock = {
            if !$1 {
                self.infoArr[1][2] = $0
                self.mainTableView.reloadRows(at: [IndexPath.init(row: 2, section: 1)], with: .automatic)
            }
            self.hiddenViews()
        }
        
        timeView.clipsToBounds = true
        self.view.addSubview(timeView)
        
        areaView = UINib(nibName:"ShowTagsView",bundle:nil).instantiate(withOwner: self, options: nil).first as! ShowTagsView
        areaView.ShowTagsViewForChooseEdu(title: "选择地区", index: 0)
        areaView.frame =  CGRect(x: 0, y: kSCREEN_HEIGHT, width: kSCREEN_WIDTH, height: 350)
        areaView.layer.cornerRadius = 24*kSCREEN_SCALE
        areaView.selectBlock = {
            if !$1 {
                
                if self.isTeacher {
                    self.infoArr[0][2] = $0
                    self.mainTableView.reloadRows(at: [IndexPath.init(row: 2, section: 0)], with: .automatic)
                    
                }else{
                    self.infoArr[0][1] = $0
                    self.mainTableView.reloadRows(at: [IndexPath.init(row: 1, section: 0)], with: .automatic)
                    
                }
                
            }
            self.hiddenViews()
        }
        
        areaView.clipsToBounds = true
        self.view.addSubview(areaView)
        
    }
    
    func showTheProjectTagsView() -> Void {
        let y = 180+206*kSCREEN_SCALE
        
        UIView.animate(withDuration: 0.5) {
            self.projectTagsView.transform = .init(translationX: 0, y: -y)
            self.BGView.alpha = 1
        }
        
    }
    
    func showGradeTagsView() -> Void {
        let y = 180+287*kSCREEN_SCALE
        
        UIView.animate(withDuration: 0.5) {
            self.gradeTagsView.transform = .init(translationX: 0, y: -y)
            self.BGView.alpha = 1
        }
    }
    
    func showTimeView() -> Void {
        let y = CGFloat(265)
        UIView.animate(withDuration: 0.5) {
            self.timeView.transform = .init(translationX: 0, y: -y)
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


      
