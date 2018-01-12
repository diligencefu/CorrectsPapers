//
//  ShowWorkStateCell.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/7.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class ShowWorkStateCell: UITableViewCell {

    
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var gradeImage: UIImageView!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var doneMark: UILabel!
    
    @IBOutlet weak var conplainBtn: UIButton!
    
    @IBOutlet weak var workDescription: UILabel!
    
    @IBOutlet weak var workImages: UIView!
    
    @IBOutlet weak var workTeacher: UILabel!
    @IBOutlet weak var doLabel: UILabel!
    
    @IBOutlet weak var teacherRemark: UITextView!
    
    var theCount = 1
    
    var typeArr = NSMutableArray()
    var images = [KSPhotoItem]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        conplainBtn.layer.cornerRadius = 10*kSCREEN_SCALE
        conplainBtn.clipsToBounds = true
        conplainBtn.layer.borderColor = kSetRGBColor(r: 0, g: 183, b: 255).cgColor
        conplainBtn.layer.borderWidth = 0.5
        
        teacherRemark.text = "老师评语：做的很好，加油，做的很好，加油，做的很好，加油，做的很好，加油，做的很好，加油，做的很好，加油，做的很好，加油，做的很好，加油，做的很好，加油，做的很好，加油，做的很好，加油，做的很好，加油，做的很好，加油。"
        
        teacherRemark.layer.cornerRadius = 2
        teacherRemark.clipsToBounds = true
        
        workImages.layer.cornerRadius = 2
        workImages.clipsToBounds = true
    }
    
    
