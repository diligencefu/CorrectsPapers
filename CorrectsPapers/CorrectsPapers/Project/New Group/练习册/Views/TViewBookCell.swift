//
//  TViewBookCell.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/23.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import Kingfisher

class TViewBookCell:  UITableViewCell {
    
    var dataArr = NSMutableArray()
    
    let kHeight = kSCREEN_SCALE * 200
    
    
    @IBOutlet weak var userIcon: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var userNum: UILabel!
    
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var gradeImage: UIImageView!
        
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var bookTitle: UILabel!
    
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    
    
    @IBOutlet weak var theTeacher: UILabel!
    @IBOutlet weak var doThing: UILabel!
    
    @IBOutlet weak var remark: UITextView!
    
    var theModel1 = TShowStuWorksModel()
    var theModel2 = TNotWorkDetailModel()

    var whereCome = 0
    
    
    
    var showImages = [String]()
    
    var testImages = ["https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1507452668172&di=b56ef9d62498e704c0fa0e0b2c4d8dd5&imgtype=0&src=http%3A%2F%2Fimgphoto.gmw.cn%2Fattachement%2Fjpg%2Fsite2%2F20160714%2Fd02788d8df1018f171ec38.jpg","https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=998893491,2679530940&fm=27&gp=0.jpg"]

