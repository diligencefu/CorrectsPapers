//
//  CheckWorkCell.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/16.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift


class CheckWorkCell: UITableViewCell {

    @IBOutlet weak var no_check: UILabel!
    
    @IBOutlet weak var complain: UIButton!
    @IBOutlet weak var resubmit: UIButton!
    
    
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var scoreImage: UIImageView!
    
    
    @IBOutlet weak var correctTime: UILabel!
    
    @IBOutlet weak var workDescrip: UILabel!
    
    
    @IBOutlet weak var workImage1: UIImageView!
    @IBOutlet weak var workImage2: UIImageView!
    
    @IBOutlet weak var teachermark: UILabel!
    
    @IBOutlet weak var remark: UITextView!
    
    
    @IBOutlet weak var label1: UILabel!
    
    
    @IBOutlet weak var doneMark: UILabel!
    
    var complainAction:(()->())?  //声明闭包
    var resubmitAction:(()->())?  //声明闭包
    
    var theModel = BookDetailModel()
    var theModel1 = NotWorkDetailModel()
    var whereCome = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()

        complain.layer.cornerRadius = 5
        complain.clipsToBounds = true
        complain.layer.borderColor = kMainColor().cgColor
        complain.layer.borderWidth = 1
        
        resubmit.layer.cornerRadius = 5
        resubmit.clipsToBounds = true

        remark.layer.cornerRadius = 2
        remark.clipsToBounds = true

        resubmit.setBackgroundImage(getNavigationIMG(64, fromColor: kSetRGBColor(r: 0, g: 200, b: 255), toColor: kSetRGBColor(r: 0, g: 160, b: 255)), for: .normal)
        workImage1.contentMode = .scaleAspectFill
        workImage2.contentMode = .scaleAspectFill
        