//    未批改
    func TGoodWorkCellSetValueForUndone(model:TClassWorkModel) {
        
        gradeLabel.isHidden = true
        gradeImage.isHidden = true
        doneMark.isHidden = true
        conplainBtn.isHidden = true
        workTeacher.isHidden = true
        doLabel.isHidden = true
        teacherRemark.isHidden = true

        timeLabel.text = model.create_date
        workDescription.text = model.title
        
        let count = model.photo.count
        
        theCount = count
        _ = workImages.subviews.map {
            $0.removeFromSuperview()
        }
        
        let kSpace = CGFloat(7)
        var kWidth = CGFloat()
        
        kWidth = (kSCREEN_WIDTH-30-kSpace*3)/4
        
        let kHeight = CGFloat(176*kSCREEN_SCALE)
        let lines = 4
        
        //MARK: 根据图片的数量进行排列
        for index in 0..<count{
            let row =  CGFloat(index%lines)
            
            let imageV = UIImageView.init(frame: CGRect(x:(kWidth + kSpace) * row, y:(kSpace+kHeight)*CGFloat(index/lines), width: kWidth, height: kHeight))
            imageV.kf.setImage(with: OCTools.getEfficientAddress(model.photo[index]), placeholder: #imageLiteral(resourceName: "class_default"), options: nil, progressBlock: nil, completionHandler: nil)
            imageV.contentMode = .scaleAspectFill
            imageV.clipsToBounds = true
            
            imageV.isUserInteractionEnabled = true
            let singleTap = UITapGestureRecognizer.init(target: self, action: #selector(viewTheBigImage(ges:)))
            singleTap.numberOfTapsRequired = 1
            imageV.addGestureRecognizer(singleTap)
            
            imageV.tag = 170 + index
            workImages.addSubview(imageV)
            deBugPrint(item: imageV.frame)
        }
        
        var height = 0
        
        let line = CGFloat((count)%4)
        
        if line == 0 {
            height = Int(CGFloat((count)/4)*kHeight + kSpace*CGFloat(count/4)-kSpace)
        }else{
            height = Int(CGFloat((count)/4+1)*kHeight + kSpace*CGFloat(count/4))
        }
        
        workImages.snp.updateConstraints { (ls) in
            ls.height.equalTo(height)
        }
    }
    
    
//    批改待修正
    func TGoodWorkCellSetValueForWaitCorrect(model:TClassWorkModel) {
        
        if model.scores == "1" {
            gradeImage.image = #imageLiteral(resourceName: "yixing_icon_pressed")
        }else if model.scores == "2" {
            gradeImage.image = #imageLiteral(resourceName: "erxing_icon_pressed")
        }else if model.scores == "3" {
            gradeImage.image = #imageLiteral(resourceName: "sanxing_icon_pressed")
        }else if model.scores == "4" {
            gradeImage.image = #imageLiteral(resourceName: "sixing_icon_pressed")
        }else if model.scores == "5"{
            gradeImage.image = #imageLiteral(resourceName: "wuxing_icon_pressed")
        }

        timeLabel.text = model.create_date
        workTeacher.text = model.teacher_name
        workDescription.text = model.title

        if model.content.count > 0 {
            teacherRemark.text = "老师评语："+model.content!
        }else{
            teacherRemark.text = "老师评语：老师觉得你的作业很棒！"
        }
        
        gradeLabel.isHidden = false
        gradeImage.isHidden = false
        doneMark.isHidden = true
        conplainBtn.isHidden = false
        workTeacher.isHidden = false
        doLabel.isHidden = false
        teacherRemark.isHidden = false
        
        let count = model.photo.count
        
        theCount = model.photo.count
        
        _ = workImages.subviews.map {
            $0.removeFromSuperview()
        }
        
        let kSpace = CGFloat(7)
        var kWidth = CGFloat()
        
        kWidth = (kSCREEN_WIDTH-30-kSpace*3)/4

        let kHeight = CGFloat(176*kSCREEN_SCALE)
        let lines = 4
        
        //MARK: 根据图片的数量进行排列
        for index in 0..<count{
            let row =  CGFloat(index%lines)
            
            let imageV = UIImageView.init(frame: CGRect(x:(kWidth + kSpace) * row, y:(kSpace+kHeight)*CGFloat(index/lines), width: kWidth, height: kHeight))
            imageV.kf.setImage(with: OCTools.getEfficientAddress(model.photo[index]), placeholder: #imageLiteral(resourceName: "class_default"), options: nil, progressBlock: nil, completionHandler: nil)
            imageV.contentMode = .scaleAspectFill
            imageV.clipsToBounds = true
            
            imageV.isUserInteractionEnabled = true
            let singleTap = UITapGestureRecognizer.init(target: self, action: #selector(viewTheBigImage(ges:)))
            singleTap.numberOfTapsRequired = 1
            imageV.addGestureRecognizer(singleTap)
            
            imageV.tag = 170 + index
            workImages.addSubview(imageV)
            deBugPrint(item: imageV.frame)
        }
        
        var height = 0
        
        let line = CGFloat((count)%4)
        
        if line == 0 {
            height = Int(CGFloat((count)/4)*kHeight + kSpace*CGFloat(count/4)-kSpace)
        }else{
            height = Int(CGFloat((count)/4+1)*kHeight + kSpace*CGFloat(count/4))
        }
        
        workImages.snp.updateConstraints { (ls) in
            ls.height.equalTo(height)
        }
    }
    
    
//    全部完成结束
    func TGoodWorkCellSetValueForFinish(model: TClassWorkModel) {

        conplainBtn.snp.updateConstraints { (make) in
            make.width.equalTo(0)
        }
        
        if model.scores_next == "1" {
            gradeImage.image = #imageLiteral(resourceName: "yixing_icon_pressed")
        }else if model.scores_next == "2" {
            gradeImage.image = #imageLiteral(resourceName: "erxing_icon_pressed")
        }else if model.scores_next == "3" {
            gradeImage.image = #imageLiteral(resourceName: "sanxing_icon_pressed")
        }else if model.scores_next == "4" {
            gradeImage.image = #imageLiteral(resourceName: "sixing_icon_pressed")
        }else if model.scores_next == "5"{
            gradeImage.image = #imageLiteral(resourceName: "wuxing_icon_pressed")
        }
        
        timeLabel.text = model.create_date
        workTeacher.text = model.teacher_next_name
        workDescription.text = model.title
        
        if model.content_next.count > 0 {
            teacherRemark.text = "老师评语："+model.content_next!
        }else{
            teacherRemark.text = "老师评语：老师觉得你的作业很棒！"
        }

        gradeLabel.isHidden = false
        gradeImage.isHidden = false
        doneMark.isHidden = false
        conplainBtn.isHidden = true
        workTeacher.isHidden = false
        doLabel.isHidden = false
        teacherRemark.isHidden = false
        
        let count = model.photo_next.count
        
        theCount = model.photo_next.count
        
        _ = workImages.subviews.map {
            $0.removeFromSuperview()
        }
        
        let kSpace = CGFloat(7)
        var kWidth = CGFloat()
        
        kWidth = (kSCREEN_WIDTH-30-kSpace*3)/4

        let kHeight = CGFloat(176*kSCREEN_SCALE)
        let lines = 4
        
        //MARK: 根据图片的数量进行排列
        for index in 0..<count{
            let row =  CGFloat(index%lines)
            
            let imageV = UIImageView.init(frame: CGRect(x:(kWidth + kSpace) * row, y:(kSpace+kHeight)*CGFloat(index/lines), width: kWidth, height: kHeight))
            imageV.kf.setImage(with: OCTools.getEfficientAddress(model.photo_next[index]), placeholder: #imageLiteral(resourceName: "class_default"), options: nil, progressBlock: nil, completionHandler: nil)
            imageV.contentMode = .scaleAspectFill
            imageV.clipsToBounds = true
            
            imageV.isUserInteractionEnabled = true
            let singleTap = UITapGestureRecognizer.init(target: self, action: #selector(viewTheBigImage(ges:)))
            singleTap.numberOfTapsRequired = 1
            imageV.addGestureRecognizer(singleTap)
            
            imageV.tag = 170 + index
            workImages.addSubview(imageV)
            deBugPrint(item: imageV.frame)
        }
        
        var height = 0
        
        let line = CGFloat((count)%4)
        
        if line == 0 {
            height = Int(CGFloat((count)/4)*kHeight + kSpace*CGFloat(count/4)-kSpace)
        }else{
            height = Int(CGFloat((count)/4+1)*kHeight + kSpace*CGFloat(count/4))
        }
        
        workImages.snp.updateConstraints { (ls) in
            ls.height.equalTo(height)
        }
    }
    
    
    
    @objc  func viewTheBigImage(ges:UITapGestureRecognizer) {
        
        var images = [KSPhotoItem]()
        
        for index in 0..<theCount {
            let theView = workImages.viewWithTag(index+170) as! UIImageView
            let watchIMGItem = KSPhotoItem.init(sourceView: theView, image: theView.image)
            images.append(watchIMGItem!)
        }
        
        let watchIMGView = KSPhotoBrowser.init(photoItems: images,
                                               selectedIndex:UInt((ges.view?.tag)!-170))
        watchIMGView?.dismissalStyle = .scale
        watchIMGView?.backgroundStyle = .blurPhoto
        watchIMGView?.loadingStyle = .indeterminate
        watchIMGView?.pageindicatorStyle = .text
        watchIMGView?.bounces = false
        watchIMGView?.show(from: viewController()!)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}
