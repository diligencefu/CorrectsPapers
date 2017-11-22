//
//  TeacherInfoCell4.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/26.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class TeacherInfoCell4: UITableViewCell {

    
    @IBOutlet weak var infoTitle: UILabel!
    
    
    @IBOutlet weak var infoImage: UIImageView!
    
    var chooseImagesAction:((Bool)->())?  //声明闭包

    override func awakeFromNib() {
        super.awakeFromNib()
        let singleTap1 = UITapGestureRecognizer.init(target: self, action: #selector(viewTheBigImage(ges:)))
        singleTap1.numberOfTapsRequired = 1
        infoImage.addGestureRecognizer(singleTap1)

    }

    @objc func viewTheBigImage(ges:UITapGestureRecognizer) {
        
        if chooseImagesAction != nil {
            chooseImagesAction!(true)
        }
    }
    
    func TeacherInfoCell4SetImage(image:UIImage) {

        if image.size != CGSize.zero {
            infoImage.image = image
        }
        
    }


    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
