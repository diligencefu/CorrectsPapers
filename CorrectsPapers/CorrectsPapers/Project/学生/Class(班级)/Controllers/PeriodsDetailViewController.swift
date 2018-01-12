//
//  PeriodsDetailViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/6.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyJSON
import SwiftyUserDefaults

class PeriodsDetailViewController: BaseViewController ,HBAlertPasswordViewDelegate{
    var typeArr = ["课程视频","我的作业","参考答案","五星作业"]
    var headView = UIView()
    var buttonView = UIView()
    var footBtnView = UIView()

    
    let identyfierTable7 = "identyfierTable7"
    let identyfierTable8 = "identyfierTable8"
    let identyfierTable9 = "identyfierTable9"
    let identyfierTable10 = "identyfierTable10"
    let identyfierTable11 = "identyfierTable11"
    let identyfierTable12 = "identyfierTable12"

    
    var underLine = UIView()
    var NofitICLabel = UILabel()
    
    var currentIndex = 1
    
    var searchTextfield = UITextField()
    
    var titleArr1 = ["本节课课程视频","本节课讲义下载","本节课作业下载"]
    var titleArr3 = ["作业视频讲解","作业答案文档下载","文字版答案"]
    
    var currentTitle1 = ""
    var currentTitle2 = ""
//当前课时
    var pModel = TPeriodsModel()
    
//    参考答案显示相关
    var workVideoModel = PayModel()
    var workAnswerModel = PayModel()
    var workTextModel = PayModel()
    
    var payModels = NSMutableArray()
    var type = [String]()
    var noAnswerTypes = [String]()
    
    
//    课程视频显示相关
    var workVideoModel1 = PayModel()
    var workAnswerModel1 = PayModel()
    var workTextModel1 = PayModel()
    
    var payModels1 = NSMutableArray()
    var type1 = [String]()
    var noVideoTypes = [String]()

//    下载答案/视频类型
    var downloadType = 100
    
//    作业状态
    var workState = 1
//    我的作业模型
    var mainModel = TClassWorkModel()
    
//    上传作业的图片
    var images = NSMutableArray()

    
//    网络数据源
//    课程视频
    var vedioArr = NSMutableArray()
//    参考答案
    var answerArr = NSMutableArray()
//    五星作业
    var goodWorkArr = NSMutableArray()

    var workModel = PayVideoModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func requestData() {
        
        titleArr3 = ["作业视频讲解","作业答案文档下载","文字版答案"]

        let params1 =
            [
                "bookId":pModel.periods_id,
                "SESSIONID":SESSIONID,
                "mobileCode":mobileCode
                ] as [String:Any]
        NetWorkStudentCheckPay(params: params1) { (pays,flag) in
            if flag && pays.count > 0{
                self.payModels.removeAllObjects()
                self.type.removeAll()
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
                    
                    if self.titleArr3.contains("作业视频讲解") {
                        self.titleArr3.remove(at: self.titleArr3.index(of: "作业视频讲解")!)
                        self.type.append("1")
                    }
                }
                
                if self.workAnswerModel.isPay != "no" && self.workAnswerModel.isPay != nil {
                    if self.titleArr3.contains("作业答案文档下载") {
                        self.titleArr3.remove(at: self.titleArr3.index(of: "作业答案文档下载")!)
                        self.type.append("2")
                    }
                }
                
                if self.workTextModel.isPay != "no" && self.workTextModel.isPay != nil{
                    if self.titleArr3.contains("文字版答案") {
                        self.titleArr3.remove(at: self.titleArr3.index(of: "文字版答案")!)
                        self.type.append("3")
                    }
                }
                
                if self.currentIndex == 3 {
                    
                    self.mainTableView.mj_header.beginRefreshing()
                    self.footView(titles: self.titleArr3)
                }
            }
            self.view.endLoading()
        }
        
        let params2 =
            [
                "bookId":pModel.periods_id,
                "SESSIONID":SESSIONID,
                "mobileCode":mobileCode
                ] as [String:Any]

