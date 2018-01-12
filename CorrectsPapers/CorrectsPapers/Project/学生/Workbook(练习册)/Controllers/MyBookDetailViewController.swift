//
//  MyBookDetailViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/1.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyJSON
import SwiftyUserDefaults

class MyBookDetailViewController: BaseViewController,HBAlertPasswordViewDelegate {
    var typeArr = NSMutableArray()
    var headView = UIView()
    var underLine = UIView()
    
    var currentIndex = 1
    
    var workState = ""
    
    var images = NSMutableArray()
    
    var showDateView = UIView()
    
    var dateBtn = UIButton()
    
    var model = WorkBookModel()
    var theModel = BookDetailModel()
    
    var footBtnView = UIView()
    var titleArr3 = ["作业视频讲解","作业答案文档下载","文字版答案"]
    var currentTitle2 = ""

    var selectDate = ""
    
    var timeArr = [String]()
    
    var pointArr = NSMutableArray()
    var answerArr = NSMutableArray()
    var gradeArr = NSMutableArray()
    
    let identyfierTable7 = "identyfierTable7"
    let identyfierTable8 = "identyfierTable8"
    let identyfierTable12 = "identyfierTable12"

    
    var downloadType = 100

    var payModels = NSMutableArray()

    var workVideoModel = PayModel()
    var workAnswerModel = PayModel()
    var workTextModel = PayModel()

    
    var type = [String]()
    var noAnswerTypes = [String]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTimeSelector()
        rightBarButton()
//        workState = model.correct_state!
    }
    
    //    右键
    func rightBarButton() {
        
        let date = NSDate.init()
        let formatter = DateFormatter()
        //日期样式
        formatter.dateFormat = "yyyy-MM-dd"
        selectDate = formatter.string(from: date as Date)
        
        dateBtn = UIButton.init(frame: CGRect(x: 10, y: 0 , width: kSCREEN_WIDTH/3, height: 38))
        dateBtn.backgroundColor = UIColor.clear
        dateBtn.titleLabel?.font = kFont30
        dateBtn.setTitleColor(UIColor.white, for: .normal)
        dateBtn.setImage(#imageLiteral(resourceName: "date_dropdown-arrow_icon"), for: .normal)
        dateBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 12)
        dateBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 103, 0, 0)
        dateBtn.setTitle(selectDate, for: .normal)
        dateBtn.addTarget(self, action: #selector(chooseDateAction(sender:)), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: dateBtn)
    }
    
    
    override func requestData() {
        let date = NSDate.init()
        let formatter = DateFormatter()
        //日期样式
        formatter.dateFormat = "yyyy-MM-dd"

        let params =
            [
                "userWorkBookId":model.userWorkBookId!,
                "SESSIONID":SESSIONID,
                "time":formatter.string(from: date as Date),
                "mobileCode":mobileCode
        ] as [String:Any]
        self.view.beginLoading()
        netWorkForGetWorkBookByTime(params: params) { (dataArr,flag) in
            if flag {
                if dataArr.count > 0{
                    self.theModel = dataArr[0] as! BookDetailModel
                    self.workState = self.theModel.correcting_states
                    if self.workState == "" {
                        self.workState = "1"
                    }
                    self.mainTableView.reloadData()
                }
                deBugPrint(item: dataArr)
            }
            self.view.endLoading()
        }
        
        netWorkForGetWorkBookTime(params: params) { (datas,flag) in
            if flag {
                self.timeArr = datas as! [String]
            }
            self.view.endLoading()
        }
        
//        let params1 =
//            [
//                "bookId":model.work_book_Id,
//                "SESSIONID":SESSIONID,
//                "mobileCode":mobileCode
//                ] as [String:Any]
//        NetWorkStudentCheckPay(params: params1) { (pays,falg) in
//
//
//        }
        
        titleArr3 = ["作业视频讲解","作业答案文档下载","文字版答案"]
        
        if Int(workState)! > Int(1) {
            let params1 =
                [
                    "bookId":model.work_book_Id,
                    "SESSIONID":SESSIONID,
                    "mobileCode":mobileCode
                    ] as [String:Any]
            NetWorkStudentCheckPay(params: params1) { (pays,flag) in
                deBugPrint(item: pays)
                if flag && pays.count > 0{
                    self.payModels.addObjects(from: pays)
                    
                    for model in pays {
                        let m = model as! PayModel
                        
                        if m.type == "1"{
                            self.workVideoModel = m
                        }
                        if m.type == "2"{
                            self.workAnswerModel = m
                        }
                        if m.type == "3"{
                            self.workTextModel = m
                        }
                        self.noAnswerTypes.append(m.type!)
                    }
                    
                    if self.workVideoModel.isPay != "no" && self.workVideoModel.isPay != nil {
                        self.titleArr3.remove(at: self.titleArr3.index(of: "作业视频讲解")!)
                        self.type.append("1")
                    }
                    
                    if self.workAnswerModel.isPay != "no" && self.workAnswerModel.isPay != nil {
                        self.titleArr3.remove(at: self.titleArr3.index(of: "作业答案文档下载")!)
                        self.type.append("2")
                    }
                    
                    if self.workTextModel.isPay != "no" && self.workTextModel.isPay != nil{
                        self.titleArr3.remove(at: self.titleArr3.index(of: "文字版答案")!)
                        self.type.append("3")
                    }
                    if self.currentIndex == 3 {
                        
                        self.mainTableView.mj_header.beginRefreshing()
                        self.footView(titles: self.titleArr3)
                    }
                }
                self.view.endLoading()
            }
        }

    }
    
    
    override func refreshHeaderAction() {
        
        if currentIndex == 1 {
//            let date = NSDate.init()
//            let formatter = DateFormatter()
//            //日期样式
//            formatter.dateFormat = "yyyy-MM-dd"
            
            let params =
                [
                    "userWorkBookId":model.userWorkBookId!,
                    "SESSIONID":SESSIONID,
                    "time":selectDate,
                    "mobileCode":mobileCode
                    ]
            netWorkForGetWorkBookByTime(params: params) { (dataArr,flag) in
                if flag {
                    if dataArr.count > 0{
                        self.theModel = dataArr[0] as! BookDetailModel
                        self.workState = self.theModel.correcting_states
                        if self.workState == "" {
                            self.workState = "1"
                        }
                        self.mainTableView.reloadData()
                    }
                    deBugPrint(item: dataArr)
                }
                self.mainTableView.mj_header.endRefreshing()
            }

        }else if currentIndex == 2 {
            let params =
                [
                    "workBookId":model.work_book_Id,
                    "date":selectDate,
                    "SESSIONID":SESSIONID,
                    "mobileCode":mobileCode
                    ] as [String:Any]
            NetWorkStudentGetKnowledgePoint(params: params, callBack: { (datas, flag) in
                if flag {
                    self.pointArr.removeAllObjects()
                    self.pointArr.addObjects(from: datas)
                    self.mainTableView.reloadData()
                }
                self.mainTableView.mj_header.endRefreshing()
                
            })
        }else if currentIndex == 3 {
            let params =
                [
                    "bookId":model.work_book_Id,
                    "type":"1",
                    "SESSIONID":SESSIONID,
                    "mobileCode":mobileCode
                    ] as [String:Any]
            NetWorkStudentGetAnswrs(params: params) { (datas, flag) in
                if flag {
                    self.answerArr.addObjects(from: datas)
                    self.mainTableView.reloadData()
                }
                self.mainTableView.mj_header.endRefreshing()
                self.view.endLoading()
            }
            
        }else if currentIndex == 4 {
            
        }

        
    }
    
    override func configSubViews() {
        
        self.navigationItem.title = model.work_book_name
        
        typeArr = ["我的作业","知识点讲解","参考答案","成绩统计"]
        let kHeight = CGFloat(44)
        
        var contentWidth = CGFloat()
        var totalWidth = CGFloat()
        
        headView = UIView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 43))
        
        //MARK: 因为按钮字数不一样，长短有别，所以我先看看一共有多长再平分space
        for index in 0...typeArr.count-1{
            
            let kWidth = getLabWidth(labelStr: typeArr[index] as! String, font: kFont32, height: kHeight) + 10
            totalWidth += kWidth
            
        }
        
        let kSpace = CGFloat(kSCREEN_WIDTH - totalWidth)/6
        
        for index in 0...typeArr.count-1{
            
            let kWidth = getLabWidth(labelStr: typeArr[index] as! String, font: kFont32, height: kHeight) + 10
            let markBtn = UIButton.init(frame: CGRect(x: kSpace + (contentWidth + kSpace * CGFloat(index)) , y: 1, width: kWidth, height: kHeight))
            //            markBtn.center.y = headView.center.y
            markBtn.setTitle(typeArr[index] as? String, for: .normal)
            markBtn.setTitleColor(kGaryColor(num: 117), for: .normal)
            markBtn.titleLabel?.font = kFont28
            markBtn.addTarget(self, action: #selector(goodAtProject(sender:)), for: .touchUpInside)
            contentWidth += kWidth
            markBtn.tag = 131 + index
            headView.addSubview(markBtn)
        }
        
        let line = UIView.init(frame: CGRect(x: 0, y: 41 , width: kSCREEN_WIDTH, height: 1))
        line.backgroundColor = kGaryColor(num: 223)
        headView.addSubview(line)
        
        let view = headView.viewWithTag(131) as! UIButton
        view.setTitleColor(kMainColor(), for: .normal)
        underLine = UIView.init(frame: CGRect(x: 0, y: 40, width: getLabWidth(labelStr: "等我粉丝", font: kFont32, height: 1) - 5, height: 2))
        underLine.backgroundColor = kMainColor()
        underLine.layer.cornerRadius = 1
        underLine.clipsToBounds = true
        underLine.center.x = view.center.x
        headView.addSubview(underLine)
        headView.backgroundColor = UIColor.white
        self.view.addSubview(headView)
        
        mainTableView = UITableView.init(frame: CGRect(x: 0, y: 42, width: kSCREEN_WIDTH, height: kSCREEN_HEIGHT - 64 - 42), style: .plain)
        mainTableView.dataSource = self;
        mainTableView.delegate = self;
        mainTableView.estimatedRowHeight = 342
        mainTableView.tableFooterView = UIView.init()
        
        mainTableView.register(UINib(nibName: "AnserImageCell", bundle: nil), forCellReuseIdentifier: identyfierTable)
        mainTableView.register(UINib(nibName: "UpLoadWorkCell", bundle: nil), forCellReuseIdentifier: identyfierTable1)
        mainTableView.register(UINib(nibName: "CheckWorkCell", bundle: nil), forCellReuseIdentifier: identyfierTable2)
        mainTableView.register(UINib(nibName: "AnserVideoCell", bundle: nil), forCellReuseIdentifier: identyfierTable3)
        mainTableView.register(UINib(nibName: "showGradeCell", bundle: nil), forCellReuseIdentifier: identyfierTable4)
        mainTableView.register(UINib(nibName: "ShowFileCell", bundle: nil), forCellReuseIdentifier: identyfierTable7)
        mainTableView.register(UINib(nibName: "ShowWriteAnswerCell", bundle: nil), forCellReuseIdentifier: identyfierTable8)
        mainTableView.register(UINib(nibName: "AnswerImageCell", bundle: nil), forCellReuseIdentifier: identyfierTable12)

        self.view.addSubview(mainTableView)
    }
    
    
    @objc func chooseDateAction(sender:UIButton) {
        //        print(NSDate())
        if currentIndex == 4 {
            return
        }
        showDatePickerView()
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
        
//        判断是否要显示下面的下载按钮
      
        if currentIndex == 3 {
            footView(titles: titleArr3)
        }else{
            footBtnView.removeFromSuperview()
        }
        
        if currentIndex == 1 {
            let params =
                [
                    "userWorkBookId":model.userWorkBookId!,
                    "SESSIONID":SESSIONID,
                    "time":selectDate,
                    "mobileCode":mobileCode
                    ] as [String:Any]
            self.view.beginLoading()
            netWorkForGetWorkBookByTime(params: params) { (dataArr,flag) in
                if flag {
                    if dataArr.count > 0{
                        self.theModel = dataArr[0] as! BookDetailModel
                        self.workState = self.theModel.correcting_states
                        if self.workState == "" {
                            self.workState = "1"
                        }
                        self.mainTableView.mj_header.endRefreshing()
                        self.mainTableView.reloadData()
                    }
                    deBugPrint(item: dataArr)
                }
                self.view.endLoading()
            }
        }else if currentIndex == 2 {
            
            let params =
                [
                    "workBookId":model.work_book_Id,
                    "date":selectDate,
                    "SESSIONID":SESSIONID,
                    "mobileCode":mobileCode
                    ] as [String:Any]
            self.view.beginLoading()
            NetWorkStudentGetKnowledgePoint(params: params, callBack: { (datas, flag) in
                if flag {
                    self.pointArr.removeAllObjects()
                    self.pointArr.addObjects(from: datas)
                    self.mainTableView.reloadData()
                }
                self.view.endLoading()
            })
        }else if currentIndex == 3 {
            let params =
                [
                    "bookId":model.work_book_Id,
                    "type":"1",
                    "SESSIONID":SESSIONID,
                    "mobileCode":mobileCode
                    ] as [String:Any]
            NetWorkStudentGetAnswrs(params: params) { (datas, flag) in
                if flag {
                    self.answerArr.removeAllObjects()
                    self.answerArr.addObjects(from: datas)
                    self.mainTableView.reloadData()
                }
            }

        }else if currentIndex == 4 {
            
        }
        
//        self.mainTableView.mj_header.endRefreshing()
        mainTableView.reloadData()
    }
    
    
    func footView(titles:[String]) {
        footBtnView.removeFromSuperview()
        _ = footBtnView.subviews.map {
            $0.removeFromSuperview()
        }
        
        let kHeight = CGFloat(72 * kSCREEN_SCALE)
        let kWidth = CGFloat(435*kSCREEN_SCALE)
        let kSpace = 53*kSCREEN_SCALE
        
        var viewHeight = CGFloat(titles.count)*kHeight+CGFloat(titles.count+1)*kSpace
        
        if titles.count == 0 {
            viewHeight = 0
        }
        
        footBtnView = UIView.init(frame: CGRect(x: 0, y: 0, width: KScreenWidth, height: viewHeight))
        for index in 0..<titles.count {
            
            let markBtn = UIButton.init(frame: CGRect(x: (kSCREEN_WIDTH-kWidth)/2 , y: kSpace+(kSpace+kHeight)*CGFloat(index), width: kWidth, height: kHeight))
            markBtn.setTitle(titles[index], for: .normal)
            markBtn.setTitleColor(kGaryColor(num: 117), for: .normal)
            markBtn.titleLabel?.font = kFont28
            markBtn.setBackgroundImage(getNavigationIMG(27, fromColor: kSetRGBColor(r: 0, g: 200, b: 255), toColor: kSetRGBColor(r: 0, g: 162, b: 255)), for: .normal)
            markBtn.addTarget(self, action: #selector(showDownloadBtn(sender:)), for: .touchUpInside)
            markBtn.layer.cornerRadius = 10*kSCREEN_SCALE
            markBtn.clipsToBounds = true
            markBtn.setTitleColor(UIColor.white, for: .normal)
            markBtn.tag = 181 + index
            
            var theType = ""
            
            if titles[index] == "作业视频讲解" {
                theType = "1"
            }
            if titles[index] == "作业答案文档下载" {
                theType = "2"
            }
            if titles[index] == "文字版答案" {
                theType = "3"
            }
            
            if !noAnswerTypes.contains(theType) {
                
                markBtn.setBackgroundImage(getNavigationIMG(27, fromColor: kGaryColor(num: 220), toColor: kGaryColor(num: 220)), for: .normal)
                markBtn.isEnabled = false
            }

            footBtnView.addSubview(markBtn)
        }
        mainTableView.tableFooterView = footBtnView
    }
    
    //MARK:下载视频点击事件
    @objc func showDownloadBtn(sender:UIButton) {
        
        if sender.titleLabel?.text == "作业视频讲解" {
            downloadType = 1
        }
        
        if sender.titleLabel?.text == "作业答案文档下载" {
            downloadType = 2
        }
        
        if sender.titleLabel?.text == "文字版答案" {
            downloadType = 3
        }
        
        if Defaults[HavePayPassword] == "yes" {
            let passwd = HBAlertPasswordView.init(frame: self.view.bounds)
            passwd.delegate = self
            
            if currentIndex == 1 {
                
            }else{
                
            }
            var theModel = PayModel()
            
            for model11 in payModels {
                let m = model11 as! PayModel
                if m.type == String(downloadType) {
                    theModel = m
                }
            }
            
            passwd.titleLabel.text = "请支付"+theModel.money+"学币"
            self.view.addSubview(passwd)
        }else{
            let aboutVC = LNSetPswViewController()
            self.navigationController?.pushViewController(aboutVC, animated: true)
            
        }
        
    }
    
    
    //    HBAlertPasswordViewDelegate 密码弹框代理
    func sureAction(with alertPasswordView: HBAlertPasswordView!, password: String!) {
        alertPasswordView.removeFromSuperview()
        
        var theModel = PayModel()
        
        for model11 in payModels {
            let m = model11 as! PayModel
            if m.type == String(downloadType) {
                theModel = m
            }
        }
        
        let params = [
            "SESSIONID":SESSIONID,
            "mobileCode":mobileCode,
            "teacher_id":theModel.teacher_id!,
            "money":theModel.money,
            "PasswordAgo":password,
            "bookId":model.work_book_Id,
            "type":downloadType
            ] as [String : Any]
        self.view.beginLoading()
        NetWorkStudentUpdownAnswrs(params: params) { (flag) in
            if flag {
                setToast(str: "下载成功！")
                self.view.endLoading()
                self.requestData()
            }
            self.view.endLoading()
        }
        
        if currentIndex == 3 {
            
            footView(titles: titleArr3)
        }
    }

    
//    //MARK:下载视频点击事件
//    @objc func showDownloadBtn(sender:UIButton) {
//
//        let passwd = HBAlertPasswordView.init(frame: self.view.bounds)
//        passwd.delegate = self
//
//        passwd.titleLabel.text = "请支付5学币"
//        self.view.addSubview(passwd)
//
//        if currentIndex == 3 {
//            currentTitle2 = (sender.titleLabel?.text)!
//        }
//    }
//
//
//    //    HBAlertPasswordViewDelegate 密码弹框代理
//    func sureAction(with alertPasswordView: HBAlertPasswordView!, password: String!) {
//        alertPasswordView.removeFromSuperview()
////        setToast(str: "输入的密码为:"+password)
//        let params =
//            [
//                "teacher_id":model.teacher_id!,
//                "bookId":model.work_book_Id,
//                "money":"1",
//                "type":"1",
//                "SESSIONID":SESSIONID,
//                "mobileCode":mobileCode
//                ] as [String:Any]
//        NetWorkStudentUpdownAnswrs(params: params) { (flag) in
//            if flag {
//
//            }
//        }
//
//        titleArr3.remove(at: titleArr3.index(of: currentTitle2)!)
//        footView(titles: titleArr3)
//        mainTableView.reloadData()
//    }

    
    //MARK:  ******代理 ：UITableViewDataSource,UITableViewDelegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if currentIndex == 4 {
            return 20
        }
        
        if currentIndex == 3 {
            return answerArr.count
        }
        
        if currentIndex == 2 {
            return pointArr.count
        }
        
        if currentIndex == 1 {
            
            if theModel.scores == "5" {
                return 1
            }
            
            if workState == "" {
                workState = "1"
            }
            if Int(workState)! > 3 {
                return 2
            }
        }
        return 1
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if currentIndex == 1 && workState == "1" && indexPath.row == 0{
            let cell : UpLoadWorkCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable1, for: indexPath) as! UpLoadWorkCell
            
            cell.upLoadImagesForWorkBook(images: images as! Array<UIImage>)
            
            cell.chooseImagesAction = {

                if $0 == "uploadAction" {
                    let params =
                        [
                            "SESSIONID":SESSIONID,
                            "mobileCode":mobileCode,
                            "result":cell.workDescrip.text!,
                            "userWorkBookId":self.model.userWorkBookId
                            ] as! [String : String]
                    
                    var nameArr = [String]()
                    for index in 0..<self.images.count {
                        nameArr.append("image\(index)")
                    }
                    netWorkForUploadWorkBook(params: params , data: self.images as! [UIImage], name: nameArr, success: { (datas) in
                        let json = JSON(datas)
                        deBugPrint(item: json)
//
//                        if json["code"] == "1" {
                        
//                            setToast(str: "上传成功")
                        self.uploadSucceed(datas: json.arrayValue)
                        
                        
//                        }
                        deBugPrint(item: datas)
                    }, failture: { (error) in
                        deBugPrint(item: error)
                    })
                    
                }else{
                    self.setupPhoto1(count: 2,currentIndex: Int($0)!)
                }
            }
            
            return cell
        }
        
        if currentIndex == 1 && workState == "2" && indexPath.row == 0{
            let cell : CheckWorkCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable2, for: indexPath) as! CheckWorkCell
            
            cell.checkWorkCellSetValues1(model:theModel)
            return cell
        }
        
        if currentIndex == 1 && workState == "3" {
            
            if indexPath.row == 0 {
                let cell : CheckWorkCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable2, for: indexPath) as! CheckWorkCell
                cell.checkWorkCellSetValues2(model:theModel)
                cell.resubmitAction = {
                    self.workState = "1"
                    tableView.reloadData()
                }
                cell.complainAction = {
                    let complianVC = ComplaintViewController()
                    self.navigationController?.pushViewController(complianVC, animated: true)
                }
                return cell
            }
        }
        
        if currentIndex == 1 && workState == "4" {
            
            if  indexPath.row == 0 {
                let cell : CheckWorkCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable2, for: indexPath) as! CheckWorkCell
                cell.checkWorkCellSetValues3(model:theModel)
                cell.complainAction = {
                    let complianVC = ComplaintViewController()
                    self.navigationController?.pushViewController(complianVC, animated: true)
                }
                
                return cell
            }
            
            let cell : UpLoadWorkCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable1, for: indexPath) as! UpLoadWorkCell
            cell.upLoadImagesForResubmit(images: images as! Array<UIImage>)
            
            cell.chooseImagesAction = {
                if $0 == "uploadAction" {
                    
                    let date = NSDate.init()
                    let formatter = DateFormatter()
                    //日期样式
                    formatter.dateFormat = "yyyy/MM/dd"
//                    let createDate = formatter.date(from: self.selectDate)
                    
                    let dateStr = self.selectDate.substring(to: String.Index.init(encodedOffset: 10))
                    
                    if formatter.string(from: date as Date) != dateStr {
                        setToast(str: "只能上传当天的作业")
                        return
                    }
                    
                    let params =
                        [
                            "bookId":self.theModel.book_details_id,
                            "type":"2",
                            "SESSIONID":SESSIONID,
                            "mobileCode":mobileCode
                    ]
                    var nameArr = [String]()
                    
                    for index in 0..<self.images.count {
                        nameArr.append("image\(index)")
                    }
                    self.view.beginLoading()
                    netWorkForUploadWorkBookSecondBulidBook(params: params as! [String : String], data: self.images as! [UIImage], name: nameArr, success: { (datas) in
                        deBugPrint(item: datas)
                        let json = JSON(datas)
                        deBugPrint(item: json)
                        if json["code"] == "1" {
                            
                            setToast(str: "上传成功")
                            self.uploadSucceed(datas: json.arrayValue)
                        }
                        self.view.endLoading()
                    }, failture: { (error) in
                        deBugPrint(item: error)
                        self.view.endLoading()
                    })
                }else{
                    self.setupPhoto1(count: 2,currentIndex: Int($0)!)
                }
            }
            return cell
        }
        
        if currentIndex == 1 && workState == "5" {
            
            let cell : CheckWorkCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable2, for: indexPath) as! CheckWorkCell
            if  indexPath.row == 0 {
                
                cell.checkWorkCellSetValues3(model:theModel)
                return cell
            }
            cell.checkWorkCellSetValues1(model:theModel)
            return cell
        }
        
        if currentIndex == 1 && workState == "6" {
            let cell : CheckWorkCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable2, for: indexPath) as! CheckWorkCell

            if  indexPath.row == 0 {
                
                cell.checkWorkCellSetValues3(model:theModel)
                return cell
            }
            
            cell.checkWorkCellSetValues2(model:theModel)
            return cell
        }

        if currentIndex == 1 && workState == "7" {
            
            if  indexPath.row == 0 {
                
                let cell : CheckWorkCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable2, for: indexPath) as! CheckWorkCell
                cell.checkWorkCellSetValues3(model:theModel)
                return cell
            }
            let cell : CheckWorkCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable2, for: indexPath) as! CheckWorkCell
            cell.checkWorkCellSetValues4(model: theModel)
            return cell
        }
        
        if currentIndex == 2 {
            
            let model = pointArr[indexPath.row] as! UrlModel
            
            let cell : AnserVideoCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable3, for: indexPath) as! AnserVideoCell
            cell.AnserVideoCellSetValues(model: model)
            return cell
        }else if currentIndex == 3 {
            
            let model = answerArr[indexPath.row] as! UrlModel
            
            if model.type == "1" {
                let cell : AnserVideoCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable3, for: indexPath) as! AnserVideoCell
                cell.AnserVideoCellSetValues(model: model)
                return cell
                
            }else if model.type == "2" {
                let cell : ShowFileCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable7, for: indexPath) as! ShowFileCell
                return cell
            }else if model.type == "3" {
                let cell : ShowWriteAnswerCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable8, for: indexPath) as! ShowWriteAnswerCell
                return cell
            }else{
                let cell : AnswerImageCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable12, for: indexPath) as! AnswerImageCell
                return cell
            }
        }
        
        let cell : showGradeCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable4, for: indexPath) as! showGradeCell
        if indexPath.row == 0 {
            cell.showGrade(isTitle: true)
        }else{
            cell.showGrade(isTitle: false)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if currentIndex == 2 {
            let model = pointArr[indexPath.row] as! UrlModel
            let webVc = WebViewController()
            webVc.webUrl = model.point_address
            webVc.theTitle = model.point_title
            self.navigationController?.pushViewController(webVc, animated: true)
        }
        if currentIndex == 3 {
            let model = answerArr[indexPath.row] as! UrlModel
            if model.type == "1" {
                let webVc = WebViewController()
                webVc.webUrl = model.answard_res
                webVc.theTitle = model.title
                self.navigationController?.pushViewController(webVc, animated: true)
            }else if model.type == "2" {
                if model.format == "img" {
                    let cell = tableView.cellForRow(at: indexPath) as! AnswerImageCell
                    var images = [KSPhotoItem]()
                    
                    let watchIMGItem = KSPhotoItem.init(sourceView: cell.showImage, image: cell.showImage.image)
                    images.append(watchIMGItem!)
                    
                    let watchIMGView = KSPhotoBrowser.init(photoItems: images,
                                                           selectedIndex:UInt(0))
                    watchIMGView?.dismissalStyle = .scale
                    watchIMGView?.backgroundStyle = .blurPhoto
                    watchIMGView?.loadingStyle = .indeterminate
                    watchIMGView?.pageindicatorStyle = .text
                    watchIMGView?.bounces = false
                    watchIMGView?.show(from: self)
                }else{
                    
                }
            }
        }

//            let url = NSURL.init(string: "http://m.youku.com/video/id_XMzA4MDYxNzQ2OA==.html?spm=a2hww.20022069.m_215416.5~5%212~5~5%212~A&source=http%3A%2F%2Fyouku.com%2Fu%2F13656654646%3Fscreen%3Dphone")
//
//            if #available(iOS 10.0, *) {
//                UIApplication.shared.open(url! as URL, options: [:],
//                                          completionHandler: {
//                                            (success) in
//                })
//            } else {
//                // Fallback on earlier versions
//            }
        
    }
    
    
    func uploadSucceed(datas:Array<Any>) {
        
        self.mainTableView.mj_header.beginRefreshing()
        
        //        通知中心
        NotificationCenter.default.post(name: Notification.Name(rawValue: SuccessUploadWorkNotiS), object: self, userInfo: ["refresh":"begin"])

        
//        let params =
//            [
//                "userWorkBookId":self.model.userWorkBookId!,
//                "SESSIONID":SESSIONID,
//                "time":selectDate,
//                "mobileCode":mobileCode
//                ] as [String:Any]
//        self.view.beginLoading()
//        netWorkForGetWorkBookByTime(params: params) { (dataArr,flag) in
//            if flag {
//                if datas.count > 0{
//                    self.theModel = dataArr[0] as! BookDetailModel
//                    self.workState = self.theModel.correcting_states
//                    if self.workState == "" {
//                        self.workState = "1"
//                    }
//                    self.images.removeAllObjects()
//                    self.mainTableView.reloadData()
//                }
//                deBugPrint(item: dataArr)
//            }
//            self.view.endLoading()
//        }

    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
//        if section == 0 && currentIndex == 1 {
//            dateBtn = UIButton.init(frame: CGRect(x: 0, y: 44 , width: kSCREEN_WIDTH, height: 40))
//            dateBtn.backgroundColor = UIColor.white
//            dateBtn.titleLabel?.font = kFont30
//            dateBtn.setTitleColor(kGaryColor(num: 164), for: .normal)
//            dateBtn.setImage(#imageLiteral(resourceName: "xiala_icon_default"), for: .normal)
//            dateBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -35, 0, 0)
//            dateBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 145, 0, 0)
//            dateBtn.setTitle(selectDate, for: .normal)
//            dateBtn.addTarget(self, action: #selector(chooseDateAction(sender:)), for: .touchUpInside)
//
//            let line2 = UIView.init(frame: CGRect(x: 0, y: 43 , width: kSCREEN_WIDTH, height: 1))
//            line2.backgroundColor = kGaryColor(num: 223)
//            dateBtn.addSubview(line2)
//            return dateBtn
//        }
        return UIView()
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
//        if section == 0 && currentIndex == 1 {
//            return 44
//        }
//
        return 0
    }
    
    
    // 异步原图
    private func setupPhoto1(count:NSInteger,currentIndex:NSInteger) {
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
                
                if (self?.images.count)!<2{
                    self?.images.add(image)
                }else{
                    self?.images[currentIndex] = image
                }
                
                self?.dealImage(imageArr: imageArr, index: index)
                self?.mainTableView.reloadData()
                
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
    
    var datePickerView = UIView()
    var datePicker = UIDatePicker()
    
    func addTimeSelector() {
        
        //        弹出视图弹出来之后的背景蒙层
        BGView = UIView.init(frame: self.view.frame)
        BGView.backgroundColor = kSetRGBAColor(r: 5, g: 5, b: 5, a: 0.5)
        BGView.alpha = 0
        //        BGView.isHidden = true
        
        let tapGes1 = UITapGestureRecognizer.init(target: self, action: #selector(showChooseCondi(tap:)))
        tapGes1.numberOfTouchesRequired = 1
        BGView.addGestureRecognizer(tapGes1)
        
        self.view.addSubview(BGView)
        
        
        //MARK:   时间选择器背景
        datePickerView = UIView.init(frame: CGRect(x: 0, y: kSCREEN_HEIGHT, width: kSCREEN_WIDTH, height: DateHeight))
        datePickerView.backgroundColor = UIColor.white
        datePickerView.layer.cornerRadius = 16 * kSCREEN_SCALE
        
        //MARK:  把datapicker的背景设为透明，这个selecView可以模拟选择栏
        let selectView = UIView.init(frame: CGRect(x: 0, y: DateHeight/2-17, width: kSCREEN_WIDTH, height: 34))
        selectView.backgroundColor = kMainColor()
        //        selectView.center = datePickerView.center
        datePickerView.addSubview(selectView)
        
        
        //创建日期选择器
        datePicker = UIDatePicker(frame: CGRect(x:0, y: 0, width:kSCREEN_WIDTH, height:DateHeight))
        //将日期选择器区域设置为中文，则选择器日期显示为中文
        datePicker.locale = Locale(identifier: "zh_CN")
        
        datePicker.addTarget(self, action: #selector(dateChanged),
                             for: .valueChanged)
        datePicker.backgroundColor = UIColor.clear
        datePicker.datePickerMode = .date
        datePicker.maximumDate = NSDate.init(timeIntervalSinceNow: 0) as Date
        datePicker.minimumDate = NSDate.init(timeIntervalSinceNow: -1296000) as Date
        datePickerView.addSubview(datePicker)
        
        //MARK:  顶部需要显示三个控件
        let topView = UIView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 100 * kSCREEN_SCALE))
        topView.backgroundColor = kMainColor()
        topView.layer.cornerRadius = 16 * kSCREEN_SCALE
        
        //MARK:  取消按钮
        let cancel = UIButton.init(frame: CGRect(x: 15, y: 20 * kSCREEN_SCALE, width: 45, height: 60 * kSCREEN_SCALE))
        cancel.titleLabel?.font = kFont32
        cancel.setTitle("取消", for: .normal)
        cancel.setTitleColor(UIColor.white, for: .normal)
        cancel.addTarget(self, action: #selector(cancelAction(sender:)), for: .touchUpInside)
        topView.addSubview(cancel)
        
        //MARK:   确定按钮
        let contain = UIButton.init(frame: CGRect(x: kSCREEN_WIDTH - 60, y: 20 * kSCREEN_SCALE, width: 45, height: 60 * kSCREEN_SCALE))
        contain.titleLabel?.font = kFont32
        contain.setTitle("确定", for: .normal)
        contain.setTitleColor(UIColor.white, for: .normal)
        contain.addTarget(self, action: #selector(containAction(sender:)), for: .touchUpInside)
        topView.addSubview(contain)
        
        //MARK:  题目
        let titleLabel = UILabel.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH - 120, height: 60 * kSCREEN_SCALE))
        titleLabel.text = "选择日期"
        titleLabel.font = kFont36
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .center
        titleLabel.center = topView.center
        
        topView.addSubview(titleLabel)
        
        datePickerView.addSubview(topView)
        
        //MARK:  因为需要设置圆角 还是只能上面有，所以我又给下面盖了一个。。。
        let theView = UIView.init(frame: CGRect(x: 0, y: 80 * kSCREEN_SCALE, width: kSCREEN_WIDTH, height: 20 * kSCREEN_SCALE))
        theView.backgroundColor = kMainColor()
        datePickerView.addSubview(theView)
        self.view.addSubview(datePickerView)
        
    }
    
    
    //MARK: 模拟蒙层的点击事件 隐藏
    @objc func showChooseCondi(tap:UITapGestureRecognizer) -> Void {
        if tap.view?.alpha == 1 {
            
            UIView.animate(withDuration: 0.5) {
                tap.view?.alpha = 0
                self.datePickerView.transform = .identity
                self.dateBtn.setImage(#imageLiteral(resourceName: "date_dropdown-arrow_icon"), for: .normal)
            }
        }
    }
    
    //MARK://日期选择器响应方法
    @objc func dateChanged(datePicker : UIDatePicker){
        //更新提醒时间文本框
        let formatter = DateFormatter()
        //日期样式
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        deBugPrint(item: formatter.string(from: datePicker.date))
    }
    
    
    //MARK:      取消事件
    @objc func cancelAction(sender:UIButton) {
        UIView.animate(withDuration: 0.5) {
            self.dateBtn.setImage(#imageLiteral(resourceName: "date_dropdown-arrow_icon"), for: .normal)
            self.datePickerView.transform = .identity
            self.BGView.alpha = 0
        }
    }
    
    @objc func containAction(sender:UIButton) {
        
        let formatter = DateFormatter()
        //日期样式
        formatter.dateFormat = "yyyy-MM-dd"
        deBugPrint(item: formatter.string(from: self.datePicker.date))
        self.selectDate = formatter.string(from: self.datePicker.date)
        
//        let date = NSDate.init()
        let formatter1 = DateFormatter()
        //日期样式
        formatter1.dateFormat = "yyyy-MM-dd"

//        if !timeArr.contains(selectDate) && selectDate != formatter1.string(from: date as Date) {
//            setToast(str: "你在"+selectDate+"没有相关作业！")
//            return
//        }

        selectDate = formatter.string(from: self.datePicker.date as Date)
//        self.navigationItem.rightBarButtonItem?.title = selectDate
        self.dateBtn.setTitle(formatter.string(from: self.datePicker.date), for: .normal)
        if currentIndex == 1 {
            
            let params =
                [
                    "userWorkBookId":self.model.userWorkBookId!,
                    "time":formatter.string(from: self.datePicker.date),
                    "SESSIONID":SESSIONID,
                    "mobileCode":mobileCode
                    ] as [String:Any]
            self.view.beginLoading()
            netWorkForGetWorkBookByTime(params: params) { (dataArr,flag) in
                if flag {
                    if dataArr.count > 0{
                        self.theModel = dataArr[0] as! BookDetailModel
                        self.workState = self.theModel.correcting_states
                        if self.workState == "" {
                            self.workState = "1"
                        }
                        self.mainTableView.reloadData()
                    }
                    deBugPrint(item: dataArr)
                }
                self.view.endLoading()
            }

        }else{
            
            
        }
        UIView.animate(withDuration: 0.5) {
            self.dateBtn.setImage(#imageLiteral(resourceName: "date_dropdown-arrow_icon"), for: .normal)
            self.datePickerView.transform = .identity
            self.BGView.alpha = 0
        }
    }
    
    
    //MARK:   弹出视图DatePicker的出现事件
    func showDatePickerView() -> Void {
        
        let y = DateHeight - 80 * kSCREEN_SCALE

        UIView.animate(withDuration: 0.5) {
            self.dateBtn.setImage(#imageLiteral(resourceName: "date_up-arrow_icon"), for: .normal)
            self.datePickerView.transform = .init(translationX: 0, y: -y)
            self.BGView.alpha = 1
        }
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        PopViewUtil.share.stopLoading()
    }
}
