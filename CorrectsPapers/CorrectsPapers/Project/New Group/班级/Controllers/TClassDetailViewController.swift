//
//  TClassDetailViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/14.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class TClassDetailViewController: BaseViewController,UITextFieldDelegate {

    var typeArr = ["课时目录","班级成员","班级信息","成绩统计"]
    var headView = UIView()
    var buttonView = UIView()

    var underLine = UIView()
    var NofitICLabel = AutoScrollLabel()
    
    var currentIndex = 1
    
    var searchTextfield = UITextField()
    
//    课时目录
    var Periods = NSMutableArray()
    
//    班级成员
    var applyArr = NSMutableArray()
    var assistantArr = NSMutableArray()
    var studentArr = NSMutableArray()
    
    //    班级信息
    var InfoModel = LNClassInfoModel()

    //   成绩统计
    var Grades = NSMutableArray()
    
    var classid = ""
    var className = ""
    var periods_id = ""
    
//    是不是班主任
    var type = "1"
    
    var resource = TClassMemberModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rightBarButton()
        NotificationCenter.default.addObserver(self, selector: #selector(receiveNitification(nitofication:)), name: NSNotification.Name(rawValue: SuccessCorrectClassBuildPeriodNoti), object: nil)
    }
    
    @objc func receiveNitification(nitofication:Notification) {
        self.mainTableView.mj_header.beginRefreshing()
    }

    
    override func requestData() {
        let params = [
            "SESSIONID":Defaults[userToken]!,
            "classes_id":classid,
            "mobileCode":mobileCode,
            "type":type
            ] as [String:Any]
        
        self.view.beginLoading()
        NetWorkTeacherTeacherSelectAllPeriods(params: params) { (datas,flag) in
            
            if flag {
                if datas.count > 0{
                    let model = datas[0] as! TPeriodsModel
                    self.periods_id = model.periods_id
                }
                
                self.Periods.removeAllObjects()
                self.Periods.addObjects(from: datas)
                self.mainTableView.reloadData()
            }
            self.view.endLoading()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let params1 = [
            "SESSIONID":Defaults[userToken]!,
            "class_id":classid,
            "mobileCode":mobileCode,
            ] as [String:Any]
        
        NetWorkTeachersGetNotify(params: params1) { (text, flag) in
            if flag {
                
                self.NofitICLabel.setText(text)
            }
        }
        
    }
    
    
    override func configSubViews() {
        
        self.navigationItem.title = className
        
        headView = UIView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 165*kSCREEN_SCALE))
        headView.backgroundColor = UIColor.white
        
//        let scroll = UIScrollView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 64 * kSCREEN_SCALE))
//        scroll.backgroundColor = UIColor.white
//        scroll.contentSize = CGSize(width: kSCREEN_WIDTH, height: 64 * kSCREEN_SCALE)
//        scroll.bounces = false
//        headView.addSubview(scroll)
        
        NofitICLabel = AutoScrollLabel.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 64 * kSCREEN_SCALE))
        NofitICLabel.textColor = kSetRGBColor(r: 255, g: 153, b: 0)
        NofitICLabel.setText("通知消息")
        NofitICLabel.backgroundColor = UIColor.white
        headView.addSubview(NofitICLabel)
        
        //添加顶部按钮
        updateButtons(titleArr: typeArr)
        self.view.addSubview(headView)
        
        mainTableView = UITableView.init(frame: CGRect(x: 0, y: 162 * kSCREEN_SCALE, width: kSCREEN_WIDTH, height: kSCREEN_HEIGHT - 64 - 165 * kSCREEN_SCALE), style: .plain)
        mainTableView.dataSource = self;
        mainTableView.delegate = self;
        mainTableView.estimatedRowHeight = 342
        mainTableView.tableFooterView = UIView()
        
        mainTableView.register(UINib(nibName: "ShowPeriodsCell", bundle: nil), forCellReuseIdentifier: identyfierTable)
        mainTableView.register(UINib(nibName: "ShowClassMemberCell", bundle: nil), forCellReuseIdentifier: identyfierTable1)
        mainTableView.register(UINib(nibName: "TClassInfoCell", bundle: nil), forCellReuseIdentifier: identyfierTable2)
        mainTableView.register(UINib(nibName: "ClassGradeCell", bundle: nil), forCellReuseIdentifier: identyfierTable3)
        mainTableView.register(UINib(nibName: "TApplyJoinClassCell", bundle: nil), forCellReuseIdentifier: identyfierTable4)
        mainTableView.register(UINib(nibName: "TClassStudentCell", bundle: nil), forCellReuseIdentifier: identyfierTable5)