        NetWorkStudentCheckPayDoc(params: params2) { (pays,flag) in
            if flag && pays.count > 0{
                self.payModels.addObjects(from: pays)
                self.type1.removeAll()

                for model in pays {
                    let m = model as! PayModel
                    
                    if m.type == "4"{
                        self.workVideoModel1 = m
                    }
                    if m.type == "5"{
                        self.workAnswerModel1 = m
                    }
                    if m.type == "6"{
                        self.workTextModel1 = m
                    }
                    self.noVideoTypes.append(m.type!)
                }

                if self.workVideoModel1.isPay != "no" && self.workVideoModel1.isPay != nil {
                    self.titleArr1.remove(at: self.titleArr1.index(of: "本节课课程视频")!)
                    self.type1.append("4")
                }
                
                if self.workAnswerModel1.isPay != "no" && self.workAnswerModel1.isPay != nil {
                    self.titleArr1.remove(at: self.titleArr1.index(of: "本节课讲义下载")!)
                    self.type1.append("5")
                }
                
                if self.workTextModel1.isPay != "no" && self.workTextModel1.isPay != nil{
                    self.titleArr1.remove(at: self.titleArr1.index(of: "本节课作业下载")!)
                    self.type1.append("6")
                }
                
                if self.currentIndex == 1 {
                    self.mainTableView.mj_header.beginRefreshing()
                    self.footView(titles: self.titleArr1)
                }
                
            }
            self.view.endLoading()
        }
        
        let params3 =
            [
                "periods_id":pModel.periods_id,
                "SESSIONID":SESSIONID,
                "mobileCode":mobileCode
                ] as [String:Any]

