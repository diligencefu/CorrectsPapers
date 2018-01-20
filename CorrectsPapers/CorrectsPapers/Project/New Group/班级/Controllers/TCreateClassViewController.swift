//
//  TCreateClassViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/21.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyJSON
import SwiftyUserDefaults

class TCreateClassViewController: BaseViewController {
    
    var dataArr = [Array<String>]()
    var infoArr = [Array<String>]()
    
    var teachers = ["添加助教老师","添加上课老师"]
    
    var students = ["批量添加学生"]
    var addedStudents = [ApplyModel]()
    
//    助教老师
    var teachers1 = [String]()
    var teachers1Added = [ApplyModel]()

//    上课老师
    var teachers2 = [String]()
    var teachers2Added = [ApplyModel]()

    var classInfo = LNClassInfoModel()
    var class_id = ""
    
    
    var headImage = #imageLiteral(resourceName: "UserHead_128_default")
    
    var headImageStr = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rightBarButton()
        addTagsView()
    }
    
    func rightBarButton() {
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "完成", style: .plain, target: self, action: #selector(classCreateDone(sender:)))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
    }
    
    
    @objc func classCreateDone(sender:UIBarButtonItem) {
        
        
        let cell = self.mainTableView.cellForRow(at: IndexPath.init(row: 1, section: 0)) as! CreateClassCell2
        
        let cell1 = self.mainTableView.cellForRow(at: IndexPath.init(row: 2, section: 1)) as! CreateClassCell2

        if cell.textField.text?.count == 0 {
            setToast(str: "请输入班级名字")
            return
        }
        
        if (cell.textField.text?.count)! > 16 {
            setToast(str: "班级名字长度超过限制")
            return
        }
        
        if classInfo.class_name == nil {
            
            if headImage == #imageLiteral(resourceName: "UserHead_128_default") {
                setToast(str: "请选择班级头像")
                return
            }
            
            if cell1.textField.text?.count == 0 {
                setToast(str: "请输入课时数")
                return
            }
            
            if Int(cell1.textField.text!) == nil {
                setToast(str: "请输入正确的课时数")
                return
            }

            var class_t = [String]()
            var help_t = [String]()
            var student = [String]()
            
            for model in teachers2Added {
                class_t.append(model.freind_id)
            }
            
            for model in teachers1Added {
                help_t.append(model.freind_id)
            }
            
            for model in addedStudents {
                student.append(model.freind_id)
            }
            
            let params = [
                "SESSIONID":Defaults[userToken]!,
                "mobileCode":mobileCode,
                "class_name":cell.textField.text!,
                "periods":cell1.textField.text!,
                "delivery_cycle":infoArr[1][0],
                "work_times":infoArr[1][1],
                "deadline":infoArr[1][2],
                "teachers":class_t.joined(separator: ","),
                "teachers_help":help_t.joined(separator: ","),
                "students":student.joined(separator: ",")
            ]
            
            netWorkForInsertClasses(params: params, data: [headImage], name: [], success: { (datas) in
                
                let json = JSON(datas)
                deBugPrint(item: json)
                if json["code"].stringValue == "0" {
                    setToast(str: "创建失败")
                }else{
                    setToast(str: "创建成功")
                    self.navigationController?.popViewController(animated: true)
                }
                
                deBugPrint(item: datas)
            }) { (error) in
                
            }
        }else{
            
            let params = [
                "SESSIONID":Defaults[userToken]!,
                "mobileCode":mobileCode,
                "className":cell.textField.text!,
//                "periods":cell1.textField.text!,
                
                "deliveryCycle":infoArr[1][0],
                "workTimes":infoArr[1][1],
                "deadline":infoArr[1][2],
                "classPhoto":headImageStr,
                "id":class_id,
            ]
            NetWorkTeacherEditoClasses(params: params, callBack: { (flag) in
                if flag {
                    
                    NotificationCenter.default.post(name: Notification.Name(rawValue: SuccessCorrectClassBuildPeriodNoti), object: self, userInfo: ["refresh":"begin"])
                    self.navigationController?.popViewController(animated: true)
                }
            })
            
        }
    }
    
    
    override func addHeaderRefresh() {
        
    }
    
    
    override func configSubViews() {
        
        if classInfo.class_name != nil {
            headImageStr = classInfo.class_photo
        }
        
        dataArr = [["班级头像","班级名字"],["交作业周期","交作业截止时间","课时数"],teachers,students]
        
        if classInfo.class_name == nil {
            
            self.navigationItem.title = "创建班级"

            infoArr = [["",""],["按天","18:00前","次"],["",""],[""]]
            dataArr = [["班级头像","班级名字"],["交作业周期","交作业截止时间","课时数"],teachers,students]
        }else{
            
            self.navigationItem.title = "编辑班级资料"
            dataArr = [["班级头像","班级名字"],["交作业周期","交作业截止时间","课时数"]]
            infoArr = [["",classInfo.class_name],[classInfo.delivery_cycle,classInfo.work_times,"次"]]
        }
        
        mainTableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: kSCREEN_HEIGHT - 64 ), style: .grouped)
        mainTableView.dataSource = self;
        mainTableView.delegate = self;
        mainTableView.estimatedRowHeight = 143 * kSCREEN_SCALE;
        mainTableView.register(UINib(nibName: "CreateClassCell", bundle: nil), forCellReuseIdentifier: identyfierTable)
        mainTableView.register(UINib(nibName: "ShowFridensCell", bundle: nil), forCellReuseIdentifier: identyfierTable1)
        mainTableView.register(UINib(nibName: "CreateClassCell2", bundle: nil), forCellReuseIdentifier: identyfierTable2)
        mainTableView.register(UINib(nibName: "CreateHeadCell", bundle: nil), forCellReuseIdentifier: identyfierTable3)
        
        self.view.addSubview(mainTableView)
    }
    
    
    //MARK:  ******代理 ：UITableViewDataSource,UITableViewDelegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 2 {
            return teachers.count
        }
        
        if section == 3 {
            return students.count
        }
        
        return dataArr[section].count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return dataArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : CreateClassCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable, for: indexPath) as! CreateClassCell
        cell.selectionStyle = .default
        
        let cell2 : CreateClassCell2 = tableView.dequeueReusableCell(withIdentifier: identyfierTable2, for: indexPath) as! CreateClassCell2
        cell2.selectionStyle = .none
        
        if indexPath.section == 0 && indexPath.row == 0{
            let cellHead : CreateHeadCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable3, for: indexPath) as! CreateHeadCell
            cellHead.selectionStyle = .default
            cellHead.setImageForHeadView(headImage:headImage)
            return cellHead
        }
        
        if indexPath.section == 0 && indexPath.row == 1 {
            
            if classInfo.class_name == nil {
                cell2.CreateClassCell2ShowAll(title: dataArr[indexPath.section][indexPath.row], info: infoArr[indexPath.section][indexPath.row],placeholder:"字数限制16字以内...")
            }else{
                cell2.CreateClassCellEdit(title: dataArr[indexPath.section][indexPath.row], info: classInfo.class_name, text:"",placeholder:"字数限制16字以内...")
            }
            return cell2
            
        }else if indexPath.section == 1 &&  indexPath.row == 2 {
            
            if classInfo.class_name == nil {
                cell2.CreateClassCell2ShowAll(title: dataArr[indexPath.section][indexPath.row], info: infoArr[indexPath.section][indexPath.row],placeholder:"填写次数")
            }else{
//                cell2.CreateClassCellEdit(title: dataArr[indexPath.section][indexPath.row], info: classInfo.Cperiods, text:"次",placeholder:"填写次数")
                
                
                cell2.CreateClassCell2(title: dataArr[indexPath.section][indexPath.row],member:classInfo.Cperiods+" 次")
            }
            return cell2
            
        }else if indexPath.section == 2  {
            
            var str = "+"
            if indexPath.row == 0 {
                
                if teachers1.count == 3 {
                    str = teachers1.joined(separator: ",") + "  "
                }else{
                    str = teachers1.joined(separator: ",") + "  +"
                }
            }else{
                str = teachers2.joined(separator: ",") + "  +"
            }
            cell2.CreateClassCell2(title: teachers[indexPath.row],member:str)
            return cell2
            
        }else if indexPath.section == 3{
            
            if indexPath.row == 0 {
                cell2.CreateClassCell2(title: students[indexPath.row],member:"+")
                
                return cell2
            }else{
                let cell : ShowFridensCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable1, for: indexPath) as! ShowFridensCell
                cell.ShowFridensCellForCreateClass(model: addedStudents[indexPath.row-1])
                return cell
            }
            
        }else{
            
            cell.CreateClassCellNormal(title: dataArr[indexPath.section][indexPath.row], name: infoArr[indexPath.section][indexPath.row])
            return cell
            
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        if indexPath.section == 0 && indexPath.row == 0 {
            setupPhoto1(count: 1)
        }
        
        if indexPath.section == 1 {
            
            if indexPath.row == 0 {
                showWorkCircleView()
            }
            
            if indexPath.row == 1 {
                showWorkDeadLineView()
            }
            
        }
        
        
        if indexPath.section == 2  && indexPath.row == 0  {
            
            let chooseTeacher = TChooseMemberViewController()
            if teachers1.count == 3{
                setToast(str: "已经三位助教老师了")
                return
            }
            chooseTeacher.action = "选择添加助教老师"
            chooseTeacher.type = "1"
            chooseTeacher.state = "2"
            chooseTeacher.addMembers = teachers1Added
            chooseTeacher.chooseMemberBlock = {

                self.teachers1.removeAll()
                self.teachers1Added.removeAll()
                
                for model in $0 {
                    if self.teachers2.contains(model.user_name) {
                        setToast(str: "你已经选择<"+model.user_name+">为上课老师了！")
                    }else{
                        self.teachers1.append(model.user_name)
                        self.teachers1Added.append(model)
                    }
                }
                
//                for index in 0..<$0.count {
//
//                    if !self.teachers1.contains($0[index].user_name) {
//
//                        if !self.teachers2.contains($0[index].user_name) {
//
//                            self.teachers1.append($0[index].user_name)
//                            self.teachers1Added = $0
//                        }else{
//                            setToast(str: "你已经选择<"+$0[index].user_name+">为上课老师了！")
//                        }
//                    }else{
//                        setToast(str: "你已经选择<"+$0[index].user_name+">为助教老师了！")
//
//                    }
//                }
                
                tableView.reloadSections([2], with: .automatic)
            }
            
            self.navigationController?.pushViewController(chooseTeacher, animated: true)
        }
        
        if indexPath.section == 2  && indexPath.row == 1  {
            
            let chooseTeacher = TChooseMemberViewController()
            if teachers2.count == 3{
                setToast(str: "已经三位上课老师了")
                return
            }
            chooseTeacher.type = "1"
            chooseTeacher.state = "1"
            chooseTeacher.action = "选择添加上课老师"
            chooseTeacher.addMembers = teachers2Added
            chooseTeacher.chooseMemberBlock = {
                self.teachers2.removeAll()
                self.teachers2Added.removeAll()
                
                for model in $0 {
                    if self.teachers1.contains(model.user_name) {
                        setToast(str: "你已经选择<"+model.user_name+">为助教老师了！")
                    }else{
                        
                        self.teachers2.append(model.user_name)
                        self.teachers2Added.append(model)
                    }
                }
                
                tableView.reloadSections([2], with: .automatic)
            }
            self.navigationController?.pushViewController(chooseTeacher, animated: true)
        }

        
        
        if indexPath.section == 3  && indexPath.row == 0  {
            
            let chooseStudent = TChooseMemberViewController()
//            chooseStudent.selectArr = students
            chooseStudent.action = "选择添加学生"
            chooseStudent.type = "2"
            chooseStudent.addMembers = addedStudents
            chooseStudent.chooseMemberBlock = {

                self.students = ["批量添加学生"]
                self.addedStudents.removeAll()
                
                for model in $0 {
                    self.students.append(model.user_name)
                    self.addedStudents.append(model)
                }
                
                tableView.reloadSections([3], with: .automatic)
            }
            
            self.navigationController?.pushViewController(chooseStudent, animated: true)
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 12))
        view.backgroundColor = kGaryColor(num: 244)
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 3 {
            let showLabel = UILabel.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 19))
            showLabel.text = "     目前已添加\(students.count-1)人"
            showLabel.font = kFont26
            showLabel.textColor = kGaryColor(num: 176)
            showLabel.textAlignment = .left
            showLabel.isAttributedContent = true
            
            let attributeText = NSMutableAttributedString.init(string: showLabel.text!)
            
            let count = String(mainTableArr.count).characters.count
            //设置段落属性
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 2     //设置行间距
            attributeText.addAttributes([NSAttributedStringKey.paragraphStyle: paragraphStyle], range: NSMakeRange(0, (showLabel.text?.characters.count)!))
            attributeText.addAttributes([NSAttributedStringKey.font:  kFont28], range: NSMakeRange(0, (showLabel.text?.characters.count)!))
            attributeText.addAttributes([NSAttributedStringKey.foregroundColor: kSetRGBColor(r: 255, g: 153, b: 0)], range: NSMakeRange(10,  count))
            showLabel.attributedText = attributeText
            //            showLabel.textAlignment = .right
            showLabel.font = kFont26
            showLabel.backgroundColor = UIColor.white
            return showLabel
        }
        
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 12))
        view.backgroundColor = kGaryColor(num: 244)
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        if section == 2 {
            return 12
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 3 {
            return 25
        }
        
        return 12
    }
    
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        if indexPath.section == 3 && indexPath.row != 0 {
            return true
        }
        return false
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            self.students.remove(at: indexPath.row)
            self.addedStudents.remove(at: indexPath.row-1)
            tableView.reloadSections([3], with: .automatic)
            deBugPrint(item: "删除了---\(indexPath.section)分区-\(indexPath.row)行")
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "移除"
    }
    
    
    private func setupPhoto1(count:NSInteger) {
        let imagePickTool = CLImagePickersTool()
        
        imagePickTool.isHiddenVideo = true
        
        imagePickTool.setupImagePickerWith(MaxImagesCount: count, superVC: self) { (assetArr,cutImage) in
            deBugPrint(item: "返回的asset数组是\(assetArr)")
            
            PopViewUtil.share.showLoading()
            
            var imageArr = [UIImage]()
            var index = assetArr.count // 标记失败的次数
            
            // 获取原图，异步
            // scale 指定压缩比
            // 内部提供的方法可以异步获取图片，同步获取的话时间比较长，不建议！，如果是iCloud中的照片就直接从icloud中下载，下载完成后返回图片,同时也提供了下载失败的方法
            CLImagePickersTool.convertAssetArrToOriginImage(assetArr: assetArr, scale: 0.1, successClouse: {[weak self] (image,assetItem) in
                imageArr.append(image)
                
                self?.dealImage(imageArr: imageArr, index: index)
                
                self?.headImage = image
                
                self?.mainTableView.reloadRows(at: [IndexPath.init(row: 0, section: 0)], with: .none)
                
                let params = [
                    "SESSIONID":Defaults[userToken]!,
                    "mobileCode":Defaults[mCode]!,
                    ]

                editorTeacherEditoClassesHelp(params: params, data: [image], name: [""], success: { (datas) in
                    self?.headImageStr = JSON(datas)["data"]["img"].stringValue
                }, failture: { (error) in
                    
                })
                
                
                }, failedClouse: { () in
                    index = index - 1
                    self.dealImage(imageArr: imageArr, index: index)
            })
        }
    }
    
    
    @objc func dealImage(imageArr:[UIImage],index:Int) {
        // 图片下载完成后再去掉我们的转转转控件，这里没有考虑assetArr中含有视频文件的情况
        if imageArr.count == index {
            PopViewUtil.share.stopLoading()
        }
        // 图片显示出来以后可能还要上传到云端的服务器获取图片的url，这里不再细说了。
    }
    
    
    var BGView = UIView()
    var workCircleView = ShowTagsView()
    var workDeadLineView = ShowTagsView()
    
    @objc func showChooseCondi(tap:UITapGestureRecognizer) -> Void {
        if tap.view?.alpha == 1 {
            
            UIView.animate(withDuration: 0.5) {
                tap.view?.alpha = 0
                self.workCircleView.transform = .identity
                self.workDeadLineView.transform = .identity
            }
        }
    }
    
    func hiddenViews() {
        UIView.animate(withDuration: 0.5) {
            self.BGView.alpha = 0
            self.workCircleView.transform = .identity
            self.workDeadLineView.transform = .identity
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
        
        
        workCircleView = UINib(nibName:"ShowTagsView",bundle:nil).instantiate(withOwner: self, options: nil).first as! ShowTagsView
        workCircleView.ShowTagsViewForChooseEdu(title: "", index: 10003)
        workCircleView.frame =  CGRect(x: 0, y: kSCREEN_HEIGHT, width: kSCREEN_WIDTH, height: 190+287*kSCREEN_SCALE)
        workCircleView.layer.cornerRadius = 24*kSCREEN_SCALE
        workCircleView.selectBlock = {
            if !$1 {
                self.infoArr[1][0] = $0
                self.mainTableView.reloadRows(at: [IndexPath.init(row: 0, section: 1)], with: .automatic)
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                
            }
            self.hiddenViews()
        }
        
        workCircleView.clipsToBounds = true
        self.view.addSubview(workCircleView)
        
        
        workDeadLineView = UINib(nibName:"ShowTagsView",bundle:nil).instantiate(withOwner: self, options: nil).first as! ShowTagsView
        workDeadLineView.ShowTagsViewForChooseEdu(title: "", index: 10004)

        workDeadLineView.frame =  CGRect(x: 0, y: kSCREEN_HEIGHT, width: kSCREEN_WIDTH, height: 350)
        workDeadLineView.layer.cornerRadius = 24*kSCREEN_SCALE
        workDeadLineView.selectBlock = {
            if !$1 {
                self.infoArr[1][1] = $0
                self.mainTableView.reloadRows(at: [IndexPath.init(row: 1, section: 1)], with: .automatic)
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                
            }
            self.hiddenViews()
        }
        
        workDeadLineView.clipsToBounds = true
        self.view.addSubview(workDeadLineView)
    }
    
    func showWorkCircleView() -> Void {
        let y = 180+287*kSCREEN_SCALE
        
        UIView.animate(withDuration: 0.5) {
            self.workCircleView.transform = .init(translationX: 0, y: -y)
            self.BGView.alpha = 1
        }
    }
    
    
    func showWorkDeadLineView() -> Void {
        let y = CGFloat(330)
        UIView.animate(withDuration: 0.5) {
            self.workDeadLineView.transform = .init(translationX: 0, y: -y)
            self.BGView.alpha = 1
        }
    }
    
}
