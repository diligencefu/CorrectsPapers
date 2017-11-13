//
//  AnswerImageCell.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/10.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class AnswerImageCell: UITableViewCell {

    
    @IBOutlet weak var showImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        showImage.contentMode = .scaleAspectFit
    }

    
    func showWithImage(image:UIImage) {
        showImage.image = image
    }
    
    
    func studentViewImage(image:UIImage) {
        
        showImage.image = image
        let singleTap = UITapGestureRecognizer.init(target: self, action: #selector(viewTheBigImage(ges:)))
        singleTap.numberOfTapsRequired = 1
        showImage.addGestureRecognizer(singleTap)

    }
    
    @objc  func viewTheBigImage(ges:UITapGestureRecognizer) {
        
        var images = [KSPhotoItem]()
        
        let watchIMGItem = KSPhotoItem.init(sourceView: showImage, image: showImage.image)
        
        images.append(watchIMGItem!)
        
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
