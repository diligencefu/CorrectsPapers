//
//  TNotGoodWorkCell1.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/18.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class TNotGoodWorkCell1: UITableViewCell {

    
    @IBOutlet weak var studentIcon: UIImageView!
    
    @IBOutlet weak var studentName: UILabel!
    @IBOutlet weak var studentID: UILabel!
    
    @IBOutlet weak var recordTime: UILabel!
    
    
    @IBOutlet weak var workDescription: UILabel!
    
    @IBOutlet weak var workImages: UIView!
    
    @IBOutlet weak var workState: UILabel!
    var theCount = 1
    
    var images = [KSPhotoItem]()
    var editArr = [UIImage]()

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    func TNotGoodWorkCell1SetValuesForFristCorrectedUndone(model:TShowClassWorksModel) {
        editArr.removeAll()

        _ = workImages.subviews.map {
            $0.removeFromSuperview()
        }
        
        let kSpace = CGFloat(7)
        var kWidth = CGFloat()
        
        studentIcon.kf.setImage(with:  URL(string:model.user_photo)!, placeholder: #imageLiteral(resourceName: "class_default"), options: nil, progressBlock: nil, completionHandler: nil)
        studentID.text = "学号 " + model.student_num
        studentName.text = model.user_name
        
        recordTime.text = model.create_date
        
        workState.text = kGetStateFromString(str: model.type)
        workState.textColor = kGetColorFromString(str:workState.text!)

        
//        kWidth = (workImages.frame.size.width-kSpace*2)/4
        kWidth = (kSCREEN_WIDTH-16-15-15-kSpace*3)/4

        let kHeight = CGFloat(176*kSCREEN_SCALE)
        let lines = 4
        
        //MARK: 根据图片的数量进行排列
        
        var showImages = [String]()
        
        if model.type == "2" {
            showImages = model.photo
        }else{
            showImages = model.photo_next
        }
        
        theCount = showImages.count

        for index in 0..<showImages.count{
            let row =  CGFloat(index%lines)
            
            let imageV = UIImageView.init(frame: CGRect(x:(kWidth + kSpace) * row, y:(kSpace+kHeight)*CGFloat(index/lines), width: kWidth, height: kHeight))
            
            imageV.kf.setImage(with: URL(string:showImages[index])!, placeholder: #imageLiteral(resourceName: "class_default"), options: nil, progressBlock: nil, completionHandler: {(image, error, type, url) in
                self.editArr.append(imageV.image!)
            })

            imageV.contentMode = .scaleAspectFill
            imageV.clipsToBounds = true
            
            imageV.isUserInteractionEnabled = true
            let singleTap = UITapGestureRecognizer.init(target: self, action: #selector(viewTheBigImage(ges:)))
            singleTap.numberOfTapsRequired = 1
            imageV.addGestureRecognizer(singleTap)
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
