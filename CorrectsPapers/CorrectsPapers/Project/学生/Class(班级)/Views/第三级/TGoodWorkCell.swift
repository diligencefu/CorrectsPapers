//
//  TGoodWorkCell.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/20.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class TGoodWorkCell: UITableViewCell {

    
    @IBOutlet weak var studentIcon: UIImageView!
    
    @IBOutlet weak var studentName: UILabel!
    @IBOutlet weak var studentID: UILabel!
    
    
    
    @IBOutlet weak var gradeImage: UIImageView!
    @IBOutlet weak var recordTime: UILabel!
    
    
    @IBOutlet weak var workDescription: UILabel!
    
    @IBOutlet weak var workImages: UIView!
    @IBOutlet weak var workTeacher: UILabel!
    
    @IBOutlet weak var teacherRemark: UITextView!
    
    var theCount = 1
    
    var editArr = [UIImage]()
    var images = [KSPhotoItem]()

    override func awakeFromNib() {
        super.awakeFromNib()
        studentIcon.layer.cornerRadius = 3
        studentIcon.clipsToBounds = true
        
        teacherRemark.text = "老师评语：做的很好，加油，做的很好，加油，做的很好，加油，做的很好，加油，做的很好，加油，做的很好，加油，做的很好，加油，做的很好，加油，做的很好，加油，做的很好，加油，做的很好，加油，做的很好，加油，做的很好，加油。"
        
    }
    
    
    func TGoodWorkCellSetValueForGreade(model:LNClassWorkModel) {
        
        studentIcon.kf.setImage(with: OCTools.getEfficientAddress(model.user_photo), placeholder: #imageLiteral(resourceName: "class_default"), options: nil, progressBlock: nil, completionHandler: nil)
        studentID.text = "学号 " + model.user_num
        studentName.text = model.student_name
        
        recordTime.text = model.create_date
        
        if model.content.count == 0 {
            teacherRemark.text = "老师评语：老师对该作业很满意。"
        }else{
            teacherRemark.text = "老师评语："+model.content
        }
        
        workTeacher.text = model.teacher_name
        
       theCount = model.photo.count
        _ = workImages.subviews.map {
            $0.removeFromSuperview()
        }

        let kSpace = CGFloat(7)
        var kWidth = CGFloat()
        
        kWidth = (workImages.frame.size.width-kSpace*3)/4

        let kHeight = CGFloat(176*kSCREEN_SCALE)
        let lines = 4
        
        //MARK: 根据图片的数量进行排列
        for index in 0..<model.photo.count{
            let row =  CGFloat(index%lines)
            
            let imageV = UIImageView.init(frame: CGRect(x:(kWidth + kSpace) * row, y:(kSpace+kHeight)*CGFloat(index/lines), width: kWidth, height: kHeight))
            imageV.kf.setImage(with: URL(string:model.photo[index])!, placeholder: #imageLiteral(resourceName: "class_default"), options: nil, progressBlock: nil, completionHandler: nil)
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
        
        let count = model.photo.count
        
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
    
    
    func TGoodWorkCellSetValuesForFirstCorrectDone(model:TShowClassWorksModel) {
        editArr.removeAll()

        theCount = model.photo.count
        _ = workImages.subviews.map {
            $0.removeFromSuperview()
        }
        
        studentIcon.kf.setImage(with:  URL(string:model.user_photo)!, placeholder: #imageLiteral(resourceName: "class_default"), options: nil, progressBlock: nil, completionHandler: nil)
        studentID.text = "学号 " + model.student_num
        studentName.text = model.user_name
        
        recordTime.text = model.p_datetime
        teacherRemark.text = model.content
        workTeacher.text = model.teacher_num
        
        let kSpace = CGFloat(7)
        var kWidth = CGFloat()
        
        kWidth = (kSCREEN_WIDTH-16-15-15-kSpace*3)/4
        
        let kHeight = CGFloat(176*kSCREEN_SCALE)
        let lines = 4
        
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
        

        
        //MARK: 根据图片的数量进行排列
        for index in 0..<theCount{
            let row =  CGFloat(index%lines)
            
            let imageV = UIImageView.init(frame: CGRect(x:(kWidth + kSpace) * row, y:(kSpace+kHeight)*CGFloat(index/lines), width: kWidth, height: kHeight))
            imageV.kf.setImage(with: URL(string:model.photo[index])!, placeholder: #imageLiteral(resourceName: "class_default"), options: nil, progressBlock: nil, completionHandler: nil)
            imageV.contentMode = .scaleAspectFill
            imageV.clipsToBounds = true
            
            imageV.isUserInteractionEnabled = true
            let singleTap = UITapGestureRecognizer.init(target: self, action: #selector(viewTheBigImage(ges:)))
            singleTap.numberOfTapsRequired = 1
            imageV.addGestureRecognizer(singleTap)
            editArr.append(imageV.image!)
            imageV.tag = 170 + index
            workImages.addSubview(imageV)
//            print(imageV.frame)
        }
        
        var height = 0
        
        let line = CGFloat((theCount)%4)
        
        if line == 0 {
            height = Int(CGFloat((theCount)/4)*kHeight + kSpace*CGFloat(theCount/4)-kSpace)
        }else{
            height = Int(CGFloat((theCount)/4+1)*kHeight + kSpace*CGFloat(theCount/4))
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

        // Configure the view for the selected state
    }
    
}
