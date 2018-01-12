//
//  TBookDetailViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/23.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyJSON

class TBookDetailViewController: BaseViewController,UITextFieldDelegate,UIAlertViewDelegate {
    
    var typeArr = ["学生作业","已批改","知识点讲解","参考答案","成绩"]
    var underLine = UIView()
    var headView = UIView()
    var infoView = TBookHeadView()

    var currentIndex = 1
//    作业
    var works = NSMutableArray()
//    已批改
    var doneWorks = NSMutableArray()
//    知识点
    var videoArr = [UrlModel]()
//    参考答案数据
    var answerArr = NSMutableArray()
//    成绩
    var grades = NSMutableArray()
    
    var searchArr = NSMutableArray()
    
    //    var bookState = 0
    
    var book_id = ""
    var userWorkBookId = ""

    let identyfierTable6 = "identyfierTable6"
    let identyfierTable7 = "identyfierTable7"
    let identyfierTable8 = "identyfierTable8"
    let identyfierTable9 = "identyfierTable9"
    let identyfierTable10 = "identyfierTable10"
    let identyfierTable11 = "identyfierTable11"

    var selectDate = ""
    
    
//    搜索框
    var isSearching = false
    var searchTextfield = UITextField()

    var footBtnView = UIView()

    var mainModel = TMyWorkDetailModel()
    
    
    var bookName = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rightBarButton()
        footView()
        addTimeSelector()
        
        NotificationCenter.default.addObserver(self, selector: #selector(receiveNitification(nitofication:)), name: NSNotification.Name(rawValue: SuccessCorrectWorkBookNoti), object: nil)
    }
    
