//
//  ApplyCell.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/17.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class ApplyCell: UITableViewCell {

    @IBOutlet weak var userIcon: UIImageView!
    
    @IBOutlet weak var userInfo: UILabel!
    
    @IBOutlet weak var userLabel: UILabel!
    
    @IBOutlet weak var refuse: UIButton!
    @IBOutlet weak var agree: UIButton!
    
    
    @IBOutlet weak var userName: UILabel!
    
    var checkApplyBlock:((Bool)->())?  //声明闭包

    override func awakeFromNib() {
        super.awakeFromNib()

        refuse.layer.cornerRadius = 10*kSCREEN_SCALE
        refuse.clipsToBounds = true
        refuse.layer.borderColor = kSetRGBColor(r: 255, g: 55, b: 55).cgColor
        refuse.layer.borderWidth = 1
        
        
        agree.layer.cornerRadius = 10*kSCREEN_SCALE
        agree.clipsToBounds = true
        agree.setBackgroundImage(getNavigationIMG(27, fromColor: kSetRGBColor(r: 0, g: 200, b: 255), toColor: kSetRGBColor(r: 0, g: 162, b: 255)), for: .normal)
    }
    
    
    func setValuesForApplyCell(model:ApplyModel) {
        
        userIcon.kf.setImage(with:  URL(string:model.user_photo), placeholder: #imageLiteral(resourceName: "UserHead_64_default"), options: nil, progressBlock: nil, completionHandler: nil)
        if model.user_type == "1" {
            userInfo.text = model.user_fit_class + " " + model.user_area + " 学号 "+model.user_num
//            userInfo.text = model.user_area+" 学号 "+model.user_num

        }else{
//            userInfo.text = model.user_area+" 学号 "+model.user_num
            userInfo.text = model.user_fit_class + " " + model.user_area + " 学号 "+model.user_num

        }
        
        userLabel.text = model.user_name
        userName.text = model.user_name
    }
    
    
    
    @IBAction func certainAction(_ sender: UIButton) {
        if checkApplyBlock != nil {
            checkApplyBlock!(true)
        }
    }
    
    @IBAction func refuseAction(_ sender: UIButton) {
        if checkApplyBlock != nil {
            checkApplyBlock!(false)
        }
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
