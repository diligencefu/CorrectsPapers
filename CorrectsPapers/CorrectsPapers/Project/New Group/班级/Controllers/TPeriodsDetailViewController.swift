//
//  TPeriodsDetailViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/15.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class TPeriodsDetailViewController: BaseViewController,UITextFieldDelegate ,UIAlertViewDelegate{
    
    var typeArr = ["学生作业","已批改","课程视频","作业答案"]
    var underLine = UIView()
    var headView = UIView()
    var NofitICLabel = AutoScrollLabel()
    var buttonView = UIView()

    var currentIndex = 1
    //    作业
    var works = NSMutableArray()
    //    已批改
    var doneWorks = NSMutableArray()
    //    知识点
    var videoArr = NSMutableArray()
    //    参考答案数据
    var answerArr = NSMutableArray()
    //    成绩
    var grades = NSMutableArray()
    
    var searchArr = NSMutableArray()
    
    //    var bookState = 0
    
    var periods_id = ""
    
    var periodsName = ""

    var class_id = ""

    var loadImages = [UIImage]()
    
    
    let titles4 = ["上传视频版","上传图片版","书写答案版"]
    let titles3 = ["上传课程视频","上传图片","上传作业"]

    
    let identyfierTable6 = "identyfierTable6"
    let identyfierTable7 = "identyfierTable7"
    let identyfierTable8 = "identyfierTable8"
    let identyfierTable9 = "identyfierTable9"
    let identyfierTable10 = "identyfierTable10"
    let identyfierTable11 = "identyfierTable11"
    
    //    搜索框
    var isSearching = false
    var searchTextfield = UITextField()
    
    var footBtnView = UIView()
    
    
