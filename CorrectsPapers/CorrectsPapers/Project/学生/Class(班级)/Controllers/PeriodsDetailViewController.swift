//
//  PeriodsDetailViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/6.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class PeriodsDetailViewController: BaseViewController ,HBAlertPasswordViewDelegate{
    var typeArr = ["课程视频","我的作业","参考答案","五星作业"]
    var headView = UIView()
    var buttonView = UIView()
    var footBtnView = UIView()

    var underLine = UIView()
    var NofitICLabel = UILabel()
    
    var currentIndex = 1
    
    var searchTextfield = UITextField()
    
    var titleArr1 = ["本节课课程视频","本节课讲义下载","本节课作业下载"]
    var titleArr3 = ["作业视频讲解","作业答案文档下载","文字版答案"]
    
    var currentTitle1 = ""
    var currentTitle2 = ""

    
    var workState = 0
    
    var images = NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configSubViews() {
        
        self.navigationItem.title = "第一课时"
        
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
        
        mainTableView.register(UINib(nibName: "ShowPeriodsCell", bundle: nil), forCellReuseIdentifier: identyfierTable)
        mainTableView.register(UINib(nibName: "SUploadWorkCell", bundle: nil), forCellReuseIdentifier: identyfierTable1)
        mainTableView.register(UINib(nibName: "ShowWorkStateCell", bundle: nil), forCellReuseIdentifier: identyfierTable2)
        mainTableView.register(UINib(nibName: "TClassInfoCell", bundle: nil), forCellReuseIdentifier: identyfierTable3)
        mainTableView.register(UINib(nibName: "TGoodWorkCell", bundle: nil), forCellReuseIdentifier: identyfierTable4)

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
        
        if currentIndex == 1 {
            currentTitle1 = (sender.titleLabel?.text)!
        }else{
            currentTitle2 = (sender.titleLabel?.text)!
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
        }else{
            footBtnView.removeFromSuperview()
        }
        
    }
    
    
    //MARK:  ******代理 ：UITableViewDataSource,UITableViewDelegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if currentIndex == 3 {
            return 3-titleArr3.count
        }
        
        if currentIndex == 2 {
            
            if workState == 0 {
                return 1
            }
            
            return 2
        }
        
        if currentIndex == 1 {
            return 3-titleArr1.count
        }
        
        return 10
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if currentIndex == 1 {
            let cell : ShowPeriodsCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable, for: indexPath) as! ShowPeriodsCell
//            cell.setValueForShowPeriodsCell(index: 10-indexPath.row)
            return cell
        }else if currentIndex == 2 {
            if workState == 0 {
                let cell : SUploadWorkCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable1, for: indexPath) as! SUploadWorkCell
                cell.SUploadWorkCellSetValues(images: images as! [UIImage])
                
                cell.addImageAction = {
                    print($0)
                    self.setupPhoto1(count: 30)
                }
                
                cell.deletImageAction = {
                    self.images.removeObject(at: $0)
                    tableView.reloadData()
                }
                cell.selectionStyle = .none
                return cell
                
            }else{
                
                let cell : ShowWorkStateCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable2, for: indexPath) as! ShowWorkStateCell
                
                if workState == 1 {
                    cell.TGoodWorkCellSetValueForUndone(count: 10)
                }else if workState == 2 {
                    
                    if indexPath.row == 1 {
                        let cell : SUploadWorkCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable1, for: indexPath) as! SUploadWorkCell
                        cell.SUploadWorkCellResubmit(images: images as! [UIImage])
                        
                        cell.addImageAction = {
                            print($0)
                            self.setupPhoto1(count: 30)
                        }
                        
                        cell.deletImageAction = {
                            self.images.removeObject(at: $0)
                            tableView.reloadData()
                        }
                        cell.selectionStyle = .none
                        return cell

                    }
                    
                    cell.TGoodWorkCellSetValueForWaitCorrect(count: 10)
                    return cell
                }else{
                    
                    if indexPath.row == 0{
                        cell.TGoodWorkCellSetValueForWaitCorrect(count: 10)
                    }else{
                        cell.TGoodWorkCellSetValueForFinish(count: 10)
                    }
                }
                
                cell.selectionStyle = .none
                return cell
            }
            
        }else if currentIndex == 3 {
            let cell : TClassInfoCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable3, for: indexPath) as! TClassInfoCell
            return cell
        }else{
            let cell : TGoodWorkCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable4, for: indexPath) as! TGoodWorkCell
            cell.TGoodWorkCellSetValueForGreade(count: indexPath.row+1)
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
            print("删除了---\(indexPath.section)分区-\(indexPath.row)行")
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
    
    
//    HBAlertPasswordViewDelegate 密码弹框代理
    func sureAction(with alertPasswordView: HBAlertPasswordView!, password: String!) {
        alertPasswordView.removeFromSuperview()
        setToast(str: "输入的密码为:"+password)
        if currentIndex == 1 {
            
            titleArr1.remove(at: titleArr1.index(of: currentTitle1)!)
            footView(titles: titleArr1)
            mainTableView.reloadData()
        }else{
            
            titleArr3.remove(at: titleArr3.index(of: currentTitle2)!)
            footView(titles: titleArr3)
            mainTableView.reloadData()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        PopViewUtil.share.stopLoading()
    }
    
}