//        mainTableView.register(UINib(nibName: "ClassGradeCell", bundle: nil), forCellReuseIdentifier: identyfierTable3)

        self.view.addSubview(mainTableView)
    }
    
    
    func rightBarButton(){
        let createClass = UIBarButtonItem.init(image:#imageLiteral(resourceName: "notice_icon"), style: .plain, target: self, action: #selector(pushSearchClass(sender:)))
        createClass.tag = 10086
        
        let searchClass = UIBarButtonItem.init(image: #imageLiteral(resourceName: "AddFriends_icon_default"), style: .plain, target: self, action: #selector(pushSearchClass(sender:)))
        searchClass.tag = 10068
        
        
        if type == "1" {
            self.navigationItem.rightBarButtonItems = [searchClass,createClass,]
        }else{
            self.navigationItem.rightBarButtonItems = [createClass]
        }
        
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
    }
    
    @objc func pushSearchClass(sender:UIBarButtonItem) {
        
        if sender.tag == 10086 {
            
            if type == "1" {
                let notiVC = SuggestViewController()
                notiVC.class_id = classid
                notiVC.isSuggest = false
                notiVC.createNtifiAction = {
                    self.requestData()
                }
                self.navigationController?.pushViewController(notiVC, animated: true)
            }else{
                let classMassage = TShowClassMessageVC()
                self.navigationController?.pushViewController(classMassage, animated: true)
            }
            
            
        }else{
            let chooseMember = TLNChooseTypeViewController()
            chooseMember.class_id = classid
            self.navigationController?.pushViewController(chooseMember, animated: true)
        }
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
        
        let line1 = UIView.init(frame: CGRect(x: 0, y: 2*kSCREEN_SCALE, width: kSCREEN_WIDTH, height: 1))
        line1.backgroundColor = kGaryColor(num: 239)
        buttonView.addSubview(line1)

        
        let line = UIView.init(frame: CGRect(x: 0, y: 87*kSCREEN_SCALE, width: kSCREEN_WIDTH, height: 1))
        line.backgroundColor = kGaryColor(num: 239)
        buttonView.addSubview(line)

        
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
    
    
    override func refreshHeaderAction() {
        
        if currentIndex == 1 {
            
            let params = [
                "SESSIONID":Defaults[userToken]!,
                "classes_id":classid,
                "mobileCode":mobileCode,
                "type":type
            ]
            NetWorkTeacherTeacherSelectAllPeriods(params: params) { (datas,flag) in
                
                if flag {
                    self.Periods.removeAllObjects()
                    self.Periods.addObjects(from: datas)
                    self.mainTableView.reloadData()
                }
                self.view.endLoading()
                self.mainTableView.mj_header.endRefreshing()
            }
        }else if currentIndex == 2 {
            
            let params = [
                "SESSIONID":Defaults[userToken]!,
                "classes_id":classid,
                "mobileCode":mobileCode,
                ]
            NetWorkTeacherGetClassMember(params: params, callBack: { (datas,flag) in
                
                if flag {
                    if datas.count > 0{
                        
                        self.resource = datas[0] as! TClassMemberModel
                    }
                    self.mainTableView.reloadData()
                }
                self.view.endLoading()
                self.mainTableView.mj_header.endRefreshing()
            })
        }else if currentIndex == 3 {
            
            let params = [
                "SESSIONID":Defaults[userToken]!,
                "mobileCode":mobileCode,
                "type":"3",
                "classes_id":classid
            ]
            netWorkForGetClassContents(params: params) { (datas, flag) in
                if datas.count > 0{
                    
                    self.InfoModel = datas[0] as! LNClassInfoModel
                    self.navigationItem.title = self.InfoModel.class_name
                    self.mainTableView.reloadData()
                }
                self.view.endLoading()
                self.mainTableView.mj_header.endRefreshing()
            }
        }else if currentIndex == 4{
            
            let params11 = [
                "SESSIONID":Defaults[userToken]!,
                "classes_id":classid,
                "mobileCode":mobileCode,
                "type":"2"
            ]
            NetWorkTeacherGetStudentScroes(params: params11) { (datas,flag) in
                
                if flag {
                    self.Grades.removeAllObjects()
                    self.Grades.addObjects(from: datas)
                    self.mainTableView.reloadData()
                }
                self.view.endLoading()
                self.mainTableView.mj_header.endRefreshing()
            }
        }
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
        
        self.view.beginLoading()
        refreshHeaderAction()
//        mainTableView.reloadData()
    }
    
    
    //MARK:  ******代理 ：UITableViewDataSource,UITableViewDelegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if currentIndex == 2 {
            
            if type == "1" {
                if section == 0 {
                    
                    if resource.apply != nil{
                        return resource.apply.studentApply.count+resource.apply.teacherApply.count
                    }
                    return 0
                }else if section == 1 {
                    if resource.head_teacher == nil {
                        return 0
                    }
                    return 1
                }else if section == 2 {
                    if resource.teacher == nil {
                        return 0
                    }
                    return resource.teacher.count
                }else{
                    if resource.student == nil {
                        return 0
                    }
                    return resource.student.count
                }

            }else{
             
                if section == 0 {
                    if resource.head_teacher == nil {
                        return 0
                    }
                    return 1
                }else if section == 1 {
                    if resource.teacher == nil {
                        return 0
                    }
                    return resource.teacher.count
                }else{
                    if resource.student == nil {
                        return 0
                    }
                    return resource.student.count
                }
            }
        }
        
        if currentIndex == 3 {
            return 1
        }
        
        if currentIndex == 1 {
            return Periods.count
        }
        
        return Grades.count+1
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        if currentIndex == 2 {
            
            if type == "1" {
                return 4
            }else{
                return 3
            }
        }
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if currentIndex == 1 {
            let model = Periods[indexPath.row] as! TPeriodsModel
            let cell : ShowPeriodsCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable, for: indexPath) as! ShowPeriodsCell
            cell.setValueForShowPeriodsCell(model:model)
            return cell
        }else if currentIndex == 2 {
            
            if type == "1" {
                if indexPath.section == 0 {
                    let cell : TApplyJoinClassCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable4, for: indexPath) as! TApplyJoinClassCell
                    
                    if indexPath.row < resource.apply.studentApply.count {
                        let model = resource.apply.studentApply[indexPath.row]
                        cell.TApplyJoinClassCellForStudent(model: model)
                    }else{
                        let model = resource.apply.teacherApply[indexPath.row-resource.apply.studentApply.count]
                        cell.TApplyJoinClassCellForTeacher(model: model)
                    }
                    
                    cell.disposeApplyBlock = {
                        
                        var userid = ""
                        var type = ""
                        
                        if indexPath.row < self.resource.apply.studentApply.count {
                            let model = self.resource.apply.studentApply[indexPath.row]
                            userid = model.student_id
                            type = "2"
                        }else{
                            let model = self.resource.apply.teacherApply[indexPath.row-self.resource.apply.studentApply.count]
                            userid = model.teacher_id
                            type = "1"
                        }

                        let params = [
                            "SESSIONID":Defaults[userToken]!,
                            "mobileCode":Defaults[mCode]!,
                            "userId":userid,
                            "class_id":self.classid,
                            "state":$0,
                            "type":type,
                            ]
                        NetWorkTeachersApplyOkTeacher(params: params, callBack: { (flag) in
                            if flag {
                                self.mainTableView.mj_header.beginRefreshing()
                            }
                        })
                    }
                    
                    return cell
                }else if indexPath.section == 1{
                    
                    let cell : TClassStudentCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable5, for: indexPath) as! TClassStudentCell
                    cell.showHeadTeacherCell(model: resource.head_teacher)
                    return cell
                }else if indexPath.section == 2{
                    
                    let cell : TClassStudentCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable5, for: indexPath) as! TClassStudentCell
                    cell.showOtherTeachersCell(model: resource.teacher[indexPath.row])
                    return cell
                }else{
                    
                    let cell : TClassStudentCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable5, for: indexPath) as! TClassStudentCell
                    cell.showStudentsCell(model: resource.student[indexPath.row])
                    return cell
                }

            }else{
            
                if indexPath.section == 0{
                    
                    let cell : TClassStudentCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable5, for: indexPath) as! TClassStudentCell
                    cell.showHeadTeacherCell(model: resource.head_teacher)
                    return cell
                }else if indexPath.section == 1{
                    
                    let cell : TClassStudentCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable5, for: indexPath) as! TClassStudentCell
                    cell.showOtherTeachersCell(model: resource.teacher[indexPath.row])
                    return cell
                }else{
                    
                    let cell : TClassStudentCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable5, for: indexPath) as! TClassStudentCell
                    cell.showStudentsCell(model: resource.student[indexPath.row])
                    return cell
                }
            }
            
        }else if currentIndex == 3 {
            
            let cell : TClassInfoCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable2, for: indexPath) as! TClassInfoCell
            if InfoModel.class_name != nil {
                
                var isHeadTeacher = false
                
                if type == "1" {
                    isHeadTeacher = true
                }
                
                cell.editActionBlock = {
                    let editClassVC = TCreateClassViewController()
                    editClassVC.classInfo = self.InfoModel
                    editClassVC.headImage = cell.classIcon.image!
                    editClassVC.class_id = self.classid
                    self.navigationController?.pushViewController(editClassVC, animated: true)
                }
                
                cell.TClassInfoCellForStudent(model: InfoModel,isHeadTeacher:isHeadTeacher)
            }
            return cell
        }else{
            
            let cell : ClassGradeCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable3, for: indexPath) as! ClassGradeCell
            
            if Grades.count == 0{
                cell.noDatas()
            }else{
                if indexPath.row == 0 {
                    cell.is1thCellForWorkBook()
                }else{
                    let model = Grades[indexPath.row-1] as! TShowGradeModel
                    cell.setValueForClassGradeCellTeacher(model:model)
                }
            }
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if currentIndex == 1 {
            
            let model = Periods[indexPath.row] as! TPeriodsModel
            if model.name.count == 0 && type == "1" {
                
                let buildPeriodVC = LNBuildPeriodViewController()
                buildPeriodVC.period_id = model.periods_id
                self.navigationController?.pushViewController(buildPeriodVC, animated: true)
            }else{
                let periodsVC = TPeriodsDetailViewController()
                periodsVC.periods_id = model.periods_id
                periodsVC.periodsName = model.name
                periodsVC.class_id = classid
                self.navigationController?.pushViewController(periodsVC, animated: true)
            }
        }
        
        if currentIndex == 4 {
            if indexPath.row != 0 {
                let model = Grades[indexPath.row-1] as! TShowGradeModel
                let showVC = TShowOneGradeVCViewController()
                showVC.user_num = model.studentId
                showVC.classid = classid
                showVC.user_name = model.user_name
                showVC.user_num = model.student_id!
                self.navigationController?.pushViewController(showVC, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if currentIndex == 2 {
            if section == 0{
                
                let BGiew = UIView.init(frame:CGRect(x: 0, y: 0, width: kSCREEN_WIDTH , height: 43 + 48*kSCREEN_SCALE))
                BGiew.backgroundColor = UIColor.white
                searchTextfield.frame = CGRect(x: 15*kSCREEN_SCALE, y: 4, width: kSCREEN_WIDTH-30*kSCREEN_SCALE , height: 35)
                searchTextfield.borderStyle = .none
                searchTextfield.layer.cornerRadius = 6*kSCREEN_SCALE
                searchTextfield.clipsToBounds = true
                searchTextfield.leftViewRect(forBounds: CGRect(x: 0, y: 0, width: 35, height: 17))
                searchTextfield.placeholder = "学生姓名/学号"
                searchTextfield.leftViewMode = .always
                searchTextfield.returnKeyType = .search
                searchTextfield.clearButtonMode = .whileEditing
                searchTextfield.backgroundColor = kGaryColor(num: 243)
                searchTextfield.addTarget(self, action: #selector(textFieldDidChange(textfield:)), for: .editingChanged)
                searchTextfield.delegate = self
                
                let view = UIView.init(frame: CGRect(x: 0, y: 0, width: 35, height: 17))
                let leftImage = UIImageView.init(frame: CGRect(x: 11, y: 0, width: 17, height: 17))
                leftImage.image = #imageLiteral(resourceName: "search_icon_default")
                view.addSubview(leftImage)
                searchTextfield.leftView = view
                BGiew.addSubview(searchTextfield)
                
                let textLabel = UILabel.init(frame: CGRect(x: 0, y: 39, width: kSCREEN_WIDTH, height: 48*kSCREEN_SCALE))
                
                if type == "1" {
                    if resource.apply != nil{
                        if resource.apply.teacherApply.count == 0 && resource.apply.studentApply.count == 0 {
                            textLabel.text = "   暂无加入班级申请"
                        }else{
                            textLabel.text = "   申请加入"
                        }
                    }
                }else{
                    textLabel.text = "   班主任"
                }
                
                textLabel.font = kFont24
                textLabel.textColor = kGaryColor(num: 176)
                BGiew.addSubview(textLabel)
                return BGiew
            }else{
                
                let textLabel = UILabel.init(frame: CGRect(x: 0, y: 39, width: kSCREEN_WIDTH, height: 48*kSCREEN_SCALE))
                
                if type == "1" {
                    if section == 1{
                        textLabel.text = "   班主任"
                    }else if section == 2{
                        
                        if resource.teacher != nil && resource.teacher.count>0 {
                            textLabel.text = "   老师"
                        }else{
                            textLabel.text = "   暂无老师"
                        }
                        
                    }else{
                        if resource.student != nil && resource.student.count>0 {
                            textLabel.text = "   学生"
                        }else{
                            textLabel.text = "   暂无学生"
                        }
                    }
                    
                }else{
                    if section == 1{
                        if resource.teacher != nil && resource.teacher.count>0 {
                            textLabel.text = "   老师"
                        }else{
                            textLabel.text = "   暂无老师"
                        }
                        
                    }else{
                        if resource.student != nil && resource.student.count>0 {
                            textLabel.text = "   学生"
                        }else{
                            textLabel.text = "   暂无学生"
                        }
                    }
                }
                textLabel.backgroundColor = kGaryColor(num: 243)
                textLabel.font = kFont24
                textLabel.textColor = kGaryColor(num: 176)
                return textLabel
            }
        }
        return UIView()
    }
    
    
    @objc func textFieldDidChange(textfield:UITextField) {
        
        if textfield.text?.count == 0 {
            setToast(str: "取消搜索")
//            isSearching = false
            mainTableView.reloadData()
            textfield.resignFirstResponder()
        }
    }
    
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if currentIndex == 2 {
            
            if section == 0 {
                return  48 * kSCREEN_SCALE+43
            }else{
                return 48 * kSCREEN_SCALE
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        if currentIndex == 2 {
            
            if type == "1" {
                
                return true
            }else{
                if indexPath.section == 0 {
                    
                    if resource.head_teacher.isMe == "yes" {
                        return true
                    }
                }else if indexPath.section == 1 {
                    
                    if resource.teacher[indexPath.row].isMe == "yes" {
                        return true
                    }
                }
            }
        
        }
        return false
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let params = [
                "SESSIONID":Defaults[userToken]!,
                "mobileCode":mobileCode,
                "classes_id":classid
            ]
            if type == "1" {
                if indexPath.section == 1 {
                    NetWorkTeacherDeleteMyclasses(params: params, callBack: { (flag) in
                        if flag {
                            //        通知中心
                            NotificationCenter.default.post(name: Notification.Name(rawValue: SuccessCorrectDeleteClassNoti), object: self, userInfo: ["refresh":"begin"])
                            
                            self.navigationController?.popViewController(animated: true)
                        }
                    })
                }else{
                    
                    var user_id = ""
                    if indexPath.section == 2{
                        user_id = resource.teacher[indexPath.row].teacher_id
                    }else{
                        user_id = resource.student[indexPath.row].student_id
                    }
                    let params = [
                        "SESSIONID":Defaults[userToken]!,
                        "mobileCode":mobileCode,
                        "userId":user_id,
                        "classes_id":classid
                    ]
                    NetWorkTeachersDelclassPelTeacher(params: params, callBack: { (flag) in
                        if flag {
                            self.mainTableView.mj_header.beginRefreshing()
                        }
                    })
                }
            }else{
                NetWorkTeachersOutOfClass(params: params, callBack: { (flag) in
                    if flag {
                        //        通知中心
                        NotificationCenter.default.post(name: Notification.Name(rawValue: SuccessCorrectDeleteClassNoti), object: self, userInfo: ["refresh":"begin"])

                        self.navigationController?.popViewController(animated: true)
                    }
                })
            }
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        
        if type == "1" {
            if indexPath.section == 1 {
                return "解散班级"
            }else{
                return "删除成员"
            }
        }
        return "退出班级"
    }

}
