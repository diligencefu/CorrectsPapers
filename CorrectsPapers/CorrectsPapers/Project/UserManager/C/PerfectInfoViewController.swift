//
//  PerfectInfoViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/31.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class PerfectInfoViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate{

    var isTeacher = false
    
    var phoneNum = ""
    var Thecode = ""
    var passWord = ""
    
    var gradeStr = ""
    var areaStr = ""
    var subjectStr = ""
    var workTime = ""
    var academic = ""

    var dataArr = [Array<String>]()
    var infoArr = [Array<String>]()
    
    var proArr = [String]()
    var gradeArr = [String]()
    
    let identyfierTable  = "identyfierTable"
    let identyfierTable1 = "identyfierTable1"
    let identyfierTable2 = "identyfierTable2"
    let identyfierTable3 = "identyfierTable3"
    let identyfierTable4 = "identyfierTable4"
    let identyfierTable5 = "identyfierTable5"

    var mainTableView = UITableView()
    //    数据源
    var mainTableArr = NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        configSubViews()
        addTagsView()
    }
        
    
    func configSubViews() {
        
        mainTableArr =  []
        
        if isTeacher {
            self.navigationItem.title = "老师基本信息录入"
            
            dataArr = [["我的名称","邮箱账号","当前学历","所在城市"],["批改科目","适合年级","工作时间"]]
            infoArr = [["输入真实姓名","填写我的邮箱","选择我的学历","选择所在地"],["选择适合科目","选择适合年级","选择工作时间"]]
        }else{
            self.navigationItem.title = "学生基本信息录入"
            
            dataArr = [["我的名称","所在地区","所在年级"]]
            infoArr = [["输入真实姓名","选择所在地","选择我的年级"]]
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
        
        self.navigationController?.navigationBar.setBackgroundImage(getNavigationIMG(64, fromColor: kSetRGBColor(r: 0, g: 200, b: 255), toColor: kSetRGBColor(r: 0, g: 160, b: 255)), for: .default)
        
        self.navigationItem.leftBarButtonItem?.tintColor = kSetRGBColor(r: 255, g: 255, b: 255)
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        UIApplication.shared.statusBarStyle = .lightContent

        
        self.navigationController?.navigationBar.isTranslucent = false
        self.view.backgroundColor = kBGColor()

        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: #imageLiteral(resourceName: "back_icon_default"), style: .done, target: self, action: #selector(backAction(sender:)))
        //        返回手势
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
        
    }
    
    //    返回事件
    @objc func backAction(sender:UIBarButtonItem) -> Void {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func loginAction() {
//        Defaults[username] = "nil"
//        Defaults[userToken] = "nil"
//        
//        if isTeacher {
//            Defaults[userIdentity] = kTeacher
//        }else{
//            Defaults[userIdentity] = kStudent
//        }
//        
//        //        self.view.window?.rootViewController = MainTabBarController()
        
        var params = [String:Any]()
        let cell = mainTableView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as! TeacherInfoCell1
        let cell1 = mainTableView.cellForRow(at: IndexPath.init(row: 1, section: 0)) as! TeacherInfoCell1
        
        if cell.textField.text?.count == 0{
            setToast(str: "请输入姓名")
            return
        }

        if isTeacher {
            
            if !validateEmail(email: cell1.textField.text!) {
                setToast(str: "请输入正确的邮箱账号")
                return
            }
            
            if infoArr[0][2] == "选择我的学历" {
                setToast(str: "请选择学历")
                return
            }

            if infoArr[0][3] == "选择所在地" {
                setToast(str: "请选择所在地")
                return
            }
            
            if infoArr[1][0] == "选择适合科目" {
                setToast(str: "请选择适合科目")
                return
            }
            
            if infoArr[1][1] == "选择适合年级" {
                setToast(str: "请选择适合年级")
                return
            }
            
            if infoArr[1][2] == "选择我的工作时间" {
                setToast(str: "请选择工作时间")
                return
            }
            
            params =
                ["phone":phoneNum,
                 "password":passWord,
                 "content":Thecode,
                 "name":cell.textField.text!,
                 "area_id":infoArr[0][3],
                 "userFitClass":infoArr[1][1],
                 "email":cell1.textField.text!,
                 "subject_id":infoArr[1][0],
                 "education":infoArr[0][2],
                 "working_time":infoArr[1][2],
                 "user_type":"2",
                 "type":"1",
            ]
        }else{
            
            if infoArr[0][1] == "选择所在地" {
                setToast(str: "请选择所在地")
                return
            }
            
            if infoArr[0][2] == "选择我的年级" {
                setToast(str: "请选择所在年级")
                return
            }

            params =
                ["phone":phoneNum,
                 "password":passWord,
                 "content":Thecode,
                 "name":cell.textField.text!,
                 "area_id":infoArr[0][1],
                 "userFitClass":infoArr[0][2],
                 "user_type":"1",
                 "type":"1"
            ]
        }
        
        netWorkForRegistAccount(params: params) { (code) in
            
            if code {
//                学生
                if !self.isTeacher {
                    Defaults[userIdentity] = kStudent
                    Defaults[username] = cell.textField.text!
                    Defaults[userArea] = self.infoArr[0][1]
//                    Defaults[userId] = "学号 008"
                    Defaults[userGrade] = self.infoArr[0][2]
                    
                }else{
//                    老师
                    Defaults[userIdentity] = kTeacher
                    Defaults[username] = cell.textField.text!
                    Defaults[userArea] = self.infoArr[0][3]
//                    Defaults[userId] = "学号 008"
                    Defaults[userGrade] = self.infoArr[1][1]
                }

                self.view.window?.rootViewController = MainTabBarController()
            }
        }
//
//        if !self.isTeacher {
//            Defaults[userIdentity] = kStudent
//            Defaults[username] = self.infoArr[0][0]
//            Defaults[userArea] = self.infoArr[0][1]
//            Defaults[userToken] = "userToken"
//            Defaults[userId] = "学号 008"
//            //                    Defaults[userIcon] = kTeacher
//            Defaults[userGrade] = self.infoArr[0][2]
//        }else{
//
//            self.infoArr = [["输入真实姓名","填写邮箱","本科","武汉"],["语文数学","一二三年级","12：00-14：00"]]
//
//            Defaults[userIdentity] = kTeacher
//            Defaults[username] = self.infoArr[0][0]
//            Defaults[userArea] = self.infoArr[0][2]
//            //                    Defaults[userId] = kTeacher
//            Defaults[userId] = "学号 008"
//            //                    Defaults[userIcon] = kTeacher
//            Defaults[userGrade] = self.infoArr[0][3]
//        }
//
//        self.view.window?.rootViewController = MainTabBarController()

    }
    
    
    //MARK:  ******代理 ：UITableViewDataSource,UITableViewDelegate
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataArr[section].count
    }
    
     func numberOfSections(in tableView: UITableView) -> Int {
        
        if isTeacher {
            return 2
        }
        return 1
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : TeacherInfoCell1 = tableView.dequeueReusableCell(withIdentifier: identyfierTable, for: indexPath) as! TeacherInfoCell1
        
        let title = dataArr[indexPath.section][indexPath.row]
        let subTitle = infoArr[indexPath.section][indexPath.row]
        
        if isTeacher {
            if indexPath.section == 0 && indexPath.row < 2{
                cell.selectionStyle = .none
                cell.TeacherInfoCellForSection2(title: title, subStr: subTitle)
                cell.accessoryType = .none
            }else{
                cell.TeacherInfoCellForNormal(title: title, subStr: subTitle)
            }
        }else{
            if indexPath.row == 0   {
                cell.accessoryType = .none
                cell.TeacherInfoCellForSection2(title: title, subStr: subTitle)
            }else{
                cell.TeacherInfoCellForNormal(title: title, subStr: subTitle)
            }
        }
        
        return cell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if isTeacher {
            if indexPath.section == 0 {
                
                if indexPath.row == 2 {
                    showAcademicView()
                }

                if indexPath.row == 3 {
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
    
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 {
            return 0
        }
        return 19 * kSCREEN_SCALE
    }
    
     func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01 * kSCREEN_SCALE
    }
    
    
    var BGView = UIView()
    var projectTagsView = ShowTagsView()
    var gradeTagsView = ShowTagsView()
    var timeView = ShowTagsView()
    var areaView = ChooseCityView()
    var academicView = ShowTagsView()
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
            self.academicView.transform = .identity
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
        BGView = UIView.init(frame: self.view.bounds)
        BGView.backgroundColor = kSetRGBAColor(r: 5, g: 5, b: 5, a: 0.5)
        BGView.alpha = 0

        
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
        
        
        
        areaView = UINib(nibName:"ChooseCityView",bundle:nil).instantiate(withOwner: self, options: nil).first as! ChooseCityView
//        areaView.ShowTagsViewForChooseEdu(title: "选择地区", index: 0)
        areaView.frame =  CGRect(x: 0, y: kSCREEN_HEIGHT, width: kSCREEN_WIDTH, height: 350)
        areaView.layer.cornerRadius = 24*kSCREEN_SCALE
        areaView.selectBlock = {
            if $1 {
                
                if self.isTeacher {
                    
                    self.infoArr[0][3] = $0
                    self.mainTableView.reloadRows(at: [IndexPath.init(row: 3, section: 0)], with: .automatic)
                }else{
                    
                    self.infoArr[0][1] = $0
                    self.mainTableView.reloadRows(at: [IndexPath.init(row: 1, section: 0)], with: .automatic)
                }
            }
            self.hiddenViews()
        }
        areaView.clipsToBounds = true
        self.view.addSubview(areaView)
        
        
        
        academicView = UINib(nibName:"ShowTagsView",bundle:nil).instantiate(withOwner: self, options: nil).first as! ShowTagsView
        academicView.ShowTagsViewForChooseEdu(title: "选择学历", index: 10002)
        academicView.frame =  CGRect(x: 0, y: kSCREEN_HEIGHT, width: kSCREEN_WIDTH, height: 280)
        academicView.layer.cornerRadius = 24*kSCREEN_SCALE
        academicView.selectBlock = {
            if !$1 {
                self.infoArr[0][2] = $0
                self.mainTableView.reloadRows(at: [IndexPath.init(row: 2, section: 0)], with: .automatic)
            }
            self.hiddenViews()
        }
        
        academicView.clipsToBounds = true
        self.view.addSubview(academicView)
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
    
    
    
    func showAcademicView() -> Void {
        let y = CGFloat(265)
        UIView.animate(withDuration: 0.5) {
            self.academicView.transform = .init(translationX: 0, y: -y)
            self.BGView.alpha = 1
        }
    }
}
