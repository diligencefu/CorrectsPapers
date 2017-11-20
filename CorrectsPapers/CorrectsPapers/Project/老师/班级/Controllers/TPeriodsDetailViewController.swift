//
//  TPeriodsDetailViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/15.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class TPeriodsDetailViewController: BaseViewController,UITextFieldDelegate {
    
    var typeArr = ["学生作业","已批改","课程视频","作业答案"]
    var underLine = UIView()
    var headView = UIView()
    var NofitICLabel = UILabel()
    var buttonView = UIView()

    var currentIndex = 1
    //    作业
    var works = NSMutableArray()
    //    已批改
    var doneWorks = NSMutableArray()
    //    知识点
    var videoArr = [UrlModel]()
    //    参考答案数据
    var answerArr = [UIImage]()
    //    成绩
    var grades = NSMutableArray()
    
    var searchArr = NSMutableArray()
    
    //    var bookState = 0
    
    var periods_id = ""
    
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
        
//        let params1 =
//            ["SESSIONID":SESSIONIDT,
//             "mobileCode":mobileCodeT,
//             "id":book_id
//        ]
//
//        NetWorkTeacherGetTStudentWorkList(params: params1) { (datas) in
//            self.works.removeAllObjects()
//            self.works.addObjects(from: datas)
//            self.mainTableView.reloadData()
//        }
        
        
        let params =
            ["SESSIONID":SESSIONIDT,
             "mobileCode":mobileCodeT,
             "periods_id":"1"
        ] as [String:Any]
        
        NetWorkTeacherSelectClassBook(params: params, callBack: { (datas) in
            self.works.removeAllObjects()
            self.works.addObjects(from: datas)
            self.mainTableView.reloadData()
        })
        
    }
    
    
    override func addHeaderRefresh() {
        
    }
    
    
    override func configSubViews() {
        
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
        mainTableView.register(UITableViewCell.self, forCellReuseIdentifier: identyfierTable11)
        
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
        
        if currentIndex == 4 {
            self.view.addSubview(footBtnView)
        }else{
            footBtnView.removeFromSuperview()
        }
        
        
        let params =
            ["SESSIONID":SESSIONIDT,
             "mobileCode":mobileCodeT,
             "periods_id":periods_id
        ]

        if currentIndex == 1 {
            
            NetWorkTeacherSelectClassBook(params: params, callBack: { (datas) in
                self.works.removeAllObjects()
                self.works.addObjects(from: datas)
                self.mainTableView.reloadData()
            })
            
        }else if currentIndex == 2 {
            
        }else if currentIndex == 3 {
            
        }else if currentIndex == 4{
            
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
            self.view.addSubview(footBtnView)
        }else{
            footBtnView.removeFromSuperview()
        }
        
        let params =
            ["SESSIONID":SESSIONIDT,
             "mobileCode":mobileCodeT,
             "periods_id":periods_id
        ]
        
        if currentIndex == 1 {
            
            NetWorkTeacherSelectClassBook(params: params, callBack: { (datas) in
                
            })
        }else if currentIndex == 2 {
        }else if currentIndex == 3 {
        }else if currentIndex == 4{
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
        return answerArr.count
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
            print(model.type)
            
            let cell : TViewBookCell0 = tableView.dequeueReusableCell(withIdentifier: identyfierTable10, for: indexPath) as! TViewBookCell0
            cell.TViewBookCell0SetValuesForShowClassWork(model: model)
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
            
        }else{
            
            let cell : AnserImageCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable2, for: indexPath) as! AnserImageCell
            return cell
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if currentIndex == 1 {
            
            if !isSearching {
                let viewC = TShowClassWorkViewController()
                let model = works[indexPath.row] as! TShowClassWorksModel
                viewC.model = model
                
                self.navigationController?.pushViewController(viewC, animated: true)
            }
        }
        
        if currentIndex == 3 {
            
            if indexPath.section == 0 {
                
                let nextVC = UploadVideoViewController()
                nextVC.isAnswer = false
                nextVC.addUrlBlock = {
//                    self.videoArr.append($0)
                    self.mainTableView.reloadData()
                }
                self.navigationController?.pushViewController(nextVC, animated: true)
            }else{
                
                let model = videoArr[indexPath.row]
                let url = StringToUTF_8InUrl(str: model.videoUrl)
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
        
        print(sender.tag)
        
        if sender.tag == 181 {
            
            let nextVC = UploadVideoViewController()
            nextVC.isAnswer = true
            nextVC.currentType = 3
            //            nextVC.addUrlBlock = {
            //                self.videoArr.append($0)
            //                self.mainTableView.reloadData()
            //            }
            
            self.navigationController?.pushViewController(nextVC, animated: true)
        }else  if sender.tag == 182{
            
            setupPhoto1(count: 100)
        }else  if sender.tag == 183{
            
            let nextVC = WriteAnswerViewController()
            nextVC.currentType = 3

            //            nextVC.addTextBlock = {
            //                self.mainTableView.reloadData()
            //            }
            self.navigationController?.pushViewController(nextVC, animated: true)
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
                
                self?.answerArr.append(image)
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
