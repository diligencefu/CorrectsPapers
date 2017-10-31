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

        if chooseImagesAction != nil {
            chooseImagesAction!(true)
        }
    }
    
    
    func TeacherInfoCell3SetImages(images:[UIImage]) {
        
        if images.count == 2 {
            
            IDCardFront.image = images[0]
            IDCardBack.image = images[1]
        }else if images.count == 1 {
            
            self.IDCardFront.image = images[0]
        }

    }
    


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
