//
//  TDetailBookViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/20.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class TDetailBookViewController: BaseViewController {
    var footBtnView = UIView()

    var typeArr = ["我的作业","知识点讲解","参考答案","成绩统计"]
    var underLine = UIView()
    var headView = UIView()
    var currentIndex = 1
    
    var imageArr = [UIImage]()
    var videoArr = [UrlModel]()
    var textArr = [String]()
    var answerArr = [Array<Any>]()
    var pointArr = NSMutableArray()

    var model = TNotWorkDetailModel.init()
    var model1 = TNotWorkModel()

    let image1Arr = ["https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1507452668172&di=b56ef9d62498e704c0fa0e0b2c4d8dd5&imgtype=0&src=http%3A%2F%2Fimgphoto.gmw.cn%2Fattachement%2Fjpg%2Fsite2%2F20160714%2Fd02788d8df1018f171ec38.jpg","https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=998893491,2679530940&fm=27&gp=0.jpg"]
    
    let image2Arr = ["https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1508493015032&di=59d8fa812fd03a4721892617c48b431b&imgtype=0&src=http%3A%2F%2Fe.hiphotos.baidu.com%2Fimage%2Fpic%2Fitem%2Fa8ec8a13632762d02bd1d67fa9ec08fa503dc607.jpg","https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1508493043319&di=846fb92cbd69cba852b5052a3ac51bcd&imgtype=0&src=http%3A%2F%2Fimage1.miss-no1.com%2Fuploadfile%2F2015%2F11%2F06%2Fimg20246781918797.jpg"]
    
    let identyfierTable6 = "identyfierTable6"
    let identyfierTable7 = "identyfierTable7"
    let identyfierTable8 = "identyfierTable8"
    let identyfierTable9 = "identyfierTable9"
    let identyfierTable10 = "identyfierTable10"
    let identyfierTable11 = "identyfierTable11"

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        answerArr = [imageArr,videoArr,textArr]
        footView()
        addReasonView()
    }
    
    
    override func addHeaderRefresh() {
        
    }

    
    override func requestData() {
        
        let params1 =
            ["SESSIONID":SESSIONIDT,
             "mobileCode":mobileCodeT,
             "workId":model1.id
        ] as [String:Any]
        
        NetWorkTeacherGetTMyNotWorkDatails(params: params1) { (datas) in
            if datas.count>0{
                self.model = datas[0] as! TNotWorkDetailModel
            }
            self.mainTableArr.addObjects(from: datas)
            self.mainTableView.reloadData()
        }
    }
    
    
    override func configSubViews() {
        
        self.navigationItem.title = "练习册名称"
        
        headView = UIView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 80*kSCREEN_SCALE))
        headView.backgroundColor = UIColor.white

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
            let markBtn = UIButton.init(frame: CGRect(x: kSpace + (contentWidth + kSpace * CGFloat(index)) , y: 0, width: kWidth, height: kHeight))
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
        underLine = UIView.init(frame: CGRect(x: 0, y: 80 * kSCREEN_SCALE - 3, width: getLabWidth(labelStr: typeArr[0], font: kFont32, height: 1) - 5, height: 2))
        underLine.backgroundColor = kMainColor()
        underLine.layer.cornerRadius = 1
        underLine.clipsToBounds = true
        underLine.center.x = view.center.x
        headView.addSubview(underLine)
        self.view.addSubview(headView)
        
        mainTableView = UITableView.init(frame: CGRect(x: 0,
                                                       y: 80*kSCREEN_SCALE,
                                                       width: kSCREEN_WIDTH,
                                                       height: kSCREEN_HEIGHT - 64-80*kSCREEN_SCALE),
                                         style: .grouped)
        mainTableView.dataSource = self;
        mainTableView.delegate = self;
        mainTableView.estimatedRowHeight = 44
        mainTableView.register(UINib(nibName: "TViewBookCell", bundle: nil), forCellReuseIdentifier: identyfierTable)
        mainTableView.register(UINib(nibName: "AnserImageCell", bundle: nil), forCellReuseIdentifier: identyfierTable2)
        mainTableView.register(UINib(nibName: "AnserVideoCell", bundle: nil), forCellReuseIdentifier: identyfierTable3)
        mainTableView.register(UINib(nibName: "ClassGradeCell", bundle: nil), forCellReuseIdentifier: identyfierTable4)
        mainTableView.register(UINib(nibName: "TUpLoadVideoCell", bundle: nil), forCellReuseIdentifier: identyfierTable5)
        mainTableView.register(UINib(nibName: "ShowWriteAnswerCell", bundle: nil), forCellReuseIdentifier: identyfierTable6)
        mainTableView.register(UINib(nibName: "AnswerImageCell", bundle: nil), forCellReuseIdentifier: identyfierTable7)
        mainTableView.register(UINib(nibName: "TNotWorkInfoCell", bundle: nil), forCellReuseIdentifier: identyfierTable8)
        mainTableView.register(UINib(nibName: "TViewBookCell1", bundle: nil), forCellReuseIdentifier: identyfierTable9)
        mainTableView.register(UINib(nibName: "TViewBookCell2", bundle: nil), forCellReuseIdentifier: identyfierTable10)
        mainTableView.register(UINib(nibName: "TViewBookCell3", bundle: nil), forCellReuseIdentifier: identyfierTable11)

        self.view.addSubview(mainTableView)
        mainTableView.backgroundColor = kSetRGBColor(r: 239, g: 239, b: 244)
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
        footBtnView.backgroundColor = kGaryColor(num: 239)
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
            nextVC.currentType = 2
            nextVC.addUrlBlock = {
//                self.videoArr.append($0)
                self.mainTableView.reloadData()
            }
            self.navigationController?.pushViewController(nextVC, animated: true)
        }else  if sender.tag == 182{
            
            setupPhoto1(count: 100)
        }else  if sender.tag == 183{
            
            let nextVC = WriteAnswerViewController()
            nextVC.currentType = 2
            nextVC.addTextBlock = {
                self.textArr.append($0)
                self.mainTableView.reloadData()
            }
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
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
            self.view.addSubview(footBtnView)
        }else{
            footBtnView.removeFromSuperview()
        }
        
        let params =
            ["SESSIONID":SESSIONIDT,
             "mobileCode":mobileCodeT,
             "id":model1.id
        ]

        if currentIndex == 1 {
            
            NetWorkTeacherGetTStudentWorkList(params: params) { (datas) in
//                self.works.removeAllObjects()
//                self.works.addObjects(from: datas)
//                self.mainTableView.reloadData()
            }
        }else if currentIndex == 2 {
            
            NetWorkTeacherGetTMyNotWorkDatailPoints(params: params) { (datas) in
                self.pointArr.removeAllObjects()
                self.pointArr.addObjects(from: datas)
                self.mainTableView.reloadData()
            }
        }else if currentIndex == 3 {
            
//            let params1 =
//                ["SESSIONID":SESSIONIDT,
//                 "mobileCode":mobileCodeT,
////                 "workBookId":book_id
//            ]
//            NetWorkTeacherGetTMyNotWorkDatailAnswers(params: params1) { (datas) in
//                self.mainTableView.reloadData()
//            }
        }else if currentIndex == 4{
            
            NetWorkTeacherGetTMyNotWorkDatailGrades(params: params) { (datas) in
                self.answerArr.removeAll()
                // #MARK:待处理
                self.mainTableView.reloadData()
            }
        }
        
        mainTableView.reloadData()
    }
    
    
    //    ******************代理 ： UITableViewDataSource,UITableViewDelegate  ************
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if currentIndex == 1 {
            
            if section == 1 {
                return 1
            }else{
                if model.state != nil {
                    if Int(model.state!)!<5{
                        return 1
                    }else{
                        return 2
                    }
                }else{
                    return 0
                }
            }
        }
        
        if currentIndex == 2 {
            if section == 1 {
                return pointArr.count
            }else{
                return 1
            }
        }
        
        if currentIndex == 3 {
            return imageArr.count+videoArr.count+textArr.count
        }
        
        return  10
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        if currentIndex == 3 {
            return 1
        }
        
        if currentIndex == 2 {
            return 2
        }
        
        if currentIndex == 1 {
            return 2
        }
        
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if currentIndex == 1 {
           
            if indexPath.section == 1 {
                
                let cell : TNotWorkInfoCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable8, for: indexPath) as! TNotWorkInfoCell
                return cell
            }
            
            if model.state == "2" {
                let cell : TViewBookCell1 = tableView.dequeueReusableCell(withIdentifier: identyfierTable9, for: indexPath) as! TViewBookCell1
                cell.TViewBookCellSetValuesForNotWorkUndone(model: model)
                return cell
            }else  if model.state == "3" {
                let cell : TViewBookCell1 = tableView.dequeueReusableCell(withIdentifier: identyfierTable9, for: indexPath) as! TViewBookCell1
                cell.TViewBookCellSetValuesForNotWorkUndone(model: model)
                return cell

            }
            else  if model.state == "4" {
                
                let cell : TViewBookCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable, for: indexPath) as! TViewBookCell
                cell.TViewBookCellSetValuesForNotWorkFirstCorrectDone(model: model)
                return cell
            }
            else  if model.state == "5" {
                
                if indexPath.row == 0 {
                    let cell : TViewBookCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable, for: indexPath) as! TViewBookCell
                    cell.TViewBookCellSetValuesForNotWorkFirstCorrectDone(model: model)
                    return cell
                }else{
                    let cell : TViewBookCell3 = tableView.dequeueReusableCell(withIdentifier: identyfierTable11, for: indexPath) as! TViewBookCell3
                    cell.TViewBookCellSetValuesForNorWorkUndone(model: model)
                    return cell
                }
            }
            else  if model.state == "6" {
                
                if indexPath.row == 0 {
                    
                    let cell : TViewBookCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable, for: indexPath) as! TViewBookCell
                    cell.TViewBookCellSetValuesForNotWorkFirstCorrectDone(model: model)
                    return cell
                    
                }else{
                    
                    let cell : TViewBookCell3 = tableView.dequeueReusableCell(withIdentifier: identyfierTable11, for: indexPath) as! TViewBookCell3
                    cell.TViewBookCellSetValuesForNorWorkUndone(model: model)
                    return cell
                }
            }
            else {
                
                if indexPath.row == 0 {
                    
                    let cell : TViewBookCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable, for: indexPath) as! TViewBookCell
                    cell.TViewBookCellSetValuesForNotWorkFirstCorrectDone(model: model)
                    return cell
                }else{
                    
                    let cell : TViewBookCell2 = tableView.dequeueReusableCell(withIdentifier: identyfierTable10, for: indexPath) as! TViewBookCell2
                    cell.TViewBookCellSetValuesForNotWorkDone(model: model)
                    return cell
                }
            }
            
        }else if currentIndex == 2 {
            
            if indexPath.section == 0 {
                
                let cell : TUpLoadVideoCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable5, for: indexPath) as! TUpLoadVideoCell
                return cell
            }else{
                
                let model = pointArr[indexPath.row] as! UrlModel
                let cell : AnserVideoCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable3, for: indexPath) as! AnserVideoCell
                cell.AnserVideoCellSetValues(model: model)
                return cell
            }
        }else if currentIndex == 3 {
            
            let images = imageArr
            let videos = videoArr
            
            if indexPath.row<videos.count{
                
                let model = videoArr[indexPath.row]
                let cell : AnserVideoCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable3, for: indexPath) as! AnserVideoCell
                 cell.AnserVideoCellSetValues(model: model)
                return cell
            }else if indexPath.row<videos.count+images.count{
                
                let cell : AnswerImageCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable7, for: indexPath) as! AnswerImageCell
                cell.showWithImage(image: "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=998893491,2679530940&fm=27&gp=0.jpg")
                return cell
            }else{
                
                let cell : ShowWriteAnswerCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable6, for: indexPath) as! ShowWriteAnswerCell
                cell.showAnswer(text: textArr[indexPath.row-imageArr.count-videos.count])
                return cell
            }
        }else{
            let cell : ClassGradeCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable4, for: indexPath) as! ClassGradeCell
            
            if indexPath.row == 0 {
                cell.is1thCellForWorkBook()
            }else{
                cell.setValueForClassGradeCell(index: 10-indexPath.row)
//                cell.setValueForBookGrade(model: <#T##TShowGradeModel#>)
            }
            return cell
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if currentIndex == 2 {
            
            if indexPath.section == 0 {
                let nextVC = UploadVideoViewController()
                nextVC.isAnswer = false
                nextVC.addUrlBlock = {
//                    self.pointArr.append($0)
                    self.mainTableView.reloadData()
                }
                self.navigationController?.pushViewController(nextVC, animated: true)
            }else{
                
                let model = pointArr[indexPath.row] as! UrlModel
                
                let url = StringToUTF_8InUrl(str: model.answard_res)
                
                if #available(iOS 10.0, *) {
                    
                    UIApplication.shared.open(url, options: [:],
                                              completionHandler: {
                                                (success) in
                                                if !success {
                                                    setToast(str: "网址格式错误！")
                                                }
                                                
                    })
                } else {
                    // Fallback on earlier versions
                }
            }
        }
        
        
        if currentIndex == 4 {
            if indexPath.row != 0 {
                let showVC = TShowOneGradeVCViewController()
                self.navigationController?.pushViewController(showVC, animated: true)
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        if section == 0 && currentIndex == 1 {
            let footView = UIView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 350*kSCREEN_SCALE))
            footView.backgroundColor = UIColor.clear
            let certain = UIButton.init(frame: CGRect(x: 60 * kSCREEN_SCALE, y: 72*kSCREEN_SCALE, width: kSCREEN_WIDTH - 120 * kSCREEN_SCALE, height: 86 * kSCREEN_SCALE))
            certain.layer.cornerRadius = 10 * kSCREEN_SCALE
            certain.clipsToBounds = true
            certain.setBackgroundImage(getNavigationIMG(27, fromColor: kSetRGBColor(r: 0, g: 200, b: 255), toColor: kSetRGBColor(r: 0, g: 162, b: 255)), for: .normal)
            certain.setTitle("确认批改", for: .normal)
            certain.setTitleColor(kSetRGBColor(r: 255, g: 153, b: 0), for: .normal)
            certain.addTarget(self, action: #selector(certainCorrect), for: .touchUpInside)
            certain.setTitleColor(UIColor.white, for: .normal)
            footView.addSubview(certain)
            
            let sendBack = UIButton.init(frame: CGRect(x: 60 * kSCREEN_SCALE, y: 224*kSCREEN_SCALE, width: kSCREEN_WIDTH - 120 * kSCREEN_SCALE, height: 86 * kSCREEN_SCALE))
            sendBack.layer.cornerRadius = 10 * kSCREEN_SCALE
            sendBack.clipsToBounds = true
            sendBack.layer.borderColor = kMainColor().cgColor
            sendBack.layer.borderWidth = 1
            sendBack.setTitle("退回作业", for: .normal)
            sendBack.setTitleColor(kSetRGBColor(r: 255, g: 153, b: 0), for: .normal)
            sendBack.setTitleColor(kMainColor(), for: .normal)
            sendBack.addTarget(self, action: #selector(sendBackAction), for: .touchUpInside)
            footView.addSubview(sendBack)
            
            if model.state == "2" || model.state == "5" {
             
            }else{
                
                if model.state == "3" {
                    sendBack.setTitle("已退回", for: .normal)
                }
                
                if model.state == "4" {
                    certain.setTitle("已批改", for: .normal)
                }

                if model.state == "6" {
                    certain.setTitle("已批改", for: .normal)
                    sendBack.setTitle("已退回", for: .normal)
                }
                
                if model.state == "7" {
                    certain.setTitle("已批改", for: .normal)
                }
                
                certain.setBackgroundImage(getNavigationIMG(27, fromColor: kGaryColor(num: 206), toColor: kGaryColor(num: 206)), for: .normal)
                certain.backgroundColor = kGaryColor(num: 206)
                certain.setTitleColor(UIColor.white, for: .normal)
                certain.isEnabled = false
                sendBack.backgroundColor = kGaryColor(num: 206)
                sendBack.setTitleColor(UIColor.white, for: .normal)
                sendBack.isEnabled = false
                sendBack.layer.borderColor = kGaryColor(num: 206).cgColor
            }
            
            return footView
        }
        
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 19 * kSCREEN_SCALE))
        view.backgroundColor = UIColor.blue
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 19 * kSCREEN_SCALE))
        view.backgroundColor = kSetRGBColor(r: 239, g: 239, b: 244)
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 {
            return 0
        }
        return 19 * kSCREEN_SCALE
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        if section == 0 && currentIndex == 1{
            return 350*kSCREEN_SCALE
        }
        return 0
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
                
                self?.imageArr.append(image)
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
    var reasonView = ShowTagsView()

    func addReasonView() {
        //        弹出视图弹出来之后的背景蒙层
        BGView = UIView.init(frame: self.view.frame)
        BGView.backgroundColor = kSetRGBAColor(r: 5, g: 5, b: 5, a: 0.5)
        BGView.alpha = 0
        //        BGView.isHidden = true
        
        let tapGes1 = UITapGestureRecognizer.init(target: self, action: #selector(showChooseCondi(tap:)))
        tapGes1.numberOfTouchesRequired = 1
        BGView.addGestureRecognizer(tapGes1)
        self.view.addSubview(BGView)
        
        reasonView = UINib(nibName:"ShowTagsView",bundle:nil).instantiate(withOwner: self, options: nil).first as! ShowTagsView
        reasonView.ShowTagsViewForChooseEdu(title: "", index: 1000)
        reasonView.frame =  CGRect(x: 0, y: kSCREEN_HEIGHT, width: kSCREEN_WIDTH, height: 190+206*kSCREEN_SCALE)
        reasonView.layer.cornerRadius = 24*kSCREEN_SCALE
        reasonView.selectBlock = {
            if !$1 {
                print($0)
            }
            self.hiddenViews()
        }
        
        reasonView.clipsToBounds = true
        self.view.addSubview(reasonView)

    }
    
    
    @objc func showChooseCondi(tap:UITapGestureRecognizer) -> Void {
        
        if tap.view?.alpha == 1 {
            UIView.animate(withDuration: 0.5) {
                tap.view?.alpha = 0
                self.reasonView.transform = .identity
            }
        }
    }
    
    
    func hiddenViews() {
        
        UIView.animate(withDuration: 0.5) {
            self.BGView.alpha = 0
            self.reasonView.transform = .identity
        }
    }
    
    func showTheProjectTagsView() -> Void {
        
        let y = 180+206*kSCREEN_SCALE
        UIView.animate(withDuration: 0.5) {
            self.reasonView.transform = .init(translationX: 0, y: -y)
            self.BGView.alpha = 1
        }
    }
    
    
    @objc func certainCorrect() {
        
        var imageArr = [UIImage]()
        
        if model.state == "2" {
            let cell = mainTableView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as! TViewBookCell1
            imageArr.append(cell.image2.image!)
            imageArr.append(cell.image3.image!)
            let editorVC = QQQEditorViewController(nibName: "QQQEditorViewController", bundle: nil)
            editorVC.images = imageArr
            editorVC.theName = "刘二蛋"
            editorVC.theNum = "学号 008"
            editorVC.whereCome = 2
            self.present(editorVC, animated: true, completion: nil)
            
        }else{
            
            let cell = mainTableView.cellForRow(at: IndexPath.init(row: 1, section: 0)) as! TViewBookCell3
            imageArr.append(cell.image2.image!)
            imageArr.append(cell.image3.image!)
            let editorVC = QQQEditorViewController(nibName: "QQQEditorViewController", bundle: nil)
            editorVC.theName = "刘二蛋"
            editorVC.theNum = "学号 008"
            editorVC.images = imageArr
            editorVC.whereCome = 2
            self.present(editorVC, animated: true, completion: nil)
        }
    }
    
    @objc func sendBackAction() {
        showTheProjectTagsView()
    }
}