    @objc func receiveNitification(nitofication:Notification) {
        self.mainTableView.mj_header.beginRefreshing()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    
    override func requestData() {
        
        let params =
            ["SESSIONID":SESSIONIDT,
             "mobileCode":mobileCodeT,
             "id":book_id,
             "date":selectDate
             ]

        self.view.beginLoading()
        NetWorkTeacherGetTWorkDetail(params: params) { (datas,flag) in
            
            if flag {
                if datas.count > 0 {
                    let model = datas[0] as! TMyWorkDetailModel
                    self.infoView.setValues(model: model)
                    self.navigationItem.title = model.work_book_name
                }
            }
            self.view.endLoading()
        }
        
        NetWorkTeacherGetTStudentWorkList(params: params) { (datas,flag) in
            if flag {
                self.works.removeAllObjects()
                self.works.addObjects(from: datas)
                self.mainTableView.reloadData()
            }
            self.mainTableView.mj_header.beginRefreshing()
            self.view.endLoading()
        }
        
    }
    
    
    override func configSubViews() {
        
        self.navigationItem.title = bookName
        
        headView = UIView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 23 + 80*kSCREEN_SCALE))
        headView.backgroundColor = UIColor.white
        infoView = UINib(nibName:"TBookHeadView",bundle:nil).instantiate(withOwner: self, options: nil).first as! TBookHeadView
        infoView.frame =  CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 23)
        headView.addSubview(infoView)
        
        
        let kHeight = CGFloat(80 * kSCREEN_SCALE)
        var contentWidth = CGFloat()
        var totalWidth = CGFloat()
        
        //MARK: 因为按钮字数不一样，长短有别，所以我先看看一共有多长再平分space
        for index in 0..<typeArr.count{
            
            let kWidth = getLabWidth(labelStr: typeArr[index], font: kFont32, height: kHeight) + 10
            totalWidth += kWidth
        }
        
        let kSpace = CGFloat(kSCREEN_WIDTH - totalWidth)/CGFloat(typeArr.count+1)
        
        for index in 0..<typeArr.count{
            
            let kWidth = getLabWidth(labelStr: typeArr[index], font: kFont32, height: kHeight) + 10
            let markBtn = UIButton.init(frame: CGRect(x: kSpace + (contentWidth + kSpace * CGFloat(index)) , y: 23, width: kWidth, height: kHeight))
            //            markBtn.center.y = headView.center.y
            markBtn.setTitle(typeArr[index], for: .normal)
            markBtn.setTitleColor(kGaryColor(num: 117), for: .normal)
            markBtn.titleLabel?.font = kFont28
            markBtn.addTarget(self, action: #selector(goodAtProject(sender:)), for: .touchUpInside)
            contentWidth += kWidth
            markBtn.tag = 131 + index
            headView.addSubview(markBtn)
        }
        
        let view = headView.viewWithTag(131) as! UIButton
        view.setTitleColor(kMainColor(), for: .normal)
        underLine = UIView.init(frame: CGRect(x: 0, y: 23+80 * kSCREEN_SCALE - 3, width: getLabWidth(labelStr: typeArr[0], font: kFont32, height: 1) - 5, height: 2))
        underLine.backgroundColor = kMainColor()
        underLine.layer.cornerRadius = 1
        underLine.clipsToBounds = true
        underLine.center.x = view.center.x
        headView.addSubview(underLine)
        
        mainTableView = UITableView.init(frame: CGRect(x: 0,
                                                       y: 0,
                                                       width: kSCREEN_WIDTH,
                                                       height: kSCREEN_HEIGHT - 64),
                                         style: .plain)
        mainTableView.dataSource = self
        mainTableView.delegate = self
        mainTableView.estimatedRowHeight = 100
        mainTableView.register(UINib(nibName: "AnserImageCell",    bundle: nil), forCellReuseIdentifier: identyfierTable2)
        mainTableView.register(UINib(nibName: "AnserVideoCell",    bundle: nil), forCellReuseIdentifier: identyfierTable3)
        mainTableView.register(UINib(nibName: "ClassGradeCell",    bundle: nil), forCellReuseIdentifier: identyfierTable4)
        mainTableView.register(UINib(nibName: "TUpLoadVideoCell",  bundle: nil), forCellReuseIdentifier: identyfierTable5)
        mainTableView.register(UINib(nibName: "TShowDoneWorkCell", bundle: nil), forCellReuseIdentifier: identyfierTable7)
        mainTableView.register(UINib(nibName: "TViewBookCell0",    bundle: nil), forCellReuseIdentifier: identyfierTable10)
        mainTableView.register(UINib(nibName: "ShowWriteAnswerCell",    bundle: nil), forCellReuseIdentifier: identyfierTable11)
        mainTableView.register(UINib(nibName: "AnswerImageCell",    bundle: nil), forCellReuseIdentifier: identyfierTable8)
        mainTableView.register(UINib(nibName: "ShowFileCell",    bundle: nil), forCellReuseIdentifier: identyfierTable9)
//        mainTableView.register(UITableViewCell.self, forCellReuseIdentifier: identyfierTable12)
        
        mainTableView.tableHeaderView = headView
        self.view.addSubview(mainTableView)
        mainTableView.backgroundColor = kSetRGBColor(r: 239, g: 239, b: 244)
        mainTableArr = ["关于我们","清除缓存","检查更新"]
    }
    
    
