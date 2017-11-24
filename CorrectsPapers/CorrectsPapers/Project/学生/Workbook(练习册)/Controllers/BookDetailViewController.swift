//
//  BookDetailViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/18.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class BookDetailViewController: BaseViewController {
    var typeArr = NSMutableArray()
    var headView = UIView()
    var underLine = UIView()
    
    var currentIndex = 1
    
    var images = NSMutableArray()
    
    var showDateView = UIView()

    var dateBtn = UIButton()
    
    var model = WorkBookModel()

    override func viewDidLoad() {
        super.viewDidLoad()
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
            print(dataArr)
            self.view.endLoading()
        }
        
    }
    
    override func configSubViews() {
        
        self.navigationItem.title = "非练习册"
        
        typeArr = ["知识点讲解","参考答案"]
        let kHeight = CGFloat(44)
        
        var contentWidth = CGFloat()
        var totalWidth = CGFloat()
        
        headView = UIView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 43))
        
        //MARK: 因为按钮字数不一样，长短有别，所以我先看看一共有多长再平分space
        for index in 0...typeArr.count-1{
            
            let kWidth = getLabWidth(labelStr: typeArr[index] as! String, font: kFont32, height: kHeight) + 10
            totalWidth += kWidth
        }
        
        let kSpace = CGFloat(kSCREEN_WIDTH - totalWidth)/3
        
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
        underLine = UIView.init(frame: CGRect(x: 0, y: 40, width: getLabWidth(labelStr: "等时我粉丝", font: kFont32, height: 1) - 5, height: 2))
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
        
        if currentIndex > 2 {
            mainTableArr = []
        }
        
        mainTableArr = ["性别","年龄","地区","积分","身高","体重"]
        
        mainTableView.reloadData()
    }
    
    
    //MARK:  ******代理 ：UITableViewDataSource,UITableViewDelegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if currentIndex == 1 {
            return 2
        }
        
        if currentIndex == 3 {
            return 10
        }
        
        return 5
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if currentIndex == 1 {
            
            let cell : AnserVideoCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable3, for: indexPath) as! AnserVideoCell
            return cell
            
        }else{
            
            let cell : AnserImageCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable, for: indexPath) as! AnserImageCell
            return cell
            
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if currentIndex == 1 {
            
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
