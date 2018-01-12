//
//  TeacherInfoCell3.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/26.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class TeacherInfoCell3: UITableViewCell {

    
    @IBOutlet weak var infoTitle: UILabel!
    
    @IBOutlet weak var infoDescrip: UILabel!
    
    @IBOutlet weak var IDCardFront: UIImageView!
    @IBOutlet weak var IDCardBack: UIImageView!
    
    var chooseImagesAction:((Bool)->())?  //声明闭包

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        let singleTap1 = UITapGestureRecognizer.init(target: self, action: #selector(viewTheBigImage(ges:)))
        singleTap1.numberOfTapsRequired = 1
        IDCardFront.addGestureRecognizer(singleTap1)
        
        
        let singleTap2 = UITapGestureRecognizer.init(target: self, action: #selector(viewTheBigImage(ges:)))
        singleTap2.numberOfTapsRequired = 1
        IDCardBack.addGestureRecognizer(singleTap2)

        
    }
    
    @objc func viewTheBigImage(ges:UITapGestureRecognizer) {

        var isBack = false
        if ges.view?.tag == 123212 {
            isBack = true
        }
        if chooseImagesAction != nil {
            chooseImagesAction!(isBack)
        }
    }
    
    
    func TeacherInfoCell3SetImagess(frontImage: UIImage,backImage:UIImage) {
        
        IDCardFront.image = frontImage
        IDCardBack.image = backImage
    }
    


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
