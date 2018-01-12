//
//  TEditInfoViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/25.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyUserDefaults
import SwiftyJSON

class TEditInfoViewController: BaseViewController {

    var isTeacher = false
    var dataArr = [Array<String>]()
    var infoArr = [Array<String>]()
    
    var proArr = [String]()
    var gradeArr = [String]()
    
    var teacherIDFrontImage = #imageLiteral(resourceName: "Upload-photos_yinshuabanci")
    var teacherIDBackImage = #imageLiteral(resourceName: "Upload-photos_yinshuabanci")
    var headImage = #imageLiteral(resourceName: "UserHead_128_default")
    var certification = UIImage()
    
    var isCertification = false
    
//    身份证号码
    var idStr = ""
//    教师资格证号码
    var certStr = ""
    
    var image1 = ""
    var image2 = ""
    var image3 = ""
    var image4 = ""
    
    var model = PersonalModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTagsView()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "保存", style: .plain, target: self, action: #selector(saveInfo(sender:)))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
    }
    
    override func addHeaderRefresh() {
        
    }
    
    @objc func saveInfo(sender:UIBarButtonItem) {
        
        if idStr == "" {
            setToast(str: "请输入身份证号")
            return
        }
//        if certStr == "" {
//            setToast(str: "请输入教师资格证号")
//            return
//        }
        if infoArr[2][2] == "选择工作时间" {
            setToast(str: "请选择工作时间")
            return
        }
        if image1 == "1" {
            setToast(str: "请选择头像")
            return
        }
        if image1 == "2" {
            setToast(str: "请选择身份证正背面照片")
            return
        }
        if image1 == "3" {
            setToast(str: "请选择身份证背面照片")
            return
        }
//        if image1 == "4" {
//            setToast(str: "请选择教师资格证照片")
//            return
//        }
        
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        self.view.beginLoading()
        let params =
            [
                "SESSIONID":SESSIONID,
                "mobileCode":mobileCode,
                "grade":infoArr[2][1],
                "identity":idStr,
                "celtyl":certStr,
                "phone":Defaults[userPhone]!,
                "idea":infoArr[1][2],
                "user_correct_subject":infoArr[2][0],
                "user_photo":image1,
                "identity_front":image2,
                "identity_verso":image3,
                "celtyl_photo":image4,
                "user_job_time":infoArr[2][2]
        ] as [String:Any]
        NetWorkTeachersEditorTeacher(params: params) { (flag) in
            if flag {
                self.navigationController?.popViewController(animated: true)
            }else{
                self.navigationItem.rightBarButtonItem?.isEnabled = false
            }
            self.view.endLoading()
        }
    }
    
    override func configSubViews() {
        
        self.navigationItem.title = "个人信息"
        
        if model.haveIdentity == "no" && model.haveCeltyl == "no"{
            
            dataArr = [["我的头像"],["我的名称","联系方式","所在地区"],["批改科目","我的年级","工作时间"],["我的工号"],["身份证号码:",""],["教师资格证号:",""]]
            infoArr = [[""],[model.user_name,model.user_phone,model.user_area],[model.user_correct_subject,model.user_fit_class,model.user_job_time],[model.user_num],["",""],["",""]]
        }else if model.haveIdentity == "no" && model.haveCeltyl == "yes"{
            
            dataArr = [["我的头像"],["我的名称","联系方式","所在地区"],["批改科目","我的年级","工作时间"],["我的工号"],["教师资格证号:",""]]
            infoArr = [[""],[model.user_name,model.user_phone,model.user_area],[model.user_correct_subject,model.user_fit_class,model.user_job_time],[model.user_num],["",""]]
        }else if model.haveIdentity == "yes" && model.haveCeltyl == "no"{
            
            dataArr = [["我的头像"],["我的名称","联系方式","所在地区"],["批改科目","我的年级","工作时间"],["我的工号"],["身份证号码:",""]]
            infoArr = [[""],[model.user_name,model.user_phone,model.user_area],[model.user_correct_subject,model.user_fit_class,model.user_job_time],[model.user_num],["",""]]
        }else{
            
            dataArr = [["我的头像"],["我的名称","联系方式","所在地区"],["批改科目","我的年级","工作时间"],["我的工号"]]
            infoArr = [[""],[model.user_name,model.user_phone,model.user_area],[model.user_correct_subject,model.user_fit_class,model.user_job_time],[model.user_num]]
        }
        
        mainTableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: kSCREEN_HEIGHT - 64 ), style: .grouped)
        mainTableView.dataSource = self
        mainTableView.delegate = self
        mainTableView.estimatedRowHeight = 143 * kSCREEN_SCALE;
        mainTableView.register(UINib(nibName: "TeacherInfoCell1", bundle: nil), forCellReuseIdentifier: identyfierTable)
        mainTableView.register(UINib(nibName: "TeacherInfoCell2", bundle: nil), forCellReuseIdentifier: identyfierTable1)
        mainTableView.register(UINib(nibName: "TeacherInfoCell3", bundle: nil), forCellReuseIdentifier: identyfierTable2)
        mainTableView.register(UINib(nibName: "TeacherInfoCell4", bundle: nil), forCellReuseIdentifier: identyfierTable3)
        mainTableView.register(UINib(nibName: "EditHeadCell", bundle: nil), forCellReuseIdentifier: identyfierTable4)
        self.view.addSubview(mainTableView)
    }
    
    
    //MARK:  ******代理 ：UITableViewDataSource,UITableViewDelegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataArr[section].count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return dataArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell : TeacherInfoCell1 = tableView.dequeueReusableCell(withIdentifier: identyfierTable, for: indexPath) as! TeacherInfoCell1
        cell.selectionStyle = .default
        let title = dataArr[indexPath.section][indexPath.row]
        let subTitle = infoArr[indexPath.section][indexPath.row]
        
        if indexPath.section == 0 { 
            let cell1 : EditHeadCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable4, for: indexPath) as! EditHeadCell
            cell1.setTeacherUserIcon(image:headImage, imgStr: "")
            cell1.chooseIconBlock = {
                deBugPrint(item: $0)
                self.setupPhoto1(count: 1, isBack: false,isHead: true)
            }
            return cell1
        }else if indexPath.section == 1 && indexPath.row < 2{
            
            let cell : TeacherInfoCell2 = tableView.dequeueReusableCell(withIdentifier: identyfierTable1, for: indexPath) as! TeacherInfoCell2
            cell.TeacherInfoCell2ForNormal(title: title, content: subTitle)
            cell.accessoryType = .none
            return cell
        }else if indexPath.section == 3 {
            
            let cell : TeacherInfoCell2 = tableView.dequeueReusableCell(withIdentifier: identyfierTable1, for: indexPath) as! TeacherInfoCell2
            cell.TeacherInfoCell2ForNormal(title: title, content: subTitle)
            cell.accessoryType = .none
            return cell
        }else if indexPath.section == 4 {
            
            if indexPath.row == 0 {
                cell.TeacherInfoCellForSection2(title: title, subStr: subTitle)
                cell.endEditBlock = {
                    if $1{
                        deBugPrint(item: $0)
                        self.idStr = $0
                    }
                }
                cell.selectionStyle = .none
                cell.accessoryType = .none
                return cell
            }else{
                let cell2 : TeacherInfoCell3 = tableView.dequeueReusableCell(withIdentifier: identyfierTable2, for: indexPath) as! TeacherInfoCell3
                cell2.TeacherInfoCell3SetImagess(frontImage: teacherIDFrontImage,backImage:teacherIDBackImage)
                cell2.chooseImagesAction = {
                    self.isCertification = false
                    deBugPrint(item: $0)
                    self.setupPhoto1(count: 1, isBack: $0,isHead: false)
                }
                return cell2
            }
        }else if indexPath.section == 5 {
            
            if indexPath.row == 0 {
                cell.TeacherInfoCellForSection2(title: title, subStr: subTitle)
                cell.endEditBlock = {
                    if $1{
                        self.certStr = $0
                    }
                }
                cell.selectionStyle = .none
                cell.accessoryType = .none
                return cell
            }else{
                let cell2 : TeacherInfoCell4 = tableView.dequeueReusableCell(withIdentifier: identyfierTable3, for: indexPath) as! TeacherInfoCell4
                cell2.TeacherInfoCell4SetImage(image: certification)
                cell2.chooseImagesAction = {
                    deBugPrint(item: $0)
                    self.isCertification = true
                    self.setupPhoto1(count: 1, isBack: false,isHead: false)
                }
                return cell2
            }
        }else{
            cell.TeacherInfoCellForNormal(title: title, subStr: subTitle)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 1 {
            
            if indexPath.row == 2 {
                showEduView()
            }
            
        }else if indexPath.section == 2{
            
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
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 19 * kSCREEN_SCALE))
        view.backgroundColor = kSetRGBColor(r: 239, g: 239, b: 244)
        
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 4 || section == 5 {
            let showLabel = UILabel.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 48*kSCREEN_SCALE))
            showLabel.font = kFont24
            showLabel.textColor = kSetRGBColor(r: 255, g: 153, b: 0)
            showLabel.textAlignment = .left
            showLabel.backgroundColor = UIColor.white
            
            if section == 5 {
                showLabel.text = "     教师资格认证（非公开信息，选填）"
            }else{
                showLabel.text = "     身份证信息（确认真实性，非公开信息，必填）"
            }
