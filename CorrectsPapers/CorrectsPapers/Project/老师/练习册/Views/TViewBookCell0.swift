//
//  TViewBookCell0.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/13.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class TViewBookCell0: UITableViewCell {

    @IBOutlet weak var userIcon: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var userNum: UILabel!
    
    @IBOutlet weak var bookState: UILabel!
    
    @IBOutlet weak var bookTitle: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func TViewBookCell0SetValuesForShowWork(model:TShowStuWorksModel) {
        
        bookTitle.text = model.result
        userIcon.kf.setImage(with:  URL(string:model.user_photo)!, placeholder: #imageLiteral(resourceName: "UserHead_128_default"), options: nil, progressBlock: nil, completionHandler: nil)
        userNum.text =  model.user_num
        userName.text = model.user_name
        timeLabel.text = model.correcting_time
        
        if model.state == "2" {
            
            bookState.text = "未批改"
            bookState.textColor = kSetRGBColor(r: 255, g: 153, b: 0)
        }else{
            
            bookState.text = "退回-照片模糊"
            bookState.textColor = kSetRGBColor(r: 255, g: 78, b: 78)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
