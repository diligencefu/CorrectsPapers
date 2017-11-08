//
//  ShowImageCell.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/20.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class ShowImageCell: UICollectionViewCell {

    
    @IBOutlet weak var showImage: UIImageView!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    var deleteAction:((String)->())?  //声明闭包

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        showImage.isUserInteractionEnabled = true
        self.clipsToBounds = false
        
        deleteButton.layer.cornerRadius = 10
        deleteButton.clipsToBounds = true
        showImage.contentMode = .scaleAspectFit
    }

    func setImages(image:UIImage,isEditting:Bool) {
        showImage.image = image
        deleteButton.isHidden = !isEditting
        
        let longpressGesutre = UILongPressGestureRecognizer(target: self, action:#selector(showDeleteButton(ges:)))
        //长按时间为1秒
        longpressGesutre.minimumPressDuration = 1
        //允许15秒运动
        longpressGesutre.allowableMovement = 15
        //所需触摸1次
        longpressGesutre.numberOfTouchesRequired = 1
        showImage.addGestureRecognizer(longpressGesutre)

    }
    
    func showImages(image:String) {
        showImage.kf.setImage(with:  URL(string:image)!, placeholder: #imageLiteral(resourceName: "workBook"), options: nil, progressBlock: nil, completionHandler: nil)

    }
    
    func noImage() {
        showImage.image = #imageLiteral(resourceName: "Upload_btn_default")
        deleteButton.isHidden = true
    }
    
    @objc func showDeleteButton(ges:UILongPressGestureRecognizer) {
        if showImage.image != #imageLiteral(resourceName: "Upload_btn_default") {
            deleteButton.isHidden = false
        }
    }

    @IBAction func deleteAction(_ sender: UIButton) {
        
        if deleteAction != nil {
            deleteAction!("")
        }
        
    }
    
}
