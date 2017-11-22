//
//  ChooseImageCell.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/14.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class ChooseImageCell: UITableViewCell {

    
    @IBOutlet weak var upLoadImage1: UIImageView!
    
    @IBOutlet weak var upLoadImage2: UIImageView!
    
    var cover_photo = UIImage()
    var edition_photo = UIImage()
    
    var chooseIndex = 0
    
    
    var chooseImagesAction:((String)->())?  //声明闭包

    override func awakeFromNib() {
        super.awakeFromNib()
        
        let singleTap1 = UITapGestureRecognizer.init(target: self, action: #selector(viewTheBigImage(ges:)))
        singleTap1.numberOfTapsRequired = 1
        upLoadImage1.addGestureRecognizer(singleTap1)
        
        let singleTap2 = UITapGestureRecognizer.init(target: self, action: #selector(viewTheBigImage(ges:)))
        singleTap2.numberOfTapsRequired = 1
        upLoadImage2.addGestureRecognizer(singleTap2)
        
    }
    
    @objc func viewTheBigImage(ges:UITapGestureRecognizer) {
        
        if chooseImagesAction != nil {
            chooseImagesAction!(String((ges.view?.tag)!))
        }
        
//        if ges.view?.tag == 111 {
//            chooseIndex = 1
//        }else{
//            chooseIndex = 2
//        }
//        setupPhoto1(count: 1)
    }
    
    func ChooseImageCellSetImage(image1:UIImage,image2:UIImage) {
        
        if image1.size !=  #imageLiteral(resourceName: "Upload-photos_fengmian").size{
            upLoadImage1.image = image1
        }
        
        if image2.size !=  #imageLiteral(resourceName: "Upload-photos_yinshuabanci").size{
            upLoadImage2.image = image2
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
        
}
