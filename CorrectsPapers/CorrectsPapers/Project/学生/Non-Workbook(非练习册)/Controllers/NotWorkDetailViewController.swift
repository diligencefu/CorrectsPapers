//
//  NotWorkDetailViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/16.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class NotWorkDetailViewController: BaseViewController,HBAlertPasswordViewDelegate{
    
    var typeArr = NSMutableArray()
    var headView = UIView()
    var underLine = UIView()
    var footBtnView = UIView()

    var currentIndex = 1
    var images = NSMutableArray()
    var showDateView = UIView()
    var dateBtn = UIButton()
    
    var titleArr1 = ["本节课课程视频","本节课讲义下载","本节课作业下载"]
    var titleArr3 = ["作业视频讲解","作业答案文档下载","文字版答案"]
    var currentTitle1 = ""
    var currentTitle2 = ""
    
    let identyfierTable6 = "identyfierTable6"
    let identyfierTable9 = "identyfierTable9"
    let identyfierTable10 = "identyfierTable10"
    let identyfierTable11 = "identyfierTable11"
    
    var model = SNotWorkModel()
    
    
    var state = ""
    var pointArr = NSMutableArray()
    var answerArr = NSMutableArray()
    var gradeArr = NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func requestData() {
        
//        let params =
//            [
//                "userWorkBookId":model.userWorkBookId,
//                "SESSIONID":SESSIONID,
//                "mobileCode":mobileCode
//        ]
//
//        netWorkForGetWorkBookByTime(params: params) { (dataArr) in
//            print(dataArr)
//        }
//
    }
    
    override func configSubViews() {
        
        self.navigationItem.title = "非练习册"
        
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
        
        let kSpace = CGFloat(kSCREEN_WIDTH - totalWidth)/5
        
        for index in 0..<typeArr.count{
            
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
        underLine = UIView.init(frame: CGRect(x: 0, y: 40, width: getLabWidth(labelStr: "时我粉丝", font: kFont32, height: 1) - 5, height: 2))
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
        mainTableView.register(UINib(nibName: "ClassGradeCell", bundle: nil), forCellReuseIdentifier: identyfierTable4)
        mainTableView.register(UINib(nibName: "CreateBookCell", bundle: nil), forCellReuseIdentifier: identyfierTable5)
        mainTableView.register(UINib(nibName: "TViewBookCell", bundle: nil), forCellReuseIdentifier: identyfierTable6)
        mainTableView.register(UINib(nibName: "TViewBookCell1", bundle: nil), forCellReuseIdentifier: identyfierTable9)
        mainTableView.register(UINib(nibName: "TViewBookCell2", bundle: nil), forCellReuseIdentifier: identyfierTable10)
        mainTableView.register(UINib(nibName: "TViewBookCell3", bundle: nil), forCellReuseIdentifier: identyfierTable11)

        self.view.addSubview(mainTableView)
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
        
      
        if currentIndex == 3 {
            footView(titles: titleArr3)
        }else{
            footBtnView.removeFromSuperview()
        }
        
        if currentIndex == 1 {
            
        }else if currentIndex == 2 {
            let params =
                [
                    "NonExcrcise_id":model.non_exercise_id,
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
        
        if currentIndex == 1 {
            
        }else{
            
        }
        
        passwd.titleLabel.text = "五哈哈哈哈"
        self.view.addSubview(passwd)
        
        if currentIndex == 2 {
            currentTitle1 = (sender.titleLabel?.text)!
        }else{
            currentTitle2 = (sender.titleLabel?.text)!
        }
    }
    
    
    //    HBAlertPasswordViewDelegate 密码弹框代理
    func sureAction(with alertPasswordView: HBAlertPasswordView!, password: String!) {
        alertPasswordView.removeFromSuperview()
        setToast(str: "输入的密码为:"+password)
        if currentIndex == 2 {
            
            titleArr1.remove(at: titleArr1.index(of: currentTitle1)!)
            footView(titles: titleArr1)
            mainTableView.reloadData()
        }else{
            
            titleArr3.remove(at: titleArr3.index(of: currentTitle2)!)
            footView(titles: titleArr3)
            mainTableView.reloadData()
        }
    }

    
    //MARK:  ******代理 ：UITableViewDataSource,UITableViewDelegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if currentIndex == 3 {
            return 3-titleArr3.count
        }
        
        if currentIndex == 1 {
            
            if Int(state)! < 5 {
                return 1
            }
            
            return 2
        }
        
        if currentIndex == 2 {
            return 3-titleArr1.count
        }
        
        return 10
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if currentIndex == 1 {
            
            if state == "2" {
                
                let cell : TViewBookCell1 = tableView.dequeueReusableCell(withIdentifier: identyfierTable9, for: indexPath) as! TViewBookCell1
//                cell.TViewBookCellSetValuesForUndone(model: model)
                return cell
            }else  if state == "3" {
                
                let cell : TViewBookCell1 = tableView.dequeueReusableCell(withIdentifier: identyfierTable9, for: indexPath) as! TViewBookCell1
//                cell.TViewBookCellSetValuesForUndone(model: model)
                return cell
            }else  if state == "4" {
                
                let cell : TViewBookCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable6, for: indexPath) as! TViewBookCell
//                cell.TViewBookCellSetValuesForFirstCorrectDone(model: model)
                return cell
            }
            else  if state == "5" {
                
                if indexPath.row == 0 {
                    let cell : TViewBookCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable6, for: indexPath) as! TViewBookCell
//                    cell.TViewBookCellSetValuesForFirstCorrectDone(model: model)
                    return cell
                }else{
                    let cell : TViewBookCell3 = tableView.dequeueReusableCell(withIdentifier: identyfierTable11, for: indexPath) as! TViewBookCell3
//                    cell.TViewBookCellSetValuesForNorWorkUndone(model: model)
                    return cell
                }
            }
            else  if state == "6" {
                
                if indexPath.row == 0 {
                    
                    let cell : TViewBookCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable6, for: indexPath) as! TViewBookCell
//                    cell.TViewBookCellSetValuesForFirstCorrectDone(model: model)
                    return cell
                    
                }else{
                    
                    let cell : TViewBookCell3 = tableView.dequeueReusableCell(withIdentifier: identyfierTable11, for: indexPath) as! TViewBookCell3
//                    cell.TViewBookCellSetValuesForNorWorkUndone(model: model)
                    return cell
                }
            }
            else {
                
                if indexPath.row == 0 {
                    
                    let cell : TViewBookCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable6, for: indexPath) as! TViewBookCell
//                    cell.TViewBookCellSetValuesForFirstCorrectDone(model: model)
                    return cell
                }else{
                    
                    let cell : TViewBookCell2 = tableView.dequeueReusableCell(withIdentifier: identyfierTable10, for: indexPath) as! TViewBookCell2
//                    cell.TViewBookCellSetValuesForDone(model: model)
                    return cell
                }
            }
        }
        
        if currentIndex == 2 {
            
            let cell : AnserVideoCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable3, for: indexPath) as! AnserVideoCell
            return cell
            
        }else if currentIndex == 3 {
            
            let cell : AnserImageCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable, for: indexPath) as! AnserImageCell
            return cell
        }
        
        let cell : ClassGradeCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable4, for: indexPath) as! ClassGradeCell
        
        if indexPath.row == 0 {
            cell.is1thCell()
        }else{
            cell.setValueForClassGradeCell(index: 10-indexPath.row)
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
        
        if currentIndex == 4 {
            
            
//
//
//            // 获得此程序的沙盒路径
//            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
//
//            var files = [String]()
//            let fileManager = FileManager.default
//            let enumerator: FileManager.DirectoryEnumerator = fileManager.enumerator(atPath: path.first!)!
//            while let element = enumerator.nextObject() as? String {
//                if element.hasSuffix(".doc") || element.hasSuffix(".xls") || element.hasSuffix(".ppt") || element.hasSuffix(".docx") || element.hasSuffix(".xlsx") || element.hasSuffix(".pptx") || element.hasSuffix(".pdf") {
//                    files.append(element)
//                }
//            }
//
//            do {
//                if files.count > 0 {
//            
            
            
//                }
//
//            } catch  {
//                print("error :\(error)")
//            }
//
//            //复制文件（重命名）
//            NSString *copyPath = [NSHomeDirectory() stringByAppendingPathComponent:@"备份/Old Testament.txt"];                              [fileManager createDirectoryAtPath:[toPath stringByDeletingLastPathComponent] withIntermediateDirectories:YES attributes:nil error:nil]
//
//
//
//            let fileData = Data.init(contentsOf:NSURL.init(string: Bundle.main.path(forResource: "批改作业接口 1107(1)", ofType: "docx")!)! as URL)
//
//            fileData.write(to: NSURL.init(fileURLWithPath: path[0]) as URL)
//
            
        }
        
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
    
    
    override func viewWillDisappear(_ animated: Bool) {
        PopViewUtil.share.stopLoading()
    }
}
