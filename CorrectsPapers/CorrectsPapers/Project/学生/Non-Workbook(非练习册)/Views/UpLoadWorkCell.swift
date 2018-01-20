//
//  UpLoadWorkCell.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/16.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class UpLoadWorkCell: UITableViewCell {

    @IBOutlet weak var workDescrip: UITextField!
    
    @IBOutlet weak var CountDown: UILabel!
    
    var time = NSInteger()
    
    
//    @IBOutlet weak var image1: UIButton!
//
//    @IBOutlet weak var image2: UIButton!
//    @IBOutlet weak var image3: UIButton!

    
    
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    
    var images = NSMutableArray()

    
    @IBOutlet weak var upLoad: UIButton!
    
    var chooseImagesAction:((String)->())?  //声明闭包    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        upLoad.layer.cornerRadius = 4
        upLoad.clipsToBounds = true
        
        let singleTap1 = UITapGestureRecognizer.init(target: self, action: #selector(viewTheBigImage(ges:)))
        singleTap1.numberOfTapsRequired = 1
        image1.addGestureRecognizer(singleTap1)

        
        let singleTap2 = UITapGestureRecognizer.init(target: self, action: #selector(viewTheBigImage(ges:)))
        singleTap2.numberOfTapsRequired = 1
        image2.addGestureRecognizer(singleTap2)

        let singleTap3 = UITapGestureRecognizer.init(target: self, action: #selector(viewTheBigImage(ges:)))
        singleTap3.numberOfTapsRequired = 1
        image3.addGestureRecognizer(singleTap3)
    }
    
    
    @objc func viewTheBigImage(ges:UITapGestureRecognizer) {
        
        if upLoad.titleLabel?.text == "完成更正" && time <= 0{
            setToast(str: "你已超时，无法上传作业")
        }else{
            if chooseImagesAction != nil {
                if ges.view?.tag == 230 {
                    chooseImagesAction!(String((ges.view?.tag)!-230))
                }else{
                    chooseImagesAction!(String((ges.view?.tag)!-231))
                }
            }
        }
    }
    
    
    // 异步原图
    private func setupPhoto1(count:NSInteger) {
        let imagePickTool = CLImagePickersTool()
        
        imagePickTool.isHiddenVideo = true
        
        imagePickTool.setupImagePickerWith(MaxImagesCount: count, superVC: viewController()!) { (assetArr,cutImage) in
            deBugPrint(item: "返回的asset数组是\(assetArr)")
            
            PopViewUtil.share.showLoading()
            
            var imageArr = [UIImage]()
            var index = assetArr.count // 标记失败的次数
            
            // 获取原图，异步
            // scale 指定压缩比
            // 内部提供的方法可以异步获取图片，同步获取的话时间比较长，不建议！，如果是iCloud中的照片就直接从icloud中下载，下载完成后返回图片,同时也提供了下载失败的方法
            CLImagePickersTool.convertAssetArrToOriginImage(assetArr: assetArr, scale: 0.1, successClouse: {[weak self] (image,assetItem) in
                imageArr.append(image)
                
                self?.images.add(image)
                
                if self?.images.count == 0 {
                    self?.image2.isHidden = true
                    self?.image3.isHidden = true
                    self?.upLoad.backgroundColor = kGaryColor(num: 206)
                    self?.upLoad.isEnabled = false

                }else if self?.images.count == 1 {
                    self?.image2.image = self?.images[0] as? UIImage
                    self?.image1.isHidden = true
                    self?.image2.isHidden = false
                    self?.image3.isHidden = false
                    self?.upLoad.backgroundColor = kMainColor()
                    self?.upLoad.isEnabled = true

                }else{
                    self?.image2.image = self?.images[0] as? UIImage
                    self?.image3.image = self?.images[1] as? UIImage
                    self?.image1.isHidden = true
                    self?.image2.isHidden = false
                    self?.image3.isHidden = false
                    self?.upLoad.backgroundColor = kMainColor()
                    self?.upLoad.isEnabled = true

                }
                
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
        }
        // 图片显示出来以后可能还要上传到云端的服务器获取图片的url，这里不再细说了。
    }
    
    
    @IBAction func uploadAction(_ sender: UIButton) {
//        setToast(str: "上传作业")
        
//        if CountDown.isHidden {
//            if workDescrip.text?.count == 0 && sender.titleLabel?.text != "完成更正"{
//                setToast(str: "请输入作业描述")
//                workDescrip.becomeFirstResponder()
//                return
//            }
//        }
//
//
//
//        if (workDescrip.text?.count)! > 16 && sender.titleLabel?.text != "完成更正"{
//            setToast(str: "作业描述超出字数限制！")
//            workDescrip.becomeFirstResponder()
//            return
//        }
        
        
        if sender.titleLabel?.text == "完成更正" {
            
            if time>0{
                if chooseImagesAction != nil {
                    chooseImagesAction!("uploadAction")
                }
            }
        }else{
            if chooseImagesAction != nil {
                chooseImagesAction!("uploadAction")
            }
        }
    }
    
    
    func upLoadImagesForWorkBookNonWork(images:Array<UIImage>,isFirst:Bool) {
        
        if isFirst {
            workDescrip.isHidden = false
        }else{
            workDescrip.isHidden = true
        }
        upLoad.setTitle("上传作业", for: .normal)

        CountDown.isHidden = true
        
        CountDown.snp.updateConstraints { (make) in
            make.height.equalTo(0)
        }
        
        if images.count == 1 {
            
            image2.image = images[0]
            image1.isHidden = true
            image2.isHidden = false
            image3.isHidden = false
            
        }else if images.count == 2 {
            image1.isHidden = true
            
            image2.image = images[0]
            image3.image = images[1]
            image2.isHidden = false
            image3.isHidden = false
            
        }else{
            image2.isHidden = true
            image3.isHidden = true
        }
        
        if images.count > 0 {
            upLoad.backgroundColor = kMainColor()
            upLoad.isEnabled = true
        }else{
            upLoad.backgroundColor = kGaryColor(num: 206)
            upLoad.isEnabled = false
        }
        
    }
    
    
    func upLoadImagesForWorkBook(images:Array<UIImage>) {
        
        CountDown.isHidden = true
        upLoad.setTitle("上传作业", for: .normal)

        CountDown.snp.updateConstraints { (make) in
            make.height.equalTo(0)
        }
        
        if images.count == 1 {
            
            image2.image = images[0]
            image1.isHidden = true
            image2.isHidden = false
            image3.isHidden = false

        }else if images.count == 2 {
            image1.isHidden = true

            image2.image = images[0]
            image3.image = images[1]
            image2.isHidden = false
            image3.isHidden = false

        }else{
            image2.isHidden = true
            image3.isHidden = true
        }

        if images.count > 0 {
            upLoad.backgroundColor = kMainColor()
            upLoad.isEnabled = true
        }else{
            upLoad.backgroundColor = kGaryColor(num: 206)
            upLoad.isEnabled = false
        }
        
    }
    
    
    func upLoadImagesForResubmit(images:Array<UIImage>,timeStr:String) {

        workDescrip.isHidden = true
        
        workDescrip.snp.updateConstraints { (make) in
            make.height.equalTo(0)
        }
        
        upLoad.setTitle("完成更正", for: .normal)
        
        if images.count == 1 {

            image2.image = images[0]
            image1.isHidden = true
            image2.isHidden = false
            image3.isHidden = false

        }else if images.count == 2 {
            image1.isHidden = true
            image2.image = images[0]
            image3.image = images[1]
            image2.isHidden = false
            image3.isHidden = false

        }else if images.count == 0{
            image2.isHidden = true
            image3.isHidden = true
        }
        
        if images.count > 0 {
            upLoad.backgroundColor = kMainColor()
            upLoad.isEnabled = true
        }else{
            upLoad.backgroundColor = kGaryColor(num: 206)
            upLoad.isEnabled = false
        }
        
        let date = Date.init()
        let formatter = DateFormatter()
        //日期样式
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let dataLine = formatter.date(from: timeStr)
        
        let timeGap = dataLine?.timeIntervalSince(date)
        time = NSInteger(timeGap!)
        
        if time <= 0 {
            upLoad.isEnabled = false
        }
        
        deBugPrint(item: timeGap!)
        
        kTimer.invalidate()
        kTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown(timer:)), userInfo: nil, repeats: true)
    }
    
    
    @objc func countDown(timer:Timer) {
        
        time = time - 1

        let minutes = String(time/60)+"分"
        let seconds = String(time%60)+"秒"
        
        
        if time == 0 || time < 0{
            
            upLoad.backgroundColor = kGaryColor(num: 206)
            upLoad.isEnabled = false
            kTimer.invalidate()
            setToast(str: "对不起，你已超时")
            CountDown.text = "你已超时! "
            CountDown.textColor = kSetRGBColor(r: 255, g: 94, b: 0)
        }else{
            CountDown.text = "截止倒计时 " + minutes + seconds
        }
    }
    
    
    @IBAction func addImageAction(_ sender: UIButton) {
        deBugPrint(item: sender.tag)
        
//        if image3.isEnabled {
//            if chooseImagesAction != nil {
//                chooseImagesAction!("")
//            }
//        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