//    上传图片的类型：；1课程视频图片；2.课程视频作业；3.参考答案图片
    var uploadType = 3
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        接收批改班级作业成功的通知
        NotificationCenter.default.addObserver(self, selector: #selector(receiveNitification(nitofication:)), name: NSNotification.Name(rawValue: SuccessCorrectClassWorkBookNoti), object: nil)
    }
    
    @objc func receiveNitification(nitofication:Notification) {
        self.mainTableView.mj_header.beginRefreshing()
    }

    override func requestData() {
        
        let params =
            ["SESSIONID":Defaults[userToken]!,
             "mobileCode":mobileCode,
             "periods_id":periods_id
        ] as [String:Any]
        self.view.beginLoading()
        NetWorkTeacherSelectClassBook(params: params, callBack: { (datas,flag) in
            if flag {
                self.works.removeAllObjects()
                self.works.addObjects(from: datas)
                self.mainTableView.reloadData()
            }
            self.view.endLoading()
        })
        
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

    
    override func configSubViews() {
        
        
        self.navigationItem.title = periodsName

        
        headView = UIView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 165*kSCREEN_SCALE))
        headView.backgroundColor = UIColor.white
        
        NofitICLabel = AutoScrollLabel.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 64 * kSCREEN_SCALE))
        NofitICLabel.textColor = kSetRGBColor(r: 255, g: 153, b: 0)
        NofitICLabel.setText("通知消息")
        NofitICLabel.backgroundColor = UIColor.white
        headView.addSubview(NofitICLabel)

        
        updateButtons(titleArr: typeArr)
        self.view.addSubview(headView)
        
        mainTableView = UITableView.init(frame: CGRect(x: 0,
                                                       y: 0,
                                                       width: kSCREEN_WIDTH,
                                                       height: kSCREEN_HEIGHT - 64),
                                         style: .plain)
        mainTableView.dataSource = self
        mainTableView.delegate = self
        mainTableView.estimatedRowHeight = 100
        mainTableView.register(UINib(nibName: "AnswerImageCell",    bundle: nil), forCellReuseIdentifier: identyfierTable2)
        mainTableView.register(UINib(nibName: "AnserVideoCell",    bundle: nil), forCellReuseIdentifier: identyfierTable3)
        mainTableView.register(UINib(nibName: "ClassGradeCell",    bundle: nil), forCellReuseIdentifier: identyfierTable4)
        mainTableView.register(UINib(nibName: "TUpLoadVideoCell",  bundle: nil), forCellReuseIdentifier: identyfierTable5)
        mainTableView.register(UINib(nibName: "TShowDoneWorkCell", bundle: nil), forCellReuseIdentifier: identyfierTable7)
        mainTableView.register(UINib(nibName: "TViewBookCell0",    bundle: nil), forCellReuseIdentifier: identyfierTable10)
        mainTableView.register(UITableViewCell.self, forCellReuseIdentifier: identyfierTable11)
        
        
        mainTableView.register(UINib(nibName: "ShowFileCell", bundle: nil), forCellReuseIdentifier: identyfierTable9)
        mainTableView.register(UINib(nibName: "ShowWriteAnswerCell", bundle: nil), forCellReuseIdentifier: identyfierTable8)
        
        mainTableView.tableHeaderView = headView
        self.view.addSubview(mainTableView)
        mainTableView.backgroundColor = kSetRGBColor(r: 239, g: 239, b: 244)
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

    //    刷新数据
    override func refreshHeaderAction() {
        isSearching = false
        
        let params =
            ["SESSIONID":Defaults[userToken]!,
             "mobileCode":mobileCode,
             "periods_id":periods_id
        ]
        if currentIndex == 1 {
            NetWorkTeacherSelectClassBook(params: params, callBack: { (datas,flag) in
                if flag {
                    self.works.removeAllObjects()
                    self.works.addObjects(from: datas)
                    self.mainTableView.reloadData()
                }
                self.mainTableView.mj_header.endRefreshing()
                self.view.endLoading()
            })
            
        }else if currentIndex == 2 {
            
            let params =
                ["SESSIONID":Defaults[userToken]!,
                 "mobileCode":mobileCode,
                 "periods_id":periods_id
            ]

            NetWorkTeacherGetCheckAgoCorrected(params: params, callBack: { (datas, flag) in
                if flag {
                    self.doneWorks.removeAllObjects()
                    self.doneWorks.addObjects(from: datas)
                    self.mainTableView.reloadData()
                }
                self.mainTableView.mj_header.endRefreshing()
                self.view.endLoading()
            })
        }else if currentIndex == 3 {
            let params =
                ["SESSIONID":Defaults[userToken]!,
                 "mobileCode":mobileCode,
                 "bookId":periods_id
            ]

//            40、41号接口
            NetWorkTeacherGetPreiodsByteacher(params: params, callBack: { (datas, flag) in
                if flag {
                    self.videoArr.removeAllObjects()
                    self.videoArr.addObjects(from: datas)
                    for model in self.videoArr {
                        let m = model as! UrlModel
                        let markBtn = self.footBtnView.viewWithTag(180+Int(m.type!)!) as! UIButton
                        markBtn.setBackgroundImage(getNavigationIMG(27, fromColor: kGaryColor(num: 220), toColor: kGaryColor(num: 220)), for: .normal)
                        markBtn.isEnabled = false
                    }

                    self.mainTableView.reloadData()
                }
            })
            
            self.mainTableView.mj_header.endRefreshing()
            self.view.endLoading()
        }else if currentIndex == 4{
            
            let params1 =
                ["SESSIONID":Defaults[userToken]!,
                 "mobileCode":mobileCode,
                 "bookId":periods_id
                    ] as [String:Any]
            NetWorkTeacherGetTMyNotWorkDatailAnswers(params: params1) { (datas,flag) in
                
                if flag {
                    self.answerArr.removeAllObjects()
                    self.answerArr.addObjects(from: datas)
                    
                    for model in self.answerArr {
                        let m = model as! UrlModel
                        let markBtn = self.footBtnView.viewWithTag(180+Int(m.type!)!) as! UIButton
                        markBtn.setBackgroundImage(getNavigationIMG(27, fromColor: kGaryColor(num: 220), toColor: kGaryColor(num: 220)), for: .normal)
                        markBtn.isEnabled = false
                    }
                    self.mainTableView.reloadData()
                }
                self.mainTableView.mj_header.endRefreshing()
                self.view.endLoading()
            }
        }
    }
    
    //    右键
    func rightBarButton() {
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: #imageLiteral(resourceName: "edit_icon"), style: .plain, target: self, action: #selector(correctPapers(sender:)))
    }
    
    
    @objc func correctPapers(sender:UIBarButtonItem) {
        setToast(str: "编辑作业")
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

        if currentIndex == 4 {
            footView(titles: titles4)
            mainTableView.height = kSCREEN_HEIGHT - 64 - 96*kSCREEN_SCALE-10
            self.view.addSubview(footBtnView)
        }else if currentIndex == 3{
            footView(titles: titles3)
            mainTableView.height = kSCREEN_HEIGHT - 64 - 96*kSCREEN_SCALE-10
            self.view.addSubview(footBtnView)
        }else{
            footBtnView.removeFromSuperview()
            mainTableView.height = kSCREEN_HEIGHT - 64
        }
        
        self.view.beginLoading()
        refreshHeaderAction()
        
//        isSearching = false
//        mainTableView.reloadData()
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
            
            return videoArr.count
        }
        return answerArr.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        if currentIndex == 2 {
            return doneWorks.count
        }
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if currentIndex == 1 {
            
            var model = TShowClassWorksModel()
            if isSearching {
                
                if searchArr.count == 0 {
                    let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable11, for: indexPath)
                    cell.textLabel?.text = "未找到关于“"+searchTextfield.text!+"”的作业"
                    cell.selectionStyle = .none
                    return cell
                }else{
                    model = searchArr[indexPath.row] as! TShowClassWorksModel
                }
            }else{
                model = works[indexPath.row] as! TShowClassWorksModel
            }
            deBugPrint(item: model.type)
            
            let cell : TViewBookCell0 = tableView.dequeueReusableCell(withIdentifier: identyfierTable10, for: indexPath) as! TViewBookCell0
            cell.TViewBookCell0SetValuesForShowClassWork(model: model)
            return cell
        }else if currentIndex == 2 {
            
            let model = doneWorks[indexPath.section] as! TShowGradeModel
            
            let cell : TShowDoneWorkCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable7, for: indexPath) as! TShowDoneWorkCell
            cell.TShowDoneWorkCellWithData(model: model)
            return cell
            
        }else{
//        }else if currentIndex == 3 {
            
//            if indexPath.section == 0 {
//
//                let model = videoArr[indexPath.row] as! UrlModel
//                let cell : AnserVideoCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable3, for: indexPath) as! AnserVideoCell
//                cell.AnserVideoCellSetValues(model: model)
//                return cell
//            }
            
//        }else{
            var model = UrlModel()
            if currentIndex == 3 {
                model = videoArr[indexPath.row] as! UrlModel
            }else{
                model = answerArr[indexPath.row] as! UrlModel
            }
            
            deBugPrint(item: model.type!)
            deBugPrint(item: model.format!)
            if model.type == "1" || model.type == "4"{
                
                let cell : AnserVideoCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable3, for: indexPath) as! AnserVideoCell
                cell.AnserVideoCellSetValuesForAnswer(title: model.title)
                return cell
            }else  if model.type == "2" || model.type == "5" || model.type == "6"{
                
                if model.format == "doc" || model.format == "xls"{
                    let cell : ShowFileCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable9, for: indexPath) as! ShowFileCell
                    cell.setValues(model: model)
                    return cell
                }else{
                    
                    let cell : AnswerImageCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable2, for: indexPath) as! AnswerImageCell
                    cell.showWithImage(image: model.answard_res)
                    cell.selectionStyle = .none
                    return cell
                }
                
            }else  if model.type == "3" {
                let cell : ShowWriteAnswerCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable8, for: indexPath) as! ShowWriteAnswerCell
                cell.showAnswer(text: model.answard_res)
                cell.selectionStyle = .none
                return cell
            }else{
                return UITableViewCell()
            }