        let tapGes1 = UITapGestureRecognizer.init(target: self, action: #selector(viewTheBigImage(sender:)))
        tapGes1.numberOfTouchesRequired = 1
        let tapGes2 = UITapGestureRecognizer.init(target: self, action: #selector(viewTheBigImage(sender:)))
        tapGes1.numberOfTouchesRequired = 1
        workImage1.addGestureRecognizer(tapGes1)
        workImage2.addGestureRecognizer(tapGes2)        

    }
    
    
//    未批改
    func checkWorkCellSetValues1(model:BookDetailModel) {
        theModel = model
        label1.isHidden = true
        teachermark.isHidden = true
        remark.isHidden = true
        doneMark.isHidden = true
        score.isHidden = true
        scoreImage.isHidden = true
        
        workDescrip.text = model.result
        correctTime.text = model.correcting_time
        
        workImage1.snp.updateConstraints { (make) in
            make.bottom.equalToSuperview().offset(-6.5)
        }
        
        if model.correcting_states == "2" {
            if model.photo != nil {
                workImage1.kf.setImage(with:  URL(string:model.photo[0])!, placeholder: #imageLiteral(resourceName: "class_default"), options: nil, progressBlock: nil, completionHandler: nil)
                if model.photo.count==2 {
                    workImage2.kf.setImage(with:  URL(string:model.photo[1])!, placeholder: #imageLiteral(resourceName: "class_default"), options: nil, progressBlock: nil, completionHandler: nil)
                }
            }

        }else if model.correcting_states == "5" {
            if model.photo != nil {
                workImage1.kf.setImage(with:  URL(string:model.corrected_error_photo[0])!, placeholder: #imageLiteral(resourceName: "class_default"), options: nil, progressBlock: nil, completionHandler: nil)
                if model.photo.count==2 {
                    workImage2.kf.setImage(with:  URL(string:model.corrected_error_photo[1])!, placeholder: #imageLiteral(resourceName: "class_default"), options: nil, progressBlock: nil, completionHandler: nil)
                }
            }
        }
        resubmit.isHidden = true
        complain.isHidden = true
    }
    
//    退回
    func checkWorkCellSetValues2(model:BookDetailModel) {
        theModel = model
        label1.isHidden = true
        teachermark.isHidden = true
        remark.isHidden = true
        doneMark.isHidden = true
        score.isHidden = true
        scoreImage.isHidden = true
        
        workDescrip.text = model.result
        correctTime.text = model.create_date

        no_check.text = "退回-照片模糊"
        no_check.textColor = kSetRGBColor(r: 255, g: 78, b: 78)
        if model.correcting_states == "3" {
            if model.photo != nil {
                workImage1.kf.setImage(with:  URL(string:model.photo[0])!, placeholder: #imageLiteral(resourceName: "class_default"), options: nil, progressBlock: nil, completionHandler: nil)
                if model.photo.count==2 {
                    workImage2.kf.setImage(with:  URL(string:model.photo[1])!, placeholder: #imageLiteral(resourceName: "class_default"), options: nil, progressBlock: nil, completionHandler: nil)
                }
            }
            
        }else if model.correcting_states == "6" {
            if model.photo != nil {
                workImage1.kf.setImage(with:  URL(string:model.corrected_error_photo[0])!, placeholder: #imageLiteral(resourceName: "class_default"), options: nil, progressBlock: nil, completionHandler: nil)
                if model.photo.count==2 {
                    workImage2.kf.setImage(with:  URL(string:model.corrected_error_photo[1])!, placeholder: #imageLiteral(resourceName: "class_default"), options: nil, progressBlock: nil, completionHandler: nil)
                }
            }
        }

        workImage1.snp.updateConstraints { (make) in
            make.bottom.equalToSuperview().offset(-6.5)
        }
    }

//    批改，等待改正
    func checkWorkCellSetValues3(model:BookDetailModel) {
        theModel = model
        remark.text = "状态3：已批改后显示等待更正错题如果成绩为满分则不出现更正错题页面等待更等待更等待更等待更等待更等待更等待更等待更等待更"
        resubmit.snp.updateConstraints { (make) in
            make.width.equalTo(0)
        }
        no_check.snp.updateConstraints { (make) in
            make.width.equalTo(0)
        }

        workDescrip.text = model.result
        correctTime.text = model.create_date

        teachermark.text = model.teacher_name
        remark.text = model.comment
        
        if model.scores == "1" {
            scoreImage.image = #imageLiteral(resourceName: "yixing_icon_pressed")
        }else if model.scores == "2" {
            scoreImage.image = #imageLiteral(resourceName: "erxing_icon_pressed")
        }else if model.scores == "3" {
            scoreImage.image = #imageLiteral(resourceName: "sanxing_icon_pressed")
        }else if model.scores == "4" {
            scoreImage.image = #imageLiteral(resourceName: "sixing_icon_pressed")
        }else if model.scores == "5"{
            scoreImage.image = #imageLiteral(resourceName: "wuxing_icon_pressed")
        }

        if model.photo != nil {
            workImage1.kf.setImage(with:  URL(string:model.photo[0])!, placeholder: #imageLiteral(resourceName: "class_default"), options: nil, progressBlock: nil, completionHandler: nil)
            if model.photo.count==2 {
                workImage2.kf.setImage(with:  URL(string:model.photo[1])!, placeholder: #imageLiteral(resourceName: "class_default"), options: nil, progressBlock: nil, completionHandler: nil)
            }
        }

        no_check.isHidden = true
        resubmit.isHidden = true
        doneMark.isHidden = true
    }

//    都完成
    func checkWorkCellSetValues4(model:BookDetailModel) {
        theModel = model
        remark.text = "状态3：已批改后显示等待更正错题如果成绩为满分则不出现更正错题页面等待更等待更等待更等待更等待更等待更等待更等待更等待更"
        complain.isHidden = true
        no_check.isHidden = true
        resubmit.isHidden = true
        doneMark.isHidden = true
        no_check.snp.updateConstraints { (make) in
            make.width.equalTo(0)
        }
        if model.photo != nil {
            workImage1.kf.setImage(with:  URL(string:model.corrected_error_photo[0])!, placeholder: #imageLiteral(resourceName: "class_default"), options: nil, progressBlock: nil, completionHandler: nil)
            if model.photo.count==2 {
                workImage2.kf.setImage(with:  URL(string:model.corrected_error_photo[1])!, placeholder: #imageLiteral(resourceName: "class_default"), options: nil, progressBlock: nil, completionHandler: nil)
            }
        }
        
        if model.scores_next == "1" {
            scoreImage.image = #imageLiteral(resourceName: "yixing_icon_pressed")
        }else if model.scores == "2" {
            scoreImage.image = #imageLiteral(resourceName: "erxing_icon_pressed")
        }else if model.scores == "3" {
            scoreImage.image = #imageLiteral(resourceName: "sanxing_icon_pressed")
        }else if model.scores == "4" {
            scoreImage.image = #imageLiteral(resourceName: "sixing_icon_pressed")
        }else if model.scores == "5"{
            scoreImage.image = #imageLiteral(resourceName: "wuxing_icon_pressed")
        }

    }
    
    
    
    // MARK:   非练习册
    
    //    未批改
    func checkWorkCellSetValues1NotWork(model:NotWorkDetailModel) {
        theModel1 = model
        whereCome = 1
        label1.isHidden = true
        teachermark.isHidden = true
        remark.isHidden = true
        doneMark.isHidden = true
        score.isHidden = true
        scoreImage.isHidden = true
        
        workDescrip.text = model.non_exercise_name
        correctTime.text = model.create_date
        
        workImage1.snp.updateConstraints { (make) in
            make.bottom.equalToSuperview().offset(-6.5)
        }
        
        if model.correct_states == "2" {
            if model.pre_photos != nil {
                workImage1.kf.setImage(with:  URL(string:model.pre_photos[0])!, placeholder: #imageLiteral(resourceName: "class_default"), options: nil, progressBlock: nil, completionHandler: nil)
                if model.pre_photos.count==2 {
                    workImage2.kf.setImage(with:  URL(string:model.pre_photos[1])!, placeholder: #imageLiteral(resourceName: "class_default"), options: nil, progressBlock: nil, completionHandler: nil)
                }
            }
            
        }else if model.correct_states == "5" {
            if model.corrected_photos != nil {
                workImage1.kf.setImage(with:  URL(string:model.corrected_photos[0])!, placeholder: #imageLiteral(resourceName: "class_default"), options: nil, progressBlock: nil, completionHandler: nil)
                if model.corrected_photos.count==2 {
                    workImage2.kf.setImage(with:  URL(string:model.corrected_photos[1])!, placeholder: #imageLiteral(resourceName: "class_default"), options: nil, progressBlock: nil, completionHandler: nil)
                }
            }
        }
        resubmit.isHidden = true
        complain.isHidden = true
    }
    
    //    退回
    func checkWorkCellSetValues2NotWork(model:NotWorkDetailModel) {
        theModel1 = model
        whereCome = 1
        label1.isHidden = true
        teachermark.isHidden = true
        remark.isHidden = true
        doneMark.isHidden = true
        score.isHidden = true
        scoreImage.isHidden = true
        
        workDescrip.text = model.non_exercise_name
        correctTime.text = model.create_date
        
        no_check.textColor = kSetRGBColor(r: 255, g: 78, b: 78)
        if model.correct_states == "3" {
            no_check.text = "退回" + model.reason

            if model.pre_photos != nil {
                workImage1.kf.setImage(with:  URL(string:model.pre_photos[0])!, placeholder: #imageLiteral(resourceName: "class_default"), options: nil, progressBlock: nil, completionHandler: nil)
                if model.pre_photos.count==2 {
                    workImage2.kf.setImage(with:  URL(string:model.pre_photos[1])!, placeholder: #imageLiteral(resourceName: "class_default"), options: nil, progressBlock: nil, completionHandler: nil)
                }
            }
            
        }else if model.correct_states == "6" {
            no_check.text = "错题退回" + model.reason
            if model.corrected_photos != nil {
                workImage1.kf.setImage(with:  URL(string:model.corrected_photos[0])!, placeholder: #imageLiteral(resourceName: "class_default"), options: nil, progressBlock: nil, completionHandler: nil)
                if model.corrected_photos.count==2 {
                    workImage2.kf.setImage(with:  URL(string:model.corrected_photos[1])!, placeholder: #imageLiteral(resourceName: "class_default"), options: nil, progressBlock: nil, completionHandler: nil)
                }
            }
        }
        
        workImage1.snp.updateConstraints { (make) in
            make.bottom.equalToSuperview().offset(-6.5)
        }
    }
    
    
    //    批改，等待改正
    func checkWorkCellSetValues3NotWork(model:NotWorkDetailModel) {
        theModel1 = model
        whereCome = 1
        resubmit.snp.updateConstraints { (make) in
            make.width.equalTo(0)
        }
        no_check.snp.updateConstraints { (make) in
            make.width.equalTo(0)
        }
        
        workDescrip.text = model.non_exercise_name
        correctTime.text = model.create_date
        
        teachermark.text = model.teacher_name
        remark.text = "老师评语：" + model.pre_comment
        
        if model.pre_score == "1" {
            scoreImage.image = #imageLiteral(resourceName: "yixing_icon_pressed")
        }else if model.pre_score == "2" {
            scoreImage.image = #imageLiteral(resourceName: "erxing_icon_pressed")
        }else if model.pre_score == "3" {
            scoreImage.image = #imageLiteral(resourceName: "sanxing_icon_pressed")
        }else if model.pre_score == "4" {
            scoreImage.image = #imageLiteral(resourceName: "sixing_icon_pressed")
        }else if model.pre_score == "5"{
            scoreImage.image = #imageLiteral(resourceName: "wuxing_icon_pressed")
        }
        
        if model.pre_photos != nil {
            workImage1.kf.setImage(with:  URL(string:model.pre_photos[0])!, placeholder: #imageLiteral(resourceName: "UserHead_128_default"), options: nil, progressBlock: nil, completionHandler: nil)
            if model.pre_photos.count==2 {
                workImage2.kf.setImage(with:  URL(string:model.pre_photos[1])!, placeholder: #imageLiteral(resourceName: "UserHead_128_default"), options: nil, progressBlock: nil, completionHandler: nil)
            }
        }
        
        no_check.isHidden = true
        resubmit.isHidden = true
        doneMark.isHidden = true
    }
    
    //    都完成
    func checkWorkCellSetValues4NotWork(model:NotWorkDetailModel) {
        theModel1 = model
        whereCome = 1
        remark.text = "老师评语：" + model.upd_comment
        complain.isHidden = true
        no_check.isHidden = true
        resubmit.isHidden = true
        doneMark.isHidden = true
        no_check.snp.updateConstraints { (make) in
            make.width.equalTo(0)
        }
        if model.corrected_photos != nil {
            workImage1.kf.setImage(with:  URL(string:model.corrected_photos[0])!, placeholder: #imageLiteral(resourceName: "UserHead_128_default"), options: nil, progressBlock: nil, completionHandler: nil)
            if model.corrected_photos.count==2 {
                workImage2.kf.setImage(with:  URL(string:model.corrected_photos[1])!, placeholder: #imageLiteral(resourceName: "UserHead_128_default"), options: nil, progressBlock: nil, completionHandler: nil)
            }
        }
        
        if model.upd_score == "1" {
            scoreImage.image = #imageLiteral(resourceName: "yixing_icon_pressed")
        }else if model.upd_score == "2" {
            scoreImage.image = #imageLiteral(resourceName: "erxing_icon_pressed")
        }else if model.upd_score == "3" {
            scoreImage.image = #imageLiteral(resourceName: "sanxing_icon_pressed")
        }else if model.upd_score == "4" {
            scoreImage.image = #imageLiteral(resourceName: "sixing_icon_pressed")
        }else if model.upd_score == "5"{
            scoreImage.image = #imageLiteral(resourceName: "wuxing_icon_pressed")
        }
        
    }
    
    
    @IBAction func complainAction(_ sender: UIButton) {
        
        if complainAction != nil {
            complainAction!()
        }
                
    }
    
    @IBAction func resubmitAction(_ sender: UIButton) {        
        if resubmitAction != nil {
            resubmitAction!()
        }        
    }
    
    
    @objc func viewTheBigImage(sender: UITapGestureRecognizer) {
        
        if (sender.view as! UIImageView).image == nil {
            return
        }
        
        if whereCome == 0 {
            var images = [KSPhotoItem]()
            
            if theModel.correcting_states == nil {
                return
            }
            if Int(theModel.correcting_states)! > 4 {
                
                let watchIMGItem = KSPhotoItem.init(sourceView: workImage1, image: workImage1.image)
                images.append(watchIMGItem!)
                if theModel.corrected_error_photo.count == 2 {
                    let watchIMGItem = KSPhotoItem.init(sourceView: workImage2, image: workImage2.image)
                    images.append(watchIMGItem!)
                }
            }else{
                
                let watchIMGItem = KSPhotoItem.init(sourceView: workImage1, image: workImage1.image)
                images.append(watchIMGItem!)
                if theModel.photo.count == 2 {
                    let watchIMGItem = KSPhotoItem.init(sourceView: workImage2, image: workImage2.image)
                    images.append(watchIMGItem!)
                }
            }
            
            let watchIMGView = KSPhotoBrowser.init(photoItems: images,
                                                   selectedIndex:UInt((sender.view?.tag)!-221))
            watchIMGView?.dismissalStyle = .scale
            watchIMGView?.backgroundStyle = .blurPhoto
            watchIMGView?.loadingStyle = .indeterminate
            watchIMGView?.pageindicatorStyle = .text
            watchIMGView?.bounces = false
            watchIMGView?.show(from: viewController()!)

        }else{
            var images = [KSPhotoItem]()
            
            if theModel1.correct_states == nil {
                return
            }
            if Int(theModel1.correct_states)! > 4 {
                
                let watchIMGItem = KSPhotoItem.init(sourceView: workImage1, image: workImage1.image)
                images.append(watchIMGItem!)
                if theModel1.corrected_photos.count == 2 {
                    let watchIMGItem = KSPhotoItem.init(sourceView: workImage2, image: workImage2.image)
                    images.append(watchIMGItem!)
                }
            }else{
                
                let watchIMGItem = KSPhotoItem.init(sourceView: workImage1, image: workImage1.image)
                images.append(watchIMGItem!)
                if theModel1.pre_photos.count == 2 {
                    let watchIMGItem = KSPhotoItem.init(sourceView: workImage2, image: workImage2.image)
                    images.append(watchIMGItem!)
                }
            }
            
            let watchIMGView = KSPhotoBrowser.init(photoItems: images,
                                                   selectedIndex:UInt((sender.view?.tag)!-221))
            watchIMGView?.dismissalStyle = .scale
            watchIMGView?.backgroundStyle = .blurPhoto
            watchIMGView?.loadingStyle = .indeterminate
            watchIMGView?.pageindicatorStyle = .text
            watchIMGView?.bounces = false
            watchIMGView?.show(from: viewController()!)

        }
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
