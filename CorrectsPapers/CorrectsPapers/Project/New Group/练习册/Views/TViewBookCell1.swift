//
//  TViewBookCell1.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/13.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class TViewBookCell1: UITableViewCell {

    @IBOutlet weak var userIcon: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userNum: UILabel!
    
    @IBOutlet weak var workState: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var bookTitle: UILabel!
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!    
    
    
    var testImages = ["https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1507452668172&di=b56ef9d62498e704c0fa0e0b2c4d8dd5&imgtype=0&src=http%3A%2F%2Fimgphoto.gmw.cn%2Fattachement%2Fjpg%2Fsite2%2F20160714%2Fd02788d8df1018f171ec38.jpg","https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=998893491,2679530940&fm=27&gp=0.jpg"]
    
    var theModel1 = TShowStuWorksModel()
    var theModel2 = TNotWorkDetailModel()
    
    var whereCome = 0

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

            if Int(theModel1.correcting_states)! > 4 {
                
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

    
    //    2
    func TViewBookCellSetValuesForUndone(model:TShowStuWorksModel) {
        theModel1 = model
        whereCome = 1

        bookTitle.text = model.result

        workState.text = kGetStateFromString(str: model.correcting_states)
        workState.textColor = kGetColorFromString(str: workState.text!)
        
        image2.snp.updateConstraints({ (make) in
            make.bottom.equalToSuperview().offset(-10)
        })
        
        userIcon.kf.setImage(with:  URL(string:model.user_photo)!, placeholder: #imageLiteral(resourceName: "UserHead_128_default"), options: nil, progressBlock: nil, completionHandler: nil)
        userNum.text = "学号 " + model.user_num
        userName.text = model.user_name
        timeLabel.text = model.correcting_time
        
        if testImages.count == 1 {
            
            image1.kf.setImage(with:  URL(string:testImages[0])!, placeholder: #imageLiteral(resourceName: "photos_image_default"), options: nil, progressBlock: nil, completionHandler: nil)
            image2.isHidden = true
            image3.isHidden = true
        }else  {
            
            image1.isHidden = true
            image2.kf.setImage(with:  URL(string:testImages[0])!, placeholder: #imageLiteral(resourceName: "photos_image_default"), options: nil, progressBlock: nil, completionHandler: nil)
            image3.kf.setImage(with:  URL(string:testImages[1])!, placeholder: #imageLiteral(resourceName: "photos_image_default"), options: nil, progressBlock: nil, completionHandler: nil)
            image2.isHidden = false
            image3.isHidden = false
        }
        
    }
    
    
    
    //    2
    func TViewBookCellSetValuesForNotWorkUndone(model:TNotWorkDetailModel) {
        theModel2 = model
        whereCome = 2

        bookTitle.text = model.non_exercise_name
        
        workState.text = kGetStateFromString(str: model.state)
        workState.textColor = kGetColorFromString(str:workState.text!)

        image2.snp.updateConstraints({ (make) in
            make.bottom.equalToSuperview().offset(-10)
        })
        
        userIcon.kf.setImage(with:  URL(string:model.user_photo)!, placeholder: #imageLiteral(resourceName: "UserHead_128_default"), options: nil, progressBlock: nil, completionHandler: nil)
        userNum.text = model.user_num
        userName.text = model.student_name
        timeLabel.text = model.create_date
        
        if model.pre_photos.count == 1 {
            
            image1.kf.setImage(with:  URL(string:model.pre_photos[0])!, placeholder: #imageLiteral(resourceName: "photos_image_default"), options: nil, progressBlock: nil, completionHandler: nil)
            image2.isHidden = true
            image3.isHidden = true
        }else  {
            
            image1.isHidden = true
            image2.kf.setImage(with:  URL(string:model.pre_photos[0])!, placeholder: #imageLiteral(resourceName: "photos_image_default"), options: nil, progressBlock: nil, completionHandler: nil)
            image3.kf.setImage(with:  URL(string:model.pre_photos[1])!, placeholder: #imageLiteral(resourceName: "photos_image_default"), options: nil, progressBlock: nil, completionHandler: nil)
            image2.isHidden = false
            image3.isHidden = false
        }
        
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
