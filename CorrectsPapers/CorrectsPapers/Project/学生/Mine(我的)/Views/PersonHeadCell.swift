//
//  PersonHeadCell.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/16.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import SwiftyUserDefaults

class PersonHeadCell: UITableViewCell {

    
    @IBOutlet weak var headIcon: UIImageView!
    
    @IBOutlet weak var backImage: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var grade: UILabel!
    
    @IBOutlet weak var area: UILabel!
    
    @IBOutlet weak var user_id: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        headIcon.layer.cornerRadius = 5
        headIcon.clipsToBounds = true
        
        backImage.image = getNavigationIMG(27, fromColor: kSetRGBColor(r: 0, g: 200, b: 255), toColor: kSetRGBColor(r: 0, g: 162, b: 255))
    }
   
    
    func setValues(model:PersonalModel) {
        if model.user_photo != nil {
            headIcon.kf.setImage(with:  URL(string:model.user_photo)!, placeholder: #imageLiteral(resourceName: "UserHead_64_default"), options: nil, progressBlock: nil, completionHandler: nil)

        }

        userName.text = model.user_name
        grade.text = model.user_fit_class
        user_id.text = model.user_area

        if model.user_num != nil {
            if Defaults[userIdentity] == kTeacher {
                
                area.text = "工号" + model.user_num
            }else{
                area.text = "学号" + model.user_num
            }
        }
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