//            showLabel.backgroundColor = UIColor.brown
            let line = UIView.init(frame: CGRect(x: 0, y: 46*kSCREEN_SCALE, width: kSCREEN_WIDTH, height: 1.5))
            line.backgroundColor = kGaryColor(num: 215)
            showLabel.addSubview(line)
            
            return showLabel
        }
        
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 19 * kSCREEN_SCALE))
        view.backgroundColor = kSetRGBColor(r: 239, g: 239, b: 244)
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 4 || section == 5 {
            return 48*kSCREEN_SCALE
        }
        return 19 * kSCREEN_SCALE
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        if section == 3 || section == 4 {
            return 19*kSCREEN_SCALE
        }
        
        return 0 * kSCREEN_SCALE
    }
    
    
    var BGView = UIView()
    var projectTagsView = ShowTagsView()
    var gradeTagsView = ShowTagsView()
    var timeView = ShowTagsView()
    var eduView = ChooseCityView()
    
    @objc func showChooseCondi(tap:UITapGestureRecognizer) -> Void {
        if tap.view?.alpha == 1 {
            
            UIView.animate(withDuration: 0.5) {
                tap.view?.alpha = 0
                self.projectTagsView.transform = .identity
                self.gradeTagsView.transform = .identity
                self.timeView.transform = .identity
                self.eduView.transform = .identity
            }
        }
    }
    
    func hiddenViews() {
        UIView.animate(withDuration: 0.5) {
            self.BGView.alpha = 0
            self.projectTagsView.transform = .identity
            self.gradeTagsView.transform = .identity
            self.timeView.transform = .identity
            self.eduView.transform = .identity
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
        
        projectTagsView = UINib(nibName:"ShowTagsView",bundle:nil).instantiate(withOwner: self, options: nil).first as! ShowTagsView
        projectTagsView.ShowTagsViewForProjects(title: "选择批改科目")
        projectTagsView.frame =  CGRect(x: 0, y: kSCREEN_HEIGHT, width: kSCREEN_WIDTH, height: 190+206*kSCREEN_SCALE)
        projectTagsView.layer.cornerRadius = 24*kSCREEN_SCALE
        projectTagsView.selectBlock = {
            if !$1 {
                self.infoArr[2][0] = $0
                self.mainTableView.reloadRows(at: [IndexPath.init(row: 0, section: 2)], with: .automatic)
            }
            self.hiddenViews()
        }
        projectTagsView.clipsToBounds = true
        self.view.addSubview(projectTagsView)
        
        gradeTagsView = UINib(nibName:"ShowTagsView",bundle:nil).instantiate(withOwner: self, options: nil).first as! ShowTagsView
        gradeTagsView.ShowTagsViewForGrades(title: "选择适合年级", total: 3)
        gradeTagsView.frame =  CGRect(x: 0, y: kSCREEN_HEIGHT, width: kSCREEN_WIDTH, height: 190+287*kSCREEN_SCALE)
        gradeTagsView.layer.cornerRadius = 24*kSCREEN_SCALE
        gradeTagsView.selectBlock = {
            if !$1 {
                self.infoArr[2][1] = $0
                self.mainTableView.reloadRows(at: [IndexPath.init(row: 1, section: 2)], with: .automatic)
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
                self.infoArr[2][2] = $0
                self.mainTableView.reloadRows(at: [IndexPath.init(row: 2, section: 2)], with: .automatic)
            }
            self.hiddenViews()
        }
        
        timeView.clipsToBounds = true
        self.view.addSubview(timeView)
        
//        eduView = UINib(nibName:"ShowTagsView",bundle:nil).instantiate(withOwner: self, options: nil).first as! ShowTagsView
//        eduView.ShowTagsViewForChooseEdu(title: "选择城市", index: 0)
        eduView = UINib(nibName:"ChooseCityView",bundle:nil).instantiate(withOwner: self, options: nil).first as! ChooseCityView
        
        eduView.frame =  CGRect(x: 0, y: kSCREEN_HEIGHT, width: kSCREEN_WIDTH, height: 350)
        eduView.layer.cornerRadius = 24*kSCREEN_SCALE
        eduView.selectBlock = {
            if $1 {
                self.infoArr[1][2] = $0
                self.mainTableView.reloadRows(at: [IndexPath.init(row: 2, section: 1)], with: .automatic)
                
            }
            self.hiddenViews()
        }
        
        eduView.clipsToBounds = true
        self.view.addSubview(eduView)
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
    
    
    func showEduView() -> Void {
        let y = CGFloat(330)
        UIView.animate(withDuration: 0.5) {
            self.eduView.transform = .init(translationX: 0, y: -y)
            self.BGView.alpha = 1
        }
    }
    
    // 异步原图
    private func setupPhoto1(count:NSInteger,isBack:Bool,isHead:Bool) {
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
                
                var type = "4"
                
                if (self?.isCertification)! && !isHead{
                    
                    self?.certification = image
                    self?.mainTableView.reloadSections([5], with: .automatic)
                    type = "4"
                }else{
                    
                    if !isHead{
                        if !isBack  {
                            self?.teacherIDFrontImage = image
                            type = "2"
                        }else{
                            self?.teacherIDBackImage = image
                            type = "3"
                        }
                        self?.mainTableView.reloadSections([4], with: .automatic)
                    }
                }
                
                if isHead {
                    self?.headImage = image
                    self?.mainTableView.reloadSections([0], with: .automatic)
                    type = "1"
                }
                
                let params = [
                    "SESSIONID":SESSIONID,
                    "mobileCode":mobileCode,
                    "type":type
                ]
                let arr = [image]
                editorTeacherUpLoadImageRequest(params: params, data: arr, name: [""], success: { (datas) in
                    
                    if type == "1" {
                        self?.image1 = JSON(datas)["data"]["user_photo"].stringValue
                    }
                    if type == "2" {
                        self?.image2 = JSON(datas)["data"]["identity_front"].stringValue
                    }
                    if type == "3" {
                        self?.image3 = JSON(datas)["data"]["identity_verso"].stringValue
                    }
                    if type == "4" {
                        self?.image4 = JSON(datas)["data"]["celtyl_photo"].stringValue
                    }
                    
                }, failture: { (error) in
                })
                self?.navigationItem.rightBarButtonItem?.isEnabled = true

                self?.dealImage(imageArr: imageArr, index: index)
                
                }, failedClouse: { () in
                    index = index - 1
                    self.dealImage(imageArr: imageArr, index: index)
                    self.navigationItem.rightBarButtonItem?.isEnabled = true
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

}