//    刷新数据
    override func refreshHeaderAction() {
        isSearching = false

        let params =
            ["SESSIONID":SESSIONIDT,
             "mobileCode":mobileCodeT,
             "id":book_id,
             "date":selectDate,
             ]

        if currentIndex == 4 {
            self.view.addSubview(footBtnView)
        }else{
            footBtnView.removeFromSuperview()
        }
//        self.view.beginLoading()
        if currentIndex == 1 {
            
            NetWorkTeacherGetTStudentWorkList(params: params) { (datas,flag) in

                if flag {
                    self.works.removeAllObjects()
                    self.works.addObjects(from: datas)
                    self.mainTableView.reloadData()
                    self.mainTableView.mj_header.endRefreshing()
                }
                self.view.endLoading()
            }
        }else if currentIndex == 2 {
            
            NetWorkTeacherGetTStudentCorrected(params: params) { (datas,flag) in
                if flag {
                    self.doneWorks.removeAllObjects()
                    self.doneWorks.addObjects(from: datas)
                    self.mainTableView.reloadData()
                }
                self.view.endLoading()
                self.mainTableView.mj_header.endRefreshing()
            }
        }else if currentIndex == 3 {
            
            let params11 =
                ["SESSIONID":SESSIONIDT,
                 "mobileCode":mobileCodeT,
                 "date":selectDate,
                 "workBookId":book_id
            ]
            NetWorkTeacherGetTPeriodPoint(params: params11) { (datas,flag) in
                if flag {
                    self.videoArr.removeAll()
                    
                    for index in 0..<datas.count {
                        let model = datas[index] as! UrlModel
                        self.videoArr.append(model)
                    }
                    self.mainTableView.reloadData()
                }
                self.mainTableView.mj_header.endRefreshing()
                self.view.endLoading()
            }
        }else if currentIndex == 4{
            let params1 =
                ["SESSIONID":SESSIONIDT,
                 "mobileCode":mobileCodeT,
                 "date":selectDate,
                 "bookId":book_id
                    ] as [String:Any]
            NetWorkTeacherGetTMyNotWorkDatailAnswers(params: params1) { (datas,flag) in
                
                if flag {
                    self.answerArr.removeAllObjects()
                    self.answerArr.addObjects(from: datas)
                    
                    for btn in self.footBtnView.subviews {
                        let theBtn = btn as! UIButton
                        theBtn.setBackgroundImage(getNavigationIMG(27, fromColor: kSetRGBColor(r: 0, g: 200, b: 255), toColor: kSetRGBColor(r: 0, g: 162, b: 255)), for: .normal)
                        theBtn.isEnabled = true
                    }

                    for model in self.answerArr {
                        let m = model as! UrlModel
                        let markBtn = self.footBtnView.viewWithTag(180+Int(m.type!)!) as! UIButton
                        markBtn.setBackgroundImage(getNavigationIMG(27, fromColor: kGaryColor(num: 220), toColor: kGaryColor(num: 220)), for: .normal)
                        markBtn.isEnabled = false
                    }
                    //self.footView()
                    self.mainTableView.reloadData()
                }
                self.mainTableView.mj_header.endRefreshing()
                self.view.endLoading()
            }
        }else{
            
            let params111 =
                ["SESSIONID":SESSIONIDT,
                 "mobileCode":mobileCodeT,
                 "id":book_id,
                 "date":selectDate,
                 "type":"1"
                 ]

            NetWorkTeacherGetStudentScroes(params: params111) { (datas,flag) in
                if flag {
                    self.grades.removeAllObjects()
                    self.grades.addObjects(from: datas)
                    self.mainTableView.reloadData()
                }
                self.mainTableView.mj_header.endRefreshing()
                self.view.endLoading()
            }
        }
    }
    
    
    //    右键
    var dateBtn = UIButton()
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
    @objc func chooseDateAction(sender:UIButton) {
        //        print(NSDate())
//        if currentIndex == 5 {
//            return
//        }
        showDatePickerView()
    }

    