        NetWorkStudentCheckBuyClassBook(params: params3) { (datas, flag) in
            if flag && datas.count > 0{
                self.workModel = datas[0] as! PayVideoModel
                
                if self.workModel.isPay == "yes" && self.currentIndex == 2{
                    self.footBtnView.removeFromSuperview()
                }
                self.mainTableView.reloadData()
            }
            self.view.endLoading()
        }
    }
    
    
    override func configSubViews() {
        
        self.navigationItem.title = pModel.name
        
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
        
        mainTableView.register(UINib(nibName: "SUploadWorkCell", bundle: nil), forCellReuseIdentifier: identyfierTable1)
        mainTableView.register(UINib(nibName: "ShowWorkStateCell", bundle: nil), forCellReuseIdentifier: identyfierTable2)
        mainTableView.register(UINib(nibName: "AnserVideoCell", bundle: nil), forCellReuseIdentifier: identyfierTable3)
        mainTableView.register(UINib(nibName: "TGoodWorkCell", bundle: nil), forCellReuseIdentifier: identyfierTable4)
        mainTableView.register(UINib(nibName: "ShowWorkNotDone", bundle: nil), forCellReuseIdentifier: identyfierTable5)
        mainTableView.register(UINib(nibName: "ShowFileCell", bundle: nil), forCellReuseIdentifier: identyfierTable7)
        mainTableView.register(UINib(nibName: "ShowWriteAnswerCell", bundle: nil), forCellReuseIdentifier: identyfierTable8)
        mainTableView.register(UINib(nibName: "AnswerImageCell", bundle: nil), forCellReuseIdentifier: identyfierTable12)

        self.view.addSubview(mainTableView)
        footView(titles: titleArr1)
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
            
            if currentIndex == 3 {
                
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

            }else  if currentIndex == 1{
                
                if titles[index] == "本节课课程视频" {
                    theType = "4"
                }
                if titles[index] == "本节课讲义下载" {
                    theType = "5"
                }
                if titles[index] == "本节课作业下载" {
                    theType = "6"
                }
                
                if !noVideoTypes.contains(theType) {
                    
                    markBtn.setBackgroundImage(getNavigationIMG(27, fromColor: kGaryColor(num: 220), toColor: kGaryColor(num: 220)), for: .normal)
                    markBtn.isEnabled = false
                }
            }else{
                
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
        
        if sender.titleLabel?.text == "本节课课程视频" {
            downloadType = 1+3
        }
        
        if sender.titleLabel?.text == "本节课讲义下载" {
            downloadType = 2+3
        }
        
        if sender.titleLabel?.text == "本节课作业下载" {
            downloadType = 3+3
        }
        
        if Defaults[HavePayPassword] == "yes" {
            
            let passwd = HBAlertPasswordView.init(frame: self.view.bounds)
            passwd.delegate = self

            if currentIndex == 2 {
                
                passwd.titleLabel.text = "请支付"+workModel.scores_one+"学币"
            }else{
                
                var theModel = PayModel()
                for model11 in payModels {
                    let m = model11 as! PayModel
                    if m.type == String(downloadType) {
                        theModel = m
                    }
                }
                passwd.titleLabel.text = "请支付"+theModel.money+"学币"
            }
            self.view.addSubview(passwd)
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
            
            self.underLine.center = CGPoint(x:  sender.center.x, y:  self.underLine.center.y)
        })
        
        currentIndex = sender.tag - 130
        mainTableView.reloadData()
  
        if currentIndex == 1 {
            footView(titles: titleArr1)
        }else if currentIndex == 3 {
            footView(titles: titleArr3)
        }else if currentIndex == 2 && workModel.isPay == "no"{
            footView(titles: ["开通本课时作业"])
        }else{
            footBtnView.removeFromSuperview()

        }
        refreshHeaderAction()
    }
    
    
    override func refreshHeaderAction() {
        self.mainTableView.mj_header.endRefreshing()

        self.view.beginLoading()

        if currentIndex == 1 {
            let type = self.type1.joined(separator: ",")
            let params1 =
                [
                    "bookId":pModel.periods_id,
                    "type":type,
                    "SESSIONID":SESSIONID,
                    "mobileCode":mobileCode
                    ] as [String:Any]
            NetWorkStudentGetPeriodsList(params: params1) { (datas, flag) in
                if flag {
                    self.vedioArr.removeAllObjects()
                    self.vedioArr.addObjects(from: datas)
                    self.mainTableView.reloadData()
                }
                self.mainTableView.mj_header.endRefreshing()
                self.view.endLoading()
            }

        }else if currentIndex == 2{
            let params =
                [
                    "periods_id":pModel.periods_id,
                    "SESSIONID":SESSIONID,
                    "mobileCode":mobileCode
                    ] as [String:Any]

            netWorkForGetMyClassBookByPeriods(params: params, callBack: { (datas,flag) in
                
                if flag {
                    
                    if datas.count == 0 {
                        self.workState = 1
                    }else{
                        self.mainModel = datas[0] as! TClassWorkModel
                        self.workState = Int(self.mainModel.type)!
                    }
                    self.mainTableView.reloadData()
                }
                
                self.view.endLoading()
                self.mainTableView.mj_header.endRefreshing()
            })
            
        }else if currentIndex == 3 {
            let type = self.type.joined(separator: ",")
            let params1 =
                [
                    "bookId":pModel.periods_id,
                    "type":type,
                    "SESSIONID":SESSIONID,
                    "mobileCode":mobileCode
                    ] as [String:Any]
            NetWorkStudentGetOtherAnswrs(params: params1) { (datas, flag) in
                if flag {
                    self.answerArr.removeAllObjects()
                    self.answerArr.addObjects(from: datas)
                    self.mainTableView.reloadData()
                }
                self.view.endLoading()
            }
            
        }else if currentIndex == 4 {
            let params1 =
                [
                    "periods_id":pModel.periods_id,
                    "type":"2",
                    "SESSIONID":SESSIONID,
                    "mobileCode":mobileCode
                    ] as [String:String]

            NetWorkTeacherGetScroes(params: params1, callBack: { (datas, flag) in
                
                if flag {
                    self.goodWorkArr.removeAllObjects()
                    self.goodWorkArr.addObjects(from: datas)
                    self.mainTableView.reloadData()
                }
                self.mainTableView.mj_header.endRefreshing()
                self.view.endLoading()

            })
        }
        
    }
    
    
    
    //MARK:  ******代理 ：UITableViewDataSource,UITableViewDelegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if currentIndex == 3 {
            return answerArr.count
        }
        
        if currentIndex == 2 {
            
            if workModel.isPay == "no" {
                return 0
            }
            
            if workState < 4 {
                return 1
            }
            
            if workState == 7 && mainModel.scores == "5" {
                return 1
            }
            
            return 2
        }
        
        if currentIndex == 1 {
            return vedioArr.count
        }
        
        return goodWorkArr.count
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if currentIndex == 1 {
            let model = vedioArr[indexPath.row] as! UrlModel
            deBugPrint(item: model.type!)
            deBugPrint(item: model.format!)
            if model.type == "1" {
                
                let cell : AnserVideoCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable3, for: indexPath) as! AnserVideoCell
                cell.AnserVideoCellSetValuesForAnswer(title: model.title)
                return cell
            }else  if model.type == "2" {
                
                if model.format == "doc" || model.format == "xls"{
                    let cell : ShowFileCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable7, for: indexPath) as! ShowFileCell
                    cell.setValues(model: model)
                    return cell
                }else{
                    
                    let cell : AnswerImageCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable12, for: indexPath) as! AnswerImageCell
                    cell.showWithImage(image: model.answard_res)
                    cell.selectionStyle = .none
                    return cell
                }
                
            }else{
                let cell : ShowWriteAnswerCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable8, for: indexPath) as! ShowWriteAnswerCell
                cell.showAnswer(text: model.answard_res)
                cell.selectionStyle = .none
                return cell
            }
        }else if currentIndex == 2 {
            if workState == 1 {
                let cell : SUploadWorkCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable1, for: indexPath) as! SUploadWorkCell
                cell.SUploadWorkCellSetValues(images: images as! [UIImage])
                
                cell.addImageAction = {
                    deBugPrint(item: $0)
//                    if $0 == "Upload" {
//                    }
                    self.setupPhoto1(count: 30)
                }
                
                cell.upLoadImagesAction = {
                    let params =
                        [
                            "SESSIONID":SESSIONID,
                            "mobileCode":mobileCode,
                            "periods_id":self.pModel.periods_id,
                            "title":cell.bookTitle.text!,
                    ] as [String:String]
                    let nameArr = [String]()
//                    for index in 0..<self.images.count {
//                        nameArr.append("Class_WorkBook_Image\(index)")
//                    }
//                    nameArr.append("User_headImage")
                    upLoadClassWorkImageRequest(params: params, data: self.images as! [UIImage], name: nameArr, success: { (success) in
                        deBugPrint(item: success)
                        let json = JSON(success)
                        deBugPrint(item: json)
                        
                        if json["code"] == "1" {
                            setToast(str: "上传成功")                            
                        }
                        
                        tableView.mj_header.beginRefreshing()

                    }, failture: { (error) in
                        deBugPrint(item: error)
                    })
                }
                
                cell.deletImageAction = {
                    self.images.removeObject(at: $0)
                    tableView.reloadData()
                }
                cell.selectionStyle = .none
                return cell
                
            }else{
                
                let cell : ShowWorkNotDone = tableView.dequeueReusableCell(withIdentifier: identyfierTable5, for: indexPath) as! ShowWorkNotDone
                
                if workState == 2 || workState == 3{
                    
                    if mainModel.class_book_id != nil {
                        cell.ShowWorkNotDoneForState(model: mainModel)
                    }
                    
                    cell.conplainOrreSubmit = {
                        if $0 == "resubmit" {
                            self.workState = 1
                            self.mainTableView.reloadData()
                        }else{
                            let complainVC = ComplaintViewController()
                            self.navigationController?.pushViewController(complainVC, animated: true)
                        }
                    }
                    return cell
                    
                }else if workState == 4 {
                    
                    if indexPath.row == 0 {
                        
                        let cell : ShowWorkStateCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable2, for: indexPath) as! ShowWorkStateCell
                        cell.TGoodWorkCellSetValueForWaitCorrect(model: mainModel)
                        return cell
                    }
                    
                    let cell : SUploadWorkCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable1, for: indexPath) as! SUploadWorkCell
                    cell.SUploadWorkCellResubmit(images: images as! [UIImage])
                    
                    cell.addImageAction = {
                        deBugPrint(item: $0)
                        self.setupPhoto1(count: 30)
                    }
                    
                    cell.upLoadImagesAction = {
                        let params =
                            [
                                "SESSIONID":SESSIONID,
                                "mobileCode":mobileCode,
                                "classes_book_id":self.mainModel.class_book_id,
                        ] as [String:String]
                        var nameArr = [String]()
                        for index in 0..<self.images.count {
                            nameArr.append("Class_WorkBook_Image\(index)")
                        }
                        upLoadClassWorkImageRequestNext(params: params, data: self.images as! [UIImage], name: nameArr, success: { (success) in
                            deBugPrint(item: success)
                            let json = JSON(success)
                            deBugPrint(item: json)
                            
                            if json["code"] == "1" {
                                setToast(str: "上传成功")
                            }
                            tableView.mj_header.beginRefreshing()

                        }, failture: { (error) in
                            deBugPrint(item: error)
                        })
                    }
                    
                    cell.deletImageAction = {
                        self.images.removeObject(at: $0)
                        tableView.reloadData()
                    }
                    cell.selectionStyle = .none
                    return cell

                }else if workState == 5 {
                    
                    if indexPath.row == 0 {
                        
                        let cell : ShowWorkStateCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable2, for: indexPath) as! ShowWorkStateCell
                        cell.TGoodWorkCellSetValueForWaitCorrect(model:mainModel)
                        return cell
                    }
                    
                    let cell : ShowWorkNotDone = tableView.dequeueReusableCell(withIdentifier: identyfierTable5, for: indexPath) as! ShowWorkNotDone
                    cell.ShowWorkNotDoneForState(model: mainModel)
                    return cell
                }else if workState == 6 {
                    
                    if indexPath.row == 0 {
                        
                        let cell : ShowWorkStateCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable2, for: indexPath) as! ShowWorkStateCell
                        cell.TGoodWorkCellSetValueForWaitCorrect(model: mainModel)
                        return cell
                    }
                    
                    let cell : ShowWorkNotDone = tableView.dequeueReusableCell(withIdentifier: identyfierTable5, for: indexPath) as! ShowWorkNotDone
                    cell.ShowWorkNotDoneForState(model: mainModel)
                    cell.conplainOrreSubmit = {
                        
                        if $0 == "resubmit" {
                            self.workState = 4
                            self.mainTableView.reloadData()
                        }else{
                            let complainVC = ComplaintViewController()
                            self.navigationController?.pushViewController(complainVC, animated: true)
                        }
                    }

                    return cell
                }else{
                    let cell : ShowWorkStateCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable2, for: indexPath) as! ShowWorkStateCell

                    if indexPath.row == 0 {
                        cell.TGoodWorkCellSetValueForWaitCorrect(model: mainModel)
                        return cell
                    }else{
                        cell.TGoodWorkCellSetValueForFinish(model: mainModel)
                        return cell
                    }
                }
            }
            
        }else if currentIndex == 3 {
            
            let model = answerArr[indexPath.row] as! UrlModel
            deBugPrint(item: model.type!)
            deBugPrint(item: model.format!)
            if model.type == "1" {
                
                let cell : AnserVideoCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable3, for: indexPath) as! AnserVideoCell
                cell.AnserVideoCellSetValuesForAnswer(title: model.title)
                return cell
            }else  if model.type == "2" {
                
                if model.format == "doc" || model.format == "xls"{
                    let cell : ShowFileCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable7, for: indexPath) as! ShowFileCell
                    cell.setValues(model: model)
                    return cell
                }else{
                    
                    let cell : AnswerImageCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable12, for: indexPath) as! AnswerImageCell
                    cell.showWithImage(image: model.answard_res)
                    cell.selectionStyle = .none
                    return cell
                }
                
            }else{
                let cell : ShowWriteAnswerCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable8, for: indexPath) as! ShowWriteAnswerCell
                cell.showAnswer(text: model.answard_res)
                cell.selectionStyle = .none
                return cell
            }
            
        }else{
            
            let model = goodWorkArr[indexPath.row] as! LNClassWorkModel
            let cell : TGoodWorkCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable4, for: indexPath) as! TGoodWorkCell
            cell.TGoodWorkCellSetValueForGreade(model: model)
            return cell
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
                
        return UIView()
        
    }
    
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
                
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
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
    
    
    // 异步原图
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
                
                self?.images.add(image)
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
    
    
//    HBAlertPasswordViewDelegate 密码弹框代理
    func sureAction(with alertPasswordView: HBAlertPasswordView!, password: String!) {
        alertPasswordView.removeFromSuperview()

        var type = "0"
        var money = ""
        
        var theModel = PayModel()
        
        for model11 in payModels {
            let m = model11 as! PayModel
            if m.type == String(downloadType) {
                theModel = m
            }
        }

        if currentIndex == 2 {
            money = self.workModel.scores_one
            type = "7"
        }else{
            money = theModel.money
            type = theModel.type!
        }
        
        let params = [
            "SESSIONID":SESSIONID,
            "mobileCode":mobileCode,
            "teacher_id":self.workModel.head_teacher_id,
            "money":money,
            "PasswordAgo":password,
            "bookId":pModel.periods_id,
            "type":type
            ] as [String : Any]
        self.view.beginLoading()
        
        NetWorkStudentUpdownAnswrs(params: params) { (flag) in
            if flag {
                setToast(str: "下载成功！")
                self.view.endLoading()
                self.requestData()
                self.refreshHeaderAction()
            }
            self.view.endLoading()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        PopViewUtil.share.stopLoading()
    }
    
}
