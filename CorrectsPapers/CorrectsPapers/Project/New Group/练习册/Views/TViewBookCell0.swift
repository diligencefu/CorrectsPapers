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
        
        if model.result.count>0 {
            bookTitle.text = model.result
        }else{
            bookTitle.text = "已提交作业，等待您批改！"
        }
        
        if model.user_photo.count>0 {
            userIcon.kf.setImage(with:  URL(string:model.user_photo)!, placeholder: #imageLiteral(resourceName: "UserHead_128_default"), options: nil, progressBlock: nil, completionHandler: nil)
        }
        userNum.text =  model.user_num
        userName.text = model.user_name
        timeLabel.text = model.correcting_time
        
        bookState.textColor = kSetRGBColor(r: 255, g: 153, b: 0)

        if model.correcting_states == "2" {
            
            bookState.text = "未批改"
        }else if model.correcting_states == "5"{
            
            bookState.text = "错题未批改"
        }
        
        bookState.textColor = kGetColorFromString(str:bookState.text!)
    }
    
    
    func TViewBookCell0SetValuesForShowClassWork(model:TShowClassWorksModel) {

        if model.title.count>0 {
            bookTitle.text = model.title
        }else{
            bookTitle.text = "已提交作业，等待您批改！"
        }

        userIcon.kf.setImage(with:  URL(string:model.user_photo)!, placeholder: #imageLiteral(resourceName: "UserHead_128_default"), options: nil, progressBlock: nil, completionHandler: nil)
        userNum.text =  model.student_num
        userName.text = model.user_name
        timeLabel.text = model.create_date
        
        bookState.textColor = kSetRGBColor(r: 255, g: 153, b: 0)
        
//        if model.type == "2" {
//
//            bookState.text = "未批改"
//        }else {
//
//            bookState.text = "错题未批改"
//        }
        
        bookState.text = kGetStateFromString(str: model.type)
        bookState.textColor = kGetColorFromString(str:bookState.text!)
    }
    
    

    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
