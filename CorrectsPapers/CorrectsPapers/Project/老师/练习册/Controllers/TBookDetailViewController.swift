//
//  TBookDetailViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/23.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class TBookDetailViewController: BaseViewController {
    
    var typeArr = ["我的作业","已批改","知识点讲解","参考答案","成绩"]
    var underLine = UIView()
    var headView = UIView()
    var currentIndex = 1
    var videoArr = [Dictionary<String, String>]()
    var answerArr = [UIImage]()
    
    var tipView = TTipView()
    var BGView = UIView()
    
    //    var bookState = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configSubViews() {
        
        self.navigationItem.title = "练习册名称"
        
        headView = UIView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 224 + 80*kSCREEN_SCALE))
        
        let infoView = UINib(nibName:"TBookHeadView",bundle:nil).instantiate(withOwner: self, options: nil).first as! TBookHeadView
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
                                         style: .grouped)
        mainTableView.dataSource = self;
        mainTableView.delegate = self;
        mainTableView.estimatedRowHeight = 44
        mainTableView.register(UINib(nibName: "TViewBookCell", bundle: nil), forCellReuseIdentifier: identyfierTable)
        
        mainTableView.register(UINib(nibName: "AnserImageCell", bundle: nil), forCellReuseIdentifier: identyfierTable2)
        mainTableView.register(UINib(nibName: "AnserVideoCell", bundle: nil), forCellReuseIdentifier: identyfierTable3)
        mainTableView.register(UINib(nibName: "showGradeCell", bundle: nil), forCellReuseIdentifier: identyfierTable4)
        mainTableView.register(UINib(nibName: "TUpLoadVideoCell", bundle: nil), forCellReuseIdentifier: identyfierTable5)
        
        mainTableView.tableHeaderView = headView
        self.view.addSubview(mainTableView)
        mainTableView.backgroundColor = kSetRGBColor(r: 239, g: 239, b: 244)
        mainTableArr = ["关于我们","清除缓存","检查更新"]
        
        
        
        //        弹出视图弹出来之后的背景蒙层
        BGView = UIView.init(frame: self.view.frame)
        BGView.backgroundColor = kSetRGBAColor(r: 5, g: 5, b: 5, a: 0.5)
        BGView.alpha = 0
        self.view.addSubview(BGView)
        
        tipView = UINib(nibName:"TTipView",bundle:nil).instantiate(withOwner: self, options: nil).first as! TTipView
        tipView.frame =  CGRect(x: (KScreenWidth-300)/2, y: KScreenHeight, width: 300, height: 200)
        
        tipView.chooseBlock = {
            
            self.videoArr.append($0)
            self.mainTableView.reloadData()
            self.tipView.frame =  CGRect(x: 0, y: KScreenHeight, width: 300, height: 200)
            self.BGView.alpha = 0
            
        }
        
        tipView.closeBlock = {
            
            UIView.animate(withDuration: 0.5) {
                self.tipView.frame =  CGRect(x: 0, y: KScreenHeight, width: 300, height: 200)
                self.BGView.alpha = 0
            }
            
        }
        
        self.view.addSubview(tipView)
        
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
        
        mainTableView.reloadData()
    }
    
    
    //    ******************代理 ： UITableViewDataSource,UITableViewDelegate  ************
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if currentIndex == 1 || currentIndex == 2 {
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
            if section == 1 {
                return answerArr.count
            }else{
                return 1
            }
        }
        
        return  10
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        if currentIndex == 3 || currentIndex == 4 {
            return 2
        }
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if currentIndex == 1 {
            let cell : TViewBookCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable, for: indexPath) as! TViewBookCell
            cell.TViewBookCellSetValuesForUndone(images:["https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1507452668172&di=b56ef9d62498e704c0fa0e0b2c4d8dd5&imgtype=0&src=http%3A%2F%2Fimgphoto.gmw.cn%2Fattachement%2Fjpg%2Fsite2%2F20160714%2Fd02788d8df1018f171ec38.jpg","https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=998893491,2679530940&fm=27&gp=0.jpg"])
            return cell
            
        }else if currentIndex == 2 {
            let cell : TViewBookCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable, for: indexPath) as! TViewBookCell
            cell.TViewBookCellSetValuesForFirstCorrect(images: ["https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1507452668172&di=b56ef9d62498e704c0fa0e0b2c4d8dd5&imgtype=0&src=http%3A%2F%2Fimgphoto.gmw.cn%2Fattachement%2Fjpg%2Fsite2%2F20160714%2Fd02788d8df1018f171ec38.jpg","https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=998893491,2679530940&fm=27&gp=0.jpg"])
            return cell
            
        }else if currentIndex == 3 {
            
            if indexPath.section == 0 {
                
                let cell : TUpLoadVideoCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable5, for: indexPath) as! TUpLoadVideoCell
                
                return cell
                
            }else{
                let cell : AnserVideoCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable3, for: indexPath) as! AnserVideoCell
                
                cell.AnserVideoCellSetValues(title:videoArr[indexPath.row]["descrip"]!)
                
                return cell
                
            }
            
        }else if currentIndex == 4 {
            
            if indexPath.section == 0 {
                
                let cell : TUpLoadVideoCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable5, for: indexPath) as! TUpLoadVideoCell
                
                return cell
                
            }else{
                
                let cell : AnserImageCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable2, for: indexPath) as! AnserImageCell
                return cell
                
            }
            
        }else{
            let cell : showGradeCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable4, for: indexPath) as! showGradeCell
            if indexPath.row == 0 {
                cell.showGrade(isTitle: true)
            }else{
                cell.showGrade(isTitle: false)
            }
            return cell
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if currentIndex == 3 {
            
            if indexPath.section == 0 {
                showTipView()
            }else{
                let url = NSURL.init(string: videoArr[indexPath.row]["url"]!)
                
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
        
        
        if currentIndex == 4 {
            if indexPath.section == 0 {
                setupPhoto1(count: 10)
            }else{
                
            }
        }
        
    }
    
    
    //MARK:   弹出视图的出现事件
    func showTipView() -> Void {
        
        UIView.animate(withDuration: 0.5) {
            self.tipView.frame =  CGRect(x: (kSCREEN_WIDTH-300)/2, y: KScreenHeight / 2 - 200, width: 300, height: 200)
            self.BGView.alpha = 1
        }
        
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
