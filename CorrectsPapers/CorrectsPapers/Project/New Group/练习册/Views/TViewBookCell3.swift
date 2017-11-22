//
//  TViewBookCell3.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/13.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class TViewBookCell3: UITableViewCell {

    @IBOutlet weak var bookState: UILabel!
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    var theModel1 = TShowStuWorksModel()
    var theModel2 = TNotWorkDetailModel()
    
    var whereCome = 0

    var testImages = ["https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1507452668172&di=b56ef9d62498e704c0fa0e0b2c4d8dd5&imgtype=0&src=http%3A%2F%2Fimgphoto.gmw.cn%2Fattachement%2Fjpg%2Fsite2%2F20160714%2Fd02788d8df1018f171ec38.jpg","https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=998893491,2679530940&fm=27&gp=0.jpg"]

    override func awakeFromNib() {
        super.awakeFromNib()
        let tapGes1 = UITapGestureRecognizer.init(target: self, action: #selector(moveToBigImage(tap:)))
        tapGes1.numberOfTouchesRequired = 1
        image1.addGestureRecognizer(tapGes1)
        image2.addGestureRecognizer(tapGes1)
        image3.addGestureRecognizer(tapGes1)
    }
    
    @objc func moveToBigImage(tap:UITapGestureRecognizer) {
        var images = [KSPhotoItem]()
        
        if whereCome == 1 {
            if Int(theModel1.state)! > 4 {
                
                let watchIMGItem = KSPhotoItem.init(sourceView: image1, image: image1.image)
                images.append(watchIMGItem!)
                if theModel1.corrected_error_photo.count == 2 {
                    let watchIMGItem = KSPhotoItem.init(sourceView: image1, image: image1.image)
                    images.append(watchIMGItem!)
                }
            }else{
                
                let watchIMGItem = KSPhotoItem.init(sourceView: image1, image: image1.image)
                images.append(watchIMGItem!)
                if theModel1.photo.count == 2 {
                    let watchIMGItem = KSPhotoItem.init(sourceView: image1, image: image1.image)
                    images.append(watchIMGItem!)
                }
            }
            
        }else{
            if Int(theModel2.state)! > 4 {
                
                let watchIMGItem = KSPhotoItem.init(sourceView: image1, image: image1.image)
                images.append(watchIMGItem!)
                if theModel2.corrected_photos.count == 2 {
                    let watchIMGItem = KSPhotoItem.init(sourceView: image1, image: image1.image)
                    images.append(watchIMGItem!)
                }
            }else if whereCome == 2{
                
                let watchIMGItem = KSPhotoItem.init(sourceView: image1, image: image1.image)
                images.append(watchIMGItem!)
                if theModel2.pre_photos.count == 2 {
                    let watchIMGItem = KSPhotoItem.init(sourceView: image1, image: image1.image)
                    images.append(watchIMGItem!)
                }
            }
            
        }
        
        
        let watchIMGView = KSPhotoBrowser.init(photoItems: images,
                                               selectedIndex:UInt((tap.view?.tag)!-221))
        watchIMGView?.dismissalStyle = .scale
        watchIMGView?.backgroundStyle = .blurPhoto
        watchIMGView?.loadingStyle = .indeterminate
        watchIMGView?.pageindicatorStyle = .text
        watchIMGView?.bounces = false
        watchIMGView?.show(from: viewController()!)
    }

    func TViewBookCellSetValuesForUndone(model:TShowStuWorksModel) {
        theModel1 = model
        whereCome = 1
        
        bookState.isHidden = false
        bookState.text = kGetStateFromString(str: model.state)
        bookState.textColor = kGetColorFromString(str: bookState.text!)
        
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
    
    
    
    func TViewBookCellSetValuesForNorWorkUndone(model:TNotWorkDetailModel) {
        theModel2 = model
        whereCome = 2

        bookState.isHidden = false
        
        bookState.text = kGetStateFromString(str: model.state)
        
        bookState.textColor = kGetColorFromString(str:bookState.text!)

        if model.pre_photos.count == 1 {
            
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
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