//            let cell : AnserImageCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable2, for: indexPath) as! AnserImageCell
//            return cell
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if currentIndex == 1 {
            
            if !isSearching {
                let viewC = TShowClassWorkViewController()
                let model = works[indexPath.row] as! TShowClassWorksModel
                viewC.model = model
                viewC.class_book_id = model.class_book_id
                self.navigationController?.pushViewController(viewC, animated: true)
            }
        }
        
        if currentIndex == 3 {
            
            if indexPath.section == 0 {
                
                let nextVC = UploadVideoViewController()
                nextVC.isAnswer = false
                nextVC.addUrlBlock = {

                    self.mainTableView.mj_header.beginRefreshing()
                }
                self.navigationController?.pushViewController(nextVC, animated: true)
            }else{
                
                let model = videoArr[indexPath.row] as! UrlModel
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
    
    
    func footView(titles:[String]) {
        
        
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
            
            if currentIndex == 4 {
                markBtn.tag = 181 + index
            }else{
                markBtn.tag = 181 + index + 3
            }
            
            footBtnView.addSubview(markBtn)
        }
    }
    
    //MARK:上传答案点击事件
    @objc func showUploadBtn(sender:UIButton) {
        
        deBugPrint(item: sender.tag)
        
        if sender.tag == 181 {
            
            let nextVC = UploadVideoViewController()
            nextVC.isAnswer = true
            nextVC.bookId = periods_id
            nextVC.currentType = 3
            nextVC.addUrlBlock = {
                self.mainTableView.mj_header.beginRefreshing()
            }
            self.navigationController?.pushViewController(nextVC, animated: true)
        }else  if sender.tag == 182{
            
            uploadType = 3
            setupPhoto1(count: 100)
        }else  if sender.tag == 183{
            
            let nextVC = WriteAnswerViewController()
            nextVC.currentType = 3
            nextVC.bookId = periods_id
            nextVC.addTextBlock = {
                deBugPrint(item: $0)
                self.mainTableView.mj_header.beginRefreshing()
            }
            self.navigationController?.pushViewController(nextVC, animated: true)
        }else  if sender.tag == 184{

            let nextVC = UploadVideoViewController()
            nextVC.isAnswer = true
            nextVC.bookId = periods_id
            nextVC.currentType = 4
            nextVC.addUrlBlock = {
                self.mainTableView.mj_header.beginRefreshing()
            }
            self.navigationController?.pushViewController(nextVC, animated: true)

        }else  if sender.tag == 185{
            uploadType = 1
            setupPhoto1(count: 100)
        }else  if sender.tag == 186{
            uploadType = 2
            setupPhoto1(count: 100)
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        setToast(str: "开始请求")
        isSearching = true
        mainTableView.reloadData()
        textField.resignFirstResponder()
        return true
    }
    
    
    private func setupPhoto1(count:NSInteger) {
        let imagePickTool = CLImagePickersTool()
        self.loadImages.removeAll()

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

                self?.loadImages.append(image)
                self?.dealImage(imageArr: imageArr, index: index)
                
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
            addAlertTip()
        }
        // 图片显示出来以后可能还要上传到云端的服务器获取图片的url，这里不再细说了。
    }
    
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
            
            
            if uploadType == 3 {
                let params1 =
                    ["SESSIONID":Defaults[userToken]!,
                     "mobileCode":mobileCode,
                     "workId":periods_id,
                     "money":priceTextfield.text!,
                     ] as [String : String]
                
                NetWorkTeacherAddTNotWorkUploadFile(params: params1, data: loadImages, vc: self, success: { (data) in
                    self.mainTableView.mj_header.beginRefreshing()
                }, failture: { (error) in
                    
                })
            }else{
                let params1 =
                    ["SESSIONID":Defaults[userToken]!,
                     "mobileCode":mobileCode,
                     "periods_id":periods_id,
                     "money":priceTextfield.text!,
                     "type":String(uploadType),
                     ] as [String : String]
                
                NetWorkTeacherAddClassFiles(params: params1, data: loadImages, vc: self, success: { (data) in
                    self.mainTableView.mj_header.beginRefreshing()
                }, failture: { (error) in
                    
                })
            }
            
            self.mainTableView.reloadData()
        }
    }
    
}