    override func awakeFromNib() {
        super.awakeFromNib()
        let tapGes1 = UITapGestureRecognizer.init(target: self, action: #selector(moveToBigImage(tap:)))
        tapGes1.numberOfTouchesRequired = 1
        let tapGes2 = UITapGestureRecognizer.init(target: self, action: #selector(moveToBigImage(tap:)))
        tapGes1.numberOfTouchesRequired = 1
        let tapGes3 = UITapGestureRecognizer.init(target: self, action: #selector(moveToBigImage(tap:)))
        tapGes1.numberOfTouchesRequired = 1
        
        image1.addGestureRecognizer(tapGes1)
        image2.addGestureRecognizer(tapGes2)
        image3.addGestureRecognizer(tapGes3)
        
        image1.contentMode = .scaleAspectFill
        image2.contentMode = .scaleAspectFill
        image3.contentMode = .scaleAspectFill
    }
    
    @objc func moveToBigImage(tap:UITapGestureRecognizer) {
        var images = [KSPhotoItem]()
        var index = 222
        
        if whereCome == 1 {
            if theModel1.correcting_states == nil {
                return
            }

            var state = 0
            
            if theModel1.correcting_states.count > 0 && Int(theModel1.correcting_states) != nil{
                state = Int(theModel1.correcting_states)!
            }else{
                state = Int(theModel1.state)!
            }
            
            if state > 4{

                if theModel1.corrected_error_photo.count == 1 {
                    let watchIMGItem = KSPhotoItem.init(sourceView: image1, image: image1.image)
                    images.append(watchIMGItem!)
                    index = 221
                }else{
                    let watchIMGItem2 = KSPhotoItem.init(sourceView: image2, image: image2.image)
                    let watchIMGItem3 = KSPhotoItem.init(sourceView: image3, image: image3.image)
                    images.append(watchIMGItem2!)
                    images.append(watchIMGItem3!)
                }
            }else{
                
                if theModel1.photo.count == 1 {
                    let watchIMGItem = KSPhotoItem.init(sourceView: image1, image: image1.image)
                    images.append(watchIMGItem!)
                    index = 221
                }else{
                    let watchIMGItem2 = KSPhotoItem.init(sourceView: image2, image: image2.image)
                    let watchIMGItem3 = KSPhotoItem.init(sourceView: image3, image: image3.image)
                    images.append(watchIMGItem2!)
                    images.append(watchIMGItem3!)
                }
            }
            
        }else{
            if theModel2.state == nil {
                return
            }

            if Int(theModel2.state)! > 4 {

                if theModel2.corrected_photos.count == 1 {
                    let watchIMGItem = KSPhotoItem.init(sourceView: image1, image: image1.image)
                    images.append(watchIMGItem!)
                    index = 221
                }else{
                    let watchIMGItem2 = KSPhotoItem.init(sourceView: image2, image: image2.image)
                    let watchIMGItem3 = KSPhotoItem.init(sourceView: image3, image: image3.image)
                    images.append(watchIMGItem2!)
                    images.append(watchIMGItem3!)
                }
            }else if whereCome == 2{
                
                if theModel2.pre_photos.count  == 1 {
                    let watchIMGItem = KSPhotoItem.init(sourceView: image1, image: image1.image)
                    images.append(watchIMGItem!)
                    index = 221
                }else{
                    let watchIMGItem2 = KSPhotoItem.init(sourceView: image2, image: image2.image)
                    let watchIMGItem3 = KSPhotoItem.init(sourceView: image3, image: image3.image)
                    images.append(watchIMGItem2!)
                    images.append(watchIMGItem3!)
                }
            }
        }
        
        let watchIMGView = KSPhotoBrowser.init(photoItems: images,
                                               selectedIndex:UInt((tap.view?.tag)!-index))
        watchIMGView?.dismissalStyle = .scale
        watchIMGView?.backgroundStyle = .blurPhoto
        watchIMGView?.loadingStyle = .indeterminate
        watchIMGView?.pageindicatorStyle = .text
        watchIMGView?.bounces = false
        watchIMGView?.show(from: viewController()!)
    }

    
//    4
    func TViewBookCellSetValuesForFirstCorrectDone(model:TShowStuWorksModel) {
        theModel1 = model
        whereCome = 1
        bookTitle.text = model.result

        showImages = testImages
        gradeImage.isHidden = false
        gradeLabel.isHidden = false
        doThing.isHidden = false
        theTeacher.isHidden = false
        remark.isHidden = false
        
        userIcon.kf.setImage(with:  URL(string:model.user_photo)!, placeholder: #imageLiteral(resourceName: "UserHead_128_default"), options: nil, progressBlock: nil, completionHandler: nil)
        userNum.text =  model.user_num
        userName.text = model.user_name
        timeLabel.text = model.correcting_time
        bookTitle.text = model.result
        theTeacher.text = model.teacher_name
        doThing.text = ""
        remark.text = "老师评语：" + model.comment
        
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
        
        image2.snp.updateConstraints({ (make) in
            make.bottom.equalTo(theTeacher.snp.top).offset(-5)
        })

        if model.photo.count == 1 {
            
            image1.kf.setImage(with:  URL(string:model.photo[0])!, placeholder: #imageLiteral(resourceName: "class_default"), options: nil, progressBlock: nil, completionHandler: nil)
            image2.isHidden = true
            image3.isHidden = true
        }else  {
            
            image1.isHidden = true
            image2.kf.setImage(with:  URL(string:model.photo[0])!, placeholder: #imageLiteral(resourceName: "class_default"), options: nil, progressBlock: nil, completionHandler: nil)
            image3.kf.setImage(with:  URL(string:model.photo[1])!, placeholder: #imageLiteral(resourceName: "class_default"), options: nil, progressBlock: nil, completionHandler: nil)
            image2.isHidden = false
            image3.isHidden = false
        }
    }
    
    
    //    4
    func TViewBookCellSetValuesForNotWorkFirstCorrectDone(model:TNotWorkDetailModel) {
        theModel2 = model
        whereCome = 2

        bookTitle.text = model.non_exercise_name
        
        showImages = testImages
        gradeImage.isHidden = false
        gradeLabel.isHidden = false
        doThing.isHidden = false
        theTeacher.isHidden = false
        remark.isHidden = false
        
        userIcon.kf.setImage(with:  URL(string:model.user_photo)!, placeholder: #imageLiteral(resourceName: "UserHead_128_default"), options: nil, progressBlock: nil, completionHandler: nil)
        userNum.text =  model.user_num
        userName.text = model.student_name
        bookTitle.text = model.non_exercise_name
        timeLabel.text = model.create_date
        theTeacher.text = model.teacher_name
        remark.text = "老师评语：" + model.pre_comment!
        
        if model.pre_score == "1" {
            gradeImage.image = #imageLiteral(resourceName: "yixing_icon_pressed")
        }else if model.pre_score == "2" {
            gradeImage.image = #imageLiteral(resourceName: "erxing_icon_pressed")
        }else if model.pre_score == "3" {
            gradeImage.image = #imageLiteral(resourceName: "sanxing_icon_pressed")
        }else if model.pre_score == "4" {
            gradeImage.image = #imageLiteral(resourceName: "sixing_icon_pressed")
        }else if model.pre_score == "5"{
            gradeImage.image = #imageLiteral(resourceName: "wuxing_icon_pressed")
        }

        image2.snp.updateConstraints({ (make) in
            make.bottom.equalTo(theTeacher.snp.top).offset(-5)
        })
        
        if model.pre_photos.count == 1 {
            
            image1.kf.setImage(with:  URL(string:model.pre_photos[0])!, placeholder: #imageLiteral(resourceName: "class_default"), options: nil, progressBlock: nil, completionHandler: nil)
            image2.isHidden = true
            image3.isHidden = true
        }else  {
            
            image1.isHidden = true
            image2.kf.setImage(with:  URL(string:model.pre_photos[0])!, placeholder: #imageLiteral(resourceName: "class_default"), options: nil, progressBlock: nil, completionHandler: nil)
            image3.kf.setImage(with:  URL(string:model.pre_photos[1])!, placeholder: #imageLiteral(resourceName: "class_default"), options: nil, progressBlock: nil, completionHandler: nil)
            image2.isHidden = false
            image3.isHidden = false
        }
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