//    @objc func correctPapers(sender:UIBarButtonItem) {
//        setToast(str: "编辑作业")
//    }
//
    
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
        let params =
            ["SESSIONID":SESSIONIDT,
             "mobileCode":mobileCodeT,
             "id":book_id,
             "date":selectDate,
             ]

        if currentIndex == 4 {
            mainTableView.height = kSCREEN_HEIGHT - 64 - 96*kSCREEN_SCALE-10
            self.view.addSubview(footBtnView)
        }else{
            footBtnView.removeFromSuperview()
            mainTableView.height = kSCREEN_HEIGHT - 64
        }

        self.view.beginLoading()
        if currentIndex == 1 {
            
            NetWorkTeacherGetTStudentWorkList(params: params) { (datas,flag) in
                if flag {
                    self.works.removeAllObjects()
                    self.works.addObjects(from: datas)
                    self.mainTableView.reloadData()
                }
                self.view.endLoading()
            }
        }else if currentIndex == 2 {

            NetWorkTeacherGetTStudentCorrected(params: params) { (datas,flag) in
                if flag {
                    self.doneWorks.removeAllObjects()
                    self.doneWorks.addObjects(from: datas)
                    self.mainTableView.reloadData()
                }
                self.view.endLoading()
            }
        }else if currentIndex == 3 {
            
            let params1 =
                ["SESSIONID":SESSIONIDT,
                 "mobileCode":mobileCodeT,
                 "date":selectDate,
                 "workBookId":book_id
            ]
            NetWorkTeacherGetTPeriodPoint(params: params1) { (datas,flag) in
                if flag {
                    self.videoArr.removeAll()
                    
                    for index in 0..<datas.count {
                        let model = datas[index] as! UrlModel
                        self.videoArr.append(model)
                    }
                    self.mainTableView.reloadData()
                }
                self.view.endLoading()
            }
        }else if currentIndex == 4{
            let params1 =
                ["SESSIONID":SESSIONIDT,
                 "mobileCode":mobileCodeT,
                 "bookId":book_id,
                 "date":selectDate
                    ] as [String:Any]
            NetWorkTeacherGetTMyNotWorkDatailAnswers(params: params1) { (datas,flag) in
                
                if flag {
//                    self.footView()
                    self.answerArr.removeAllObjects()
                    self.answerArr.addObjects(from: datas)
                    
                    for btn in self.footBtnView.subviews {
                        let theBtn = btn as! UIButton
                        theBtn.setBackgroundImage(getNavigationIMG(27, fromColor: kSetRGBColor(r: 0, g: 200, b: 255), toColor: kSetRGBColor(r: 0, g: 162, b: 255)), for: .normal)
                        theBtn.isEnabled = true
                    }
                    
                    for model in self.answerArr {
                        let m = model as! UrlModel
                        let markBtn = self.footBtnView.viewWithTag(180+Int(m.type!)!) as! UIButton
                        markBtn.setBackgroundImage(getNavigationIMG(27, fromColor: kGaryColor(num: 220), toColor: kGaryColor(num: 220)), for: .normal)
                        markBtn.isEnabled = false
                    }
                    //                    self.footView()
                    self.mainTableView.reloadData()
                }
//                self.mainTableView.mj_header.endRefreshing()
                self.view.endLoading()
            }
        }else{

            let params1 =
                ["SESSIONID":SESSIONIDT,
                 "mobileCode":mobileCodeT,
                 "type":"1",
                 "date":selectDate,
                 "id":book_id,
            ]
            
            NetWorkTeacherGetStudentScroes(params: params1) { (datas,flag) in
                if flag {
                    self.grades.removeAllObjects()
                    self.grades.addObjects(from: datas)
                    self.mainTableView.reloadData()
                }
                self.view.endLoading()
            }
        }
        isSearching = false
        mainTableView.reloadData()
    }
    
    
    //    ******************代理 ： UITableViewDataSource,UITableViewDelegate  ************
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if currentIndex == 1 {
            if isSearching {
                if searchArr.count == 0 {
                    return 1
                }
                return searchArr.count
            }else{
                return works.count
            }
        }
        
        if currentIndex == 2  {
            return 1
        }
        
        if currentIndex == 3 {
            if section == 1 {
                return videoArr.count
            }else{
                return 1
            }
        }
        
        if currentIndex == 4 {
            
            return answerArr.count
        }
        
        return  grades.count+1
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        if currentIndex == 3 {
            return 2
        }
        
        if currentIndex == 2 {
            return doneWorks.count
        }
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if currentIndex == 1 {
            
            var model = TShowStuWorksModel()
            if isSearching {
                
                if searchArr.count == 0 {
                    let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable11, for: indexPath)
                    cell.textLabel?.text = "未找到关于“"+searchTextfield.text!+"”的作业"
                    cell.detailTextLabel?.text = ""
                    cell.selectionStyle = .none
                    return cell
                }else{
                    model = searchArr[indexPath.row] as! TShowStuWorksModel
                }
            }else{
                model = works[indexPath.row] as! TShowStuWorksModel
            }
            deBugPrint(item: model.correcting_states)
            
            let cell : TViewBookCell0 = tableView.dequeueReusableCell(withIdentifier: identyfierTable10, for: indexPath) as! TViewBookCell0
            
            cell.TViewBookCell0SetValuesForShowWork(model: model)
            return cell
            
        }else if currentIndex == 2 {
            
            let model = doneWorks[indexPath.row] as! TShowGradeModel
            
            let cell : TShowDoneWorkCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable7, for: indexPath) as! TShowDoneWorkCell
            cell.TShowDoneWorkCellWithData(model: model)
            return cell
        }else if currentIndex == 3 {
            
            if indexPath.section == 0 {
                
                let cell : TUpLoadVideoCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable5, for: indexPath) as! TUpLoadVideoCell
                cell.selectionStyle = .none
                return cell
            }else{
                let model = videoArr[indexPath.row]
                
                let cell : AnserVideoCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable3, for: indexPath) as! AnserVideoCell
                cell.AnserVideoCellSetValues(model: model)
                return cell
            }
            
        }else if currentIndex == 4 {

            let model = answerArr[indexPath.row] as! UrlModel
            deBugPrint(item: model.type!)
            deBugPrint(item: model.format!)
            if model.type == "1" {
                
                let cell : AnserVideoCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable3, for: indexPath) as! AnserVideoCell
                cell.AnserVideoCellSetValuesForAnswer(title: model.title)
                return cell
            }else  if model.type == "2" {
                
                if model.format == "doc" || model.format == "xls"{
                    let cell : ShowFileCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable9, for: indexPath) as! ShowFileCell
                    cell.setValues(model: model)
                    return cell
                }else{
                    
                    let cell : AnswerImageCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable8, for: indexPath) as! AnswerImageCell
                    cell.showWithImage(image: model.answard_res)
                    cell.selectionStyle = .none
                    return cell
                }
                
            }else  if model.type == "3" {
                let cell : ShowWriteAnswerCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable11, for: indexPath) as! ShowWriteAnswerCell
                cell.showAnswer(text: model.answard_res)
                cell.selectionStyle = .none
                return cell
            }else{
                return UITableViewCell()
            }

            
