//
//  TBookDetailViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/23.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyJSON

class TBookDetailViewController: BaseViewController,UITextFieldDelegate {
    
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
    var answerArr = [UrlModel]()
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

//    搜索框
    var isSearching = false
    var searchTextfield = UITextField()

    var footBtnView = UIView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        footView()
    }
    
    override func requestData() {
        
        let params =
            ["SESSIONID":SESSIONIDT,
             "mobileCode":mobileCodeT,
             "id":book_id
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
        
        let params1 =
            ["SESSIONID":SESSIONIDT,
             "mobileCode":mobileCodeT,
             "userWorkBookId":book_id,
             "pageNo":"1"
                ] as [String : Any]
        
        NetWorkTeacherGetTStudentWorkList(params: params1) { (datas,flag) in
            if flag {
                self.works.removeAllObjects()
                self.works.addObjects(from: datas)
                self.mainTableView.reloadData()
            }
            self.view.endLoading()
        }
    }
    
    
    override func addHeaderRefresh() {
        
    }
    
    
    override func configSubViews() {
        
        self.navigationItem.title = "练习册名称"
        
        headView = UIView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 224 + 80*kSCREEN_SCALE))
        headView.backgroundColor = UIColor.white
        infoView = UINib(nibName:"TBookHeadView",bundle:nil).instantiate(withOwner: self, options: nil).first as! TBookHeadView
        infoView.frame =  CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 224)
        headView.addSubview(infoView)
        
        
        let kHeight = CGFloat(80 * kSCREEN_SCALE)
        var contentWidth = CGFloat()
        var totalWidth = CGFloat()
        
        //MARK: 因为按钮字数不一样，长短有别，所以我先看看一共有多长再平分space
        for index in 0...typeArr.count-1{
            
            let kWidth = getLabWidth(labelStr: typeArr[index], font: kFont32, height: kHeight) + 10
            totalWidth += kWidth
            
        }
        
        let kSpace = CGFloat(kSCREEN_WIDTH - totalWidth)/CGFloat(typeArr.count+1)
        
        for index in 0...typeArr.count-1{
            
            let kWidth = getLabWidth(labelStr: typeArr[index], font: kFont32, height: kHeight) + 10
            let markBtn = UIButton.init(frame: CGRect(x: kSpace + (contentWidth + kSpace * CGFloat(index)) , y: 224, width: kWidth, height: kHeight))
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
        underLine = UIView.init(frame: CGRect(x: 0, y: 224+80 * kSCREEN_SCALE - 3, width: getLabWidth(labelStr: typeArr[0], font: kFont32, height: 1) - 5, height: 2))
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
        mainTableView.register(UITableViewCell.self, forCellReuseIdentifier: identyfierTable11)
        
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
             "id":book_id
        ]
        
        if currentIndex == 4 {
            self.view.addSubview(footBtnView)
        }else{
            footBtnView.removeFromSuperview()
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
            
            NetWorkTeacherGetTPeriodPoint(params: params) { (datas,flag) in
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
            //            #WORNNINGN:
            NetWorkTeacherGetTPeriodAnswers(params: params) { (datas,flag) in
                
                if flag {
                    self.answerArr.removeAll()
                    for index in 0..<datas.count {
                        let model = datas[index] as! UrlModel
                        self.answerArr.append(model)
                    }
                    self.mainTableView.reloadData()
                }
                self.view.endLoading()
            }
        }else{
            
            NetWorkTeacherGetTStudentGrades(params: params) { (datas,flag) in
                if flag {
                    self.grades.removeAllObjects()
                    self.grades.addObjects(from: datas)
                    self.mainTableView.reloadData()
                }
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
        let params =
            ["SESSIONID":SESSIONIDT,
             "mobileCode":mobileCodeT,
             "id":book_id
        ]
        
        if currentIndex == 4 {
            self.view.addSubview(footBtnView)
        }else{
            footBtnView.removeFromSuperview()
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

//            NetWorkTeacherGetTPeriodAnswers(params: params) { (datas) in
//                self.answerArr.removeAll()
//                // #MARK:待处理
//                self.mainTableView.reloadData()
//            }
        }else{
            
            let date = NSDate.init()
            let formatter = DateFormatter()
            //日期样式
            formatter.dateFormat = "yyyy/MM/dd"

            let params1 =
                ["SESSIONID":SESSIONIDT,
                 "mobileCode":mobileCodeT,
                 "type":"1",
                 "date":formatter.string(from: date as Date),
                 "workBook_id":book_id,
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
            
            let model = answerArr[indexPath.row]
            if model.type == "1" {
                let cell : AnserVideoCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable3, for: indexPath) as! AnserVideoCell
                cell.AnserVideoCellSetValues(model: model)
                return cell

            }else if model.type == "2" {

                let cell : ShowFileCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable9, for: indexPath) as! ShowFileCell
                return cell

            }else if model.type == "3" {
                
                let cell : ShowWriteAnswerCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable11, for: indexPath) as! ShowWriteAnswerCell
                cell.showAnswer(text: model.title)
                return cell
            }else{
                
                let cell : AnswerImageCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable8, for: indexPath) as! AnswerImageCell
                cell.showWithImage(image: model.address!)
                return cell
            }
            
        }else{
            
            let cell : ClassGradeCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable4, for: indexPath) as! ClassGradeCell
            
            if indexPath.row == 0 {
                cell.is1thCell()
            }else{
                let model = grades[indexPath.row-1] as! TShowGradeModel
                cell.setValueForBookGrade(model:model)
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
                if model.correcting_states == "2" || model.correcting_states == "5" {
                    self.navigationController?.pushViewController(viewC, animated: true)
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

                    self.mainTableView.reloadData()
                }
                self.navigationController?.pushViewController(nextVC, animated: true)
            }else{
               
                let model = videoArr[indexPath.row]
                let url = StringToUTF_8InUrl(str: model.address!)
                if #available(iOS 10.0, *) {
                  
                    UIApplication.shared.open(url as URL, options: [:],
                                              completionHandler: {
                                                (success) in
                    })
                } else {
                    // Fallback on earlier versions
                }
            }
        }
        
        if currentIndex == 4 {

        }
        
        if currentIndex == 5 {
            if indexPath.row != 0 {
                let showVC = TShowOneGradeVCViewController()
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
            nextVC.currentType = 1
            self.navigationController?.pushViewController(nextVC, animated: true)
        }else  if sender.tag == 182{
            
            setupPhoto1(count: 100)
        }else  if sender.tag == 183{
            
            let nextVC = WriteAnswerViewController()
            nextVC.currentType = 1
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        textField.resignFirstResponder()

        let params1 =
            ["SESSIONID":SESSIONIDT,
             "mobileCode":mobileCodeT,
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
                let params1 =
                    [
                        "SESSIONID":SESSIONIDT,
                        "mobileCode":mobileCodeT,
                        "workId":self?.book_id
                        ] as! [String:String]

                NetWorkTeacherUploadAnswerImages(params: params1, data: imageArr, success: { (success) in
                    let json = JSON(success)
                    deBugPrint(item: json)
                    if json["code"] == "1" {
                        setToast(str: "上传成功")
                    }

                }, failture: { (error) in
                    
                })
                
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
        }
        // 图片显示出来以后可能还要上传到云端的服务器获取图片的url，这里不再细说了。
    }
    
}
