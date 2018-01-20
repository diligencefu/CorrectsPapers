//
//  ClaswDetailViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/19.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class ClassDetailViewController: BaseViewController,UITextFieldDelegate {
    var typeArr = ["课时目录","班级成员","班级信息","成绩统计"]
    var headView = UIView()
    var buttonView = UIView()
    
    var underLine = UIView()
    var NofitICLabel = AutoScrollLabel()

    var currentIndex = 1
    
    var searchTextfield = UITextField()

    var class_id = ""
    var class_name = ""
    
    //    班级信息
    var InfoModel = LNClassInfoModel()

    //    课时目录
    var Periods = NSMutableArray()
    
    //    班级成员
    var assistantArr = NSMutableArray()
    var studentArr = NSMutableArray()
    
    
    
    //   成绩统计
    var Grades = NSMutableArray()
    
    var resource = LNClassMemberModel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configSubViews() {

        self.navigationItem.title = class_name
        
        headView = UIView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 165*kSCREEN_SCALE))
        headView.backgroundColor = UIColor.white
        
        
        NofitICLabel = AutoScrollLabel.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 64 * kSCREEN_SCALE))
        NofitICLabel.textColor = kSetRGBColor(r: 255, g: 153, b: 0)
        NofitICLabel.setText("通知消息")
        NofitICLabel.backgroundColor = UIColor.white
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
        mainTableView.register(UINib(nibName: "TClassStudentCell", bundle: nil), forCellReuseIdentifier: identyfierTable5)


        self.view.addSubview(mainTableView)
    }
    
    override func requestData() {
        let params = [
            "SESSIONID":Defaults[userToken]!,
            "mobileCode":mobileCode,
            "type":String(currentIndex),
            "classes_id":class_id
        ]
        self.view.beginLoading()
        netWorkForGetClassContents(params: params) { (datas, flag) in
            if flag {
                self.Periods.addObjects(from: datas)
                self.mainTableView.reloadData()
            }
            self.view.endLoading()
        }
        

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        let params1 = [
            "SESSIONID":Defaults[userToken]!,
            "class_id":class_id,
            "mobileCode":mobileCode,
            ] as [String:Any]
        
        NetWorkTeachersGetNotify(params: params1) { (text, flag) in
            if flag {
                
                self.NofitICLabel.setText(text)
            }
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
        
        let line = UIView.init(frame: CGRect(x: 0, y: 88 * kSCREEN_SCALE+1 , width: kSCREEN_WIDTH, height: 1))
        line.backgroundColor = kGaryColor(num: 223)
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
            
            self.underLine.center = CGPoint(x: sender.center.x, y:  self.underLine.center.y)
        })
        
        currentIndex = sender.tag - 130
        
        self.view.beginLoading()
        refreshHeaderAction()
    }
    
    override func refreshHeaderAction() {
        let params = [
            "SESSIONID":Defaults[userToken]!,
            "mobileCode":mobileCode,
            "type":String(currentIndex),
            "classes_id":class_id
        ]
        netWorkForGetClassContents(params: params) { (datas, flag) in
            if flag {
                if self.currentIndex == 1 {
                    
                    self.Periods.removeAllObjects()
                    self.Periods.addObjects(from: datas)
                    self.mainTableView.reloadData()
                }else if self.currentIndex == 2 {
                    
                    if datas.count > 0{
                        self.resource = datas[0] as! LNClassMemberModel
                    }
                    self.mainTableView.reloadData()
                }else if self.currentIndex == 3 {
                    
                    if datas.count > 0{
                        
                        self.InfoModel = datas[0] as! LNClassInfoModel
                    }
                    self.mainTableView.reloadData()
                }else {
                    
                    self.Grades.removeAllObjects()
                    self.Grades.addObjects(from: datas)
                    self.mainTableView.reloadData()
                }
            }
            self.view.endLoading()
            self.mainTableView.mj_header.endRefreshing()
        }

    }
    
    
    //MARK:  ******代理 ：UITableViewDataSource,UITableViewDelegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if currentIndex == 2 {
         
            if section == 0 {
                
                if resource.head_teacher == nil {
                    return 0
                }
                return 1
            }else if section == 1 {
                
                if resource.teacher_class == nil {
                    return 0
                }
                return resource.teacher_class.count
            }else if section == 2{
                
                if resource.teacher_help == nil {
                    return 0
                }
                return resource.teacher_help.count
            }else if section == 3{
                return 1
            }else{
                if resource.student == nil {
                    return 0
                }
                return resource.student.count
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
            return 5
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
            
            if indexPath.section == 0 {

                let cell : TClassStudentCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable5, for: indexPath) as! TClassStudentCell
                cell.showHeadTeacherCell(model: resource.head_teacher)
                return cell
            }else if indexPath.section == 1{
                let cell : TClassStudentCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable5, for: indexPath) as! TClassStudentCell
                cell.showOtherTeachersCell(model: resource.teacher_class[indexPath.row])
                return cell

            }else if indexPath.section == 2{
                
                let cell : TClassStudentCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable5, for: indexPath) as! TClassStudentCell
                cell.showOtherTeachersCell(model: resource.teacher_help[indexPath.row])
                return cell
            }else if indexPath.section == 3{
                
                let cell : TClassStudentCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable5, for: indexPath) as! TClassStudentCell
                if resource.me != nil {
                    cell.showStudentsCell(model: resource.me)
                }
                return cell
            }else{
                let cell : TClassStudentCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable5, for: indexPath) as! TClassStudentCell
                cell.showStudentsCell(model: resource.student[indexPath.row])
                return cell
            }
            
        }else if currentIndex == 3 {
            
            let cell : TClassInfoCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable2, for: indexPath) as! TClassInfoCell
            if InfoModel.class_name != nil {
                cell.TClassInfoCellForStudent(model: InfoModel,isHeadTeacher: false)
            }
            return cell
        }else{
            
            let cell : ClassGradeCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable3, for: indexPath) as! ClassGradeCell
            if Grades.count == 0{
                cell.noDatas()
            }else{
                if indexPath.row == 0 {
                    cell.is1thCell()
                }else{
                    let model = Grades[indexPath.row-1] as! TShowGradeModel
                    cell.setValueForClassGradeCell(model:model)
                }
            }
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if currentIndex == 1 {
            
            let model = Periods[indexPath.row] as! TPeriodsModel
            let periodsVC = PeriodsDetailViewController()
//            periodsVC.workState = indexPath.row-1
            periodsVC.pModel = model
            periodsVC.class_id = class_id
            
            self.navigationController?.pushViewController(periodsVC, animated: true)
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

                textLabel.text = "   班主任"
                textLabel.font = kFont24
                textLabel.textColor = kGaryColor(num: 176)
                BGiew.addSubview(textLabel)
                return BGiew
            }else{
                
                let textLabel = UILabel.init(frame: CGRect(x: 0, y: 39, width: kSCREEN_WIDTH, height: 48*kSCREEN_SCALE))
                if section == 1{
                    if resource.teacher_class != nil {
                        if resource.teacher_class.count == 0{
                            textLabel.text = "   暂无上课老师"
                        }else{
                            textLabel.text = "   上课老师"
                        }
                    }
                }else if section == 2{
                    if resource.teacher_help != nil {
                        if resource.teacher_help.count == 0{
                            textLabel.text = "   暂无助教老师"
                        }else{
                            textLabel.text = "   助教老师"
                        }
                    }
                }else if section == 3{
                    textLabel.text = "   我"
                }else{
                    textLabel.text = "   其他学生"
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
        if indexPath.section == 3 && currentIndex == 2 {
            return true
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
                "classes_id":class_id
            ]

            netWorkForQuitClass(params: params, callBack: { (flag) in
                if flag {
                    //        通知中心
                    NotificationCenter.default.post(name: Notification.Name(rawValue: SuccessCorrectDeleteClassNotiS), object: self, userInfo: ["refresh":"begin"])
                    
                    self.navigationController?.popViewController(animated: true)
                }
            })            
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        
        return "退出班级"
    }

    
    override func viewWillDisappear(_ animated: Bool) {
    }
}
