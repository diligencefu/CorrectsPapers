//
//  MyBookDetailViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/1.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyJSON

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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTimeSelector()
//        workState = model.correct_state!
    }
    
    override func requestData() {
        
        let params =
            [
                "userWorkBookId":model.userWorkBookId!,
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
                print(dataArr)
            }
            self.view.endLoading()
        }
        
        netWorkForGetWorkBookTime(params: params) { (datas,flag) in
            if flag {
                self.timeArr = datas as! [String]
            }
            self.view.endLoading()
        }
    }
    
    
    override func refreshHeaderAction() {
        
        if currentIndex == 1 {
            let params =
                [
                    "userWorkBookId":model.userWorkBookId!,
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
                        self.mainTableView.mj_header.endRefreshing()
                        self.mainTableView.reloadData()
                    }
                    print(dataArr)
                }
                self.view.endLoading()
            }

        }else if currentIndex == 2 {
            
        }else if currentIndex == 3 {
            
        }else if currentIndex == 4 {
            
        }
        
    }
    
    override func configSubViews() {
        
        self.navigationItem.title = "非练习册"
        
        let date = NSDate.init()
        let formatter = DateFormatter()
        //日期样式
        formatter.dateFormat = "yyyy/MM/dd"
        
        selectDate = formatter.string(from: date as Date)
        
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
        
        self.view.addSubview(mainTableView)
    }
    
    
    @objc func chooseDateAction(sender:UIButton) {
        //        print(NSDate())
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
                    print(dataArr)
                }
                self.view.endLoading()
            }
        }else if currentIndex == 2 {
            
            let params =
                [
                    "workBookId":model.work_book_Id,
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
            
        }else if currentIndex == 4 {
            
        }
        
        self.mainTableView.mj_header.endRefreshing()
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
            footBtnView.addSubview(markBtn)
        }
        mainTableView.tableFooterView = footBtnView
    }
    
    
    //MARK:下载视频点击事件
    @objc func showDownloadBtn(sender:UIButton) {
        
        let passwd = HBAlertPasswordView.init(frame: self.view.bounds)
        passwd.delegate = self
        
        passwd.titleLabel.text = "五哈哈哈哈"
        self.view.addSubview(passwd)
        
        if currentIndex == 3 {
            currentTitle2 = (sender.titleLabel?.text)!
        }
    }
    
    
    //    HBAlertPasswordViewDelegate 密码弹框代理
    func sureAction(with alertPasswordView: HBAlertPasswordView!, password: String!) {
        alertPasswordView.removeFromSuperview()
        setToast(str: "输入的密码为:"+password)
        titleArr3.remove(at: titleArr3.index(of: currentTitle2)!)
        footView(titles: titleArr3)
        mainTableView.reloadData()
    }

    
    //MARK:  ******代理 ：UITableViewDataSource,UITableViewDelegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if currentIndex == 4 {
            return 20
        }
        
        if currentIndex == 3 {
            return pointArr.count
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
                        print(json)
//
//                        if json["code"] == "1" {
                        
                            setToast(str: "上传成功")
                            let params =
                                [
                                    "userWorkBookId":self.model.userWorkBookId!,
                                    "SESSIONID":SESSIONID,
                                    "mobileCode":mobileCode
                                    ] as [String:Any]
                            self.view.beginLoading()
                            netWorkForGetWorkBookByTime(params: params) { (dataArr,flag) in
                                if flag {
                                    if datas.count > 0{
                                        self.theModel = dataArr[0] as! BookDetailModel
                                        self.workState = self.theModel.correcting_states
                                        if self.workState == "" {
                                            self.workState = "1"
                                        }
                                        self.mainTableView.reloadData()
                                    }
                                    print(dataArr)
                                }
                                self.view.endLoading()
                            }
//                        }
                        print(datas)
                    }, failture: { (error) in
                        print(error)
                    })
                    
                }else{
                    self.setupPhoto1(count: 2)
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
                    self.workState = "0"
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
                    let params =
                        [
                            "workBookId":self.model.work_book_Id,
                            "SESSIONID":SESSIONID,
                            "mobileCode":mobileCode
                    ]
                    var nameArr = [String]()
                    
                    for index in 0..<self.images.count {
                        nameArr.append("image\(index)")
                    }
                    netWorkForUploadWorkBookNext(params: params, data: self.images as! [UIImage], name: nameArr, success: { (datas) in
                        print(datas)
                        let json = JSON(datas)
                        print(json)
                        
                        if json["code"] == "1" {
                            
                            setToast(str: "上传成功")
                        }
                    }, failture: { (error) in
                        print(error)
                    })
                }else{
                    self.setupPhoto1(count: 2)
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
            
            let cell : AnserImageCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable, for: indexPath) as! AnserImageCell
            return cell
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
            
            let url = NSURL.init(string: "http://m.youku.com/video/id_XMzA4MDYxNzQ2OA==.html?spm=a2hww.20022069.m_215416.5~5%212~5~5%212~A&source=http%3A%2F%2Fyouku.com%2Fu%2F13656654646%3Fscreen%3Dphone")
            
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url! as URL, options: [:],
                                          completionHandler: {
                                            (success) in
                })
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 && currentIndex == 1 {
            dateBtn = UIButton.init(frame: CGRect(x: 0, y: 44 , width: kSCREEN_WIDTH, height: 40))
            dateBtn.backgroundColor = UIColor.white
            dateBtn.titleLabel?.font = kFont30
            dateBtn.setTitleColor(kGaryColor(num: 164), for: .normal)
            dateBtn.setImage(#imageLiteral(resourceName: "xiala_icon_default"), for: .normal)
            dateBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -35, 0, 0)
            dateBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 145, 0, 0)
            dateBtn.setTitle(selectDate, for: .normal)
            dateBtn.addTarget(self, action: #selector(chooseDateAction(sender:)), for: .touchUpInside)
            
            let line2 = UIView.init(frame: CGRect(x: 0, y: 43 , width: kSCREEN_WIDTH, height: 1))
            line2.backgroundColor = kGaryColor(num: 223)
            dateBtn.addSubview(line2)
            return dateBtn
        }
        return UIView()
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 && currentIndex == 1 {
            return 44
        }
        
        return 0
    }
    
    
    // 异步原图
    private func setupPhoto1(count:NSInteger) {
        let imagePickTool = CLImagePickersTool()
        
        imagePickTool.isHiddenVideo = true
        
        imagePickTool.setupImagePickerWith(MaxImagesCount: count, superVC: self) { (assetArr,cutImage) in
            print("返回的asset数组是\(assetArr)")
            
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
                
            }
        }
    }
    
    //MARK://日期选择器响应方法
    @objc func dateChanged(datePicker : UIDatePicker){
        //更新提醒时间文本框
        let formatter = DateFormatter()
        //日期样式
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        print(formatter.string(from: datePicker.date))
    }
    
    
    //MARK:      取消事件
    @objc func cancelAction(sender:UIButton) {
        UIView.animate(withDuration: 0.5) {
            self.datePickerView.transform = .identity
            self.BGView.alpha = 0
        }
    }
    
    @objc func containAction(sender:UIButton) {
        
        let formatter = DateFormatter()
        //日期样式
        formatter.dateFormat = "yyyy/MM/dd"
        print(formatter.string(from: self.datePicker.date))
        self.selectDate = formatter.string(from: self.datePicker.date)
        
        if !timeArr.contains(selectDate) {
            setToast(str: "你在"+selectDate+"没有相关作业！")
            return
        }
        
        self.dateBtn.setTitle(formatter.string(from: self.datePicker.date), for: .normal)
        
        UIView.animate(withDuration: 0.5) {
            self.datePickerView.transform = .identity
            self.BGView.alpha = 0
        }
        
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
                print(dataArr)
            }
            self.view.endLoading()
        }
    }
    
    
    //MARK:   弹出视图DatePicker的出现事件
    func showDatePickerView() -> Void {
        
        let y = DateHeight - 80 * kSCREEN_SCALE
        
        UIView.animate(withDuration: 0.5) {
            self.datePickerView.transform = .init(translationX: 0, y: -y)
            self.BGView.alpha = 1
        }
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        PopViewUtil.share.stopLoading()
    }
}