//            let model = answerArr[indexPath.row] as! UrlModel
//            if model.type == "1" {
//                let cell : AnserVideoCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable3, for: indexPath) as! AnserVideoCell
//                cell.AnserVideoCellSetValues(model: model)
//                return cell
//
//            }else if model.type == "2" {
//
//                let cell : ShowFileCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable9, for: indexPath) as! ShowFileCell
//                return cell
//
//            }else if model.type == "3" {
//
//                let cell : ShowWriteAnswerCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable11, for: indexPath) as! ShowWriteAnswerCell
////                cell.showAnswer(text: model.title)
//                return cell
//            }else{
//
//                let cell : AnswerImageCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable8, for: indexPath) as! AnswerImageCell
//                cell.showWithImage(image: model.address!)
//                return cell
//            }
            
        }else{
            
            let cell : ClassGradeCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable4, for: indexPath) as! ClassGradeCell
            
            if grades.count == 0{
                cell.noDatas()
            }else{
                if indexPath.row == 0 {
                    cell.is1thCellForWorkBook()
                }else{
                    let model = grades[indexPath.row-1] as! TShowGradeModel
                    cell.setValueForBookGrade(model:model)
                }
            }
            return cell
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if currentIndex == 1 {
            
            if !isSearching {
                let viewC = TShowBookViewController()
                let model = works[indexPath.row] as! TShowStuWorksModel
                viewC.model = model
                viewC.correct_date = selectDate
                viewC.book_details_id = model.book_details_id
                if model.correcting_states == "2" || model.correcting_states == "5" {
                    
                    let date = NSDate.init()
                    let formatter = DateFormatter()
                    //日期样式
                    formatter.dateFormat = "yyyy/MM/dd"
                   let createDate = formatter.date(from: model.correcting_time)

                    let dateStr = model.correcting_time.substring(to: String.Index.init(encodedOffset: 10))
                    
                    if formatter.string(from: date as Date) == dateStr {
                        self.navigationController?.pushViewController(viewC, animated: true)
                    }else{
                        setToast(str: "只能批改当天的作业")
                    }
                }
            }
        }
        
        
        
        if currentIndex == 3 {
            
            if indexPath.section == 0 {
                
                let nextVC = UploadVideoViewController()
                nextVC.isAnswer = false
                nextVC.bookId = book_id
                nextVC.currentType = 1
                nextVC.addUrlBlock = {
                    self.mainTableView.mj_header.beginRefreshing()
                    self.mainTableView.reloadData()
                }
                self.navigationController?.pushViewController(nextVC, animated: true)
            }else{
               
                let model = videoArr[indexPath.row]
                
                let webVc = WebViewController()
                webVc.webUrl = model.point_address
                webVc.theTitle = model.point_title
                self.navigationController?.pushViewController(webVc, animated: true)
            }
        }
        
        if currentIndex == 4 {
            let model = answerArr[indexPath.row] as! UrlModel
            if model.type == "1" {
                
                let webVc = WebViewController()
                webVc.webUrl = model.answard_res
                webVc.theTitle = model.title
                self.navigationController?.pushViewController(webVc, animated: true)
            }else if model.type == "2" && model.format == "img" {
                
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
            }
        }
        
        if currentIndex == 5 {
            if indexPath.row != 0 {
                let showVC = TShowOneGradeVCViewController()
                let model = grades[indexPath.row-1] as! TShowGradeModel
                showVC.user_num = model.studentId
                showVC.type = 1
                self.navigationController?.pushViewController(showVC, animated: true)
            }
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
        
        if currentIndex == 1 {
            
            if section == 0 {

                let BGiew = UIView.init(frame:CGRect(x: 0, y: 0, width: kSCREEN_WIDTH , height: 43) )
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
                return BGiew
            }
        }
        
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 19 * kSCREEN_SCALE))
        view.backgroundColor = kSetRGBColor(r: 239, g: 239, b: 244)
        return view
    }
    
    
    @objc func textFieldDidChange(textfield:UITextField) {
        
        if textfield.text?.count == 0 {
            setToast(str: "取消搜索")
            isSearching = false
             mainTableView.reloadData()
            textfield.resignFirstResponder()
        }
    }
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if  currentIndex == 1 {
            if section == 0 {
                return 43
            }
        }else{
            if section == 0 {
                return 0
            }
        }
        
        return 19 * kSCREEN_SCALE
    }
    
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01 * kSCREEN_SCALE
    }
    
    
    func footView() {
        
        let titles = ["上传视频","上传图片","书写答案"]
        
        footBtnView.removeFromSuperview()
        _ = footBtnView.subviews.map {
            $0.removeFromSuperview()
        }
        
        let kHeight = CGFloat(72 * kSCREEN_SCALE)
        let kSpace = 20*kSCREEN_SCALE
        let kWidth = (kSCREEN_WIDTH-20*kSCREEN_SCALE*4)/3
        
        footBtnView = UIView.init(frame: CGRect(x: 0, y: kSCREEN_HEIGHT-74-96*kSCREEN_SCALE, width: KScreenWidth, height: 96*kSCREEN_SCALE+10))
        
        for index in 0..<titles.count {
            
            let markBtn = UIButton.init(frame: CGRect(x: kSpace+(kSpace+kWidth)*CGFloat(index), y: 10, width: kWidth, height: kHeight))
            markBtn.setTitle(titles[index], for: .normal)
            markBtn.setTitleColor(kGaryColor(num: 117), for: .normal)
            markBtn.titleLabel?.font = kFont28
            markBtn.setBackgroundImage(getNavigationIMG(27, fromColor: kSetRGBColor(r: 0, g: 200, b: 255), toColor: kSetRGBColor(r: 0, g: 162, b: 255)), for: .normal)
            markBtn.addTarget(self, action: #selector(showUploadBtn(sender:)), for: .touchUpInside)
            markBtn.layer.cornerRadius = 10*kSCREEN_SCALE
            markBtn.clipsToBounds = true
            markBtn.setTitleColor(UIColor.white, for: .normal)
            markBtn.tag = 181 + index
            footBtnView.addSubview(markBtn)
        }
    }
    
    //MARK:上传答案点击事件
    @objc func showUploadBtn(sender:UIButton) {
        
        deBugPrint(item: sender.tag)
        
        if sender.tag == 181 {

            let nextVC = UploadVideoViewController()
            nextVC.isAnswer = true
            nextVC.bookId = book_id
            nextVC.currentType = 1
            nextVC.bookDate = selectDate
            nextVC.addUrlBlock = {
                self.mainTableView.mj_header.beginRefreshing()
            }
            self.navigationController?.pushViewController(nextVC, animated: true)
        }else  if sender.tag == 182{
            
            setupPhoto1(count: 100)
        }else  if sender.tag == 183{
            
            let nextVC = WriteAnswerViewController()
            nextVC.currentType = 1
            nextVC.bookId = book_id
            nextVC.bookDate = selectDate
            nextVC.addTextBlock = {
                deBugPrint(item: $0)
                self.mainTableView.mj_header.beginRefreshing()
            }
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        textField.resignFirstResponder()

        let params1 =
            ["SESSIONID":SESSIONIDT,
             "mobileCode":mobileCodeT,
             "date":selectDate,
             "studentId":textField.text!,
             "id":book_id
        ]
        self.view.beginLoading()
        NetWorkTeacherGetTStudentWorkList(params: params1) { (datas,flag) in
            
            if flag {
                self.works.removeAllObjects()
                self.works.addObjects(from: datas)
                self.isSearching = true
                self.mainTableView.reloadData()
            }
            self.view.endLoading()
        }
        return true
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
                self?.imageArr.append(image)

//                let params1 =
//                    [
//                        "SESSIONID":SESSIONIDT,
//                        "mobileCode":mobileCodeT,
//                        "date":self?.selectDate,
//                        "workId":self?.book_id
//                        ] as! [String:String]
//
//                NetWorkTeacherUploadAnswerImages(params: params1, data: imageArr, success: { (success) in
//                    let json = JSON(success)
//                    deBugPrint(item: json)
//                    if json["code"] == "1" {
//                        setToast(str: "上传成功")
//                    }
//                }, failture: { (error) in
//
//                })
                
//                self?.answerArr.append(image)
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
            self.addAlertTip()
        }
        // 图片显示出来以后可能还要上传到云端的服务器获取图片的url，这里不再细说了。
    }
    
    
    var imageArr = [UIImage]()
    var priceTextfield = UITextField()
    
    func addAlertTip() {
        
        let alert = UIAlertView.init(title: "设置支付学币", message: "单位：（学币）", delegate: self, cancelButtonTitle: "确定", otherButtonTitles: "取消")
        alert.alertViewStyle = .plainTextInput
        
        priceTextfield = alert.textField(at: 0)!
        priceTextfield.keyboardType = .numberPad
        
        let text = priceTextfield.text
        deBugPrint(item: text!)
        alert.show()
    }
    
    
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        let buttonTitle = alertView.buttonTitle(at: buttonIndex)
        if buttonTitle == "确定" {
            
            if (priceTextfield.text?.count)! < 1 {
                setToast(str: "请设置答案价格")
                return
            }
            
            if Int(priceTextfield.text!) == nil {
                setToast(str: "请设置有效数字")
                return
            }

            self.view.beginLoading()
            let params1 =
                ["SESSIONID":SESSIONIDT,
                 "mobileCode":mobileCodeT,
                 "workId":self.book_id,
                 "money":priceTextfield.text!,
                 ] as [String : String]
            
            NetWorkTeacherAddTNotWorkUploadFile(params: params1, data: imageArr, vc: self, success: { (data) in
                self.mainTableView.mj_header.beginRefreshing()
            }, failture: { (error) in
                
            })
            
            self.mainTableView.reloadData()
        }
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

        self.mainTableView.mj_header.beginRefreshing()
        
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
    
}
