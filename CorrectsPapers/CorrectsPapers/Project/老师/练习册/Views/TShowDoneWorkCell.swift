//
//  TShowDoneWorkCell.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/13.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class TShowDoneWorkCell: UITableViewCell {

    @IBOutlet weak var userIcon: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userNum: UILabel!
    
    @IBOutlet weak var fristGrade: UIImageView!
    
    @IBOutlet weak var doneGrade: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func TShowDoneWorkCellWithData(model:TShowGradeModel){
        
        userIcon.kf.setImage(with: URL(string:model.user_photo!)!, placeholder: #imageLiteral(resourceName: "UserHead_128_default"), options: nil, progressBlock: nil, completionHandler: nil)
        userName.text = model.user_name
        userNum.text = model.user_num
        
        if model.scores == "1" {
            fristGrade.image = #imageLiteral(resourceName: "yixing_icon_pressed")
        }else if model.scores == "2" {
            fristGrade.image = #imageLiteral(resourceName: "erxing_icon_pressed")
        }else if model.scores == "3" {
            fristGrade.image = #imageLiteral(resourceName: "sanxing_icon_pressed")
        }else if model.scores == "4" {
            fristGrade.image = #imageLiteral(resourceName: "sixing_icon_pressed")
        }else if model.scores == "5" {
            fristGrade.image = #imageLiteral(resourceName: "wuxing_icon_pressed")
            doneGrade.image = #imageLiteral(resourceName: "not_icon_default")
        }
        
        if model.scores_next == "1" {
            doneGrade.image = #imageLiteral(resourceName: "yixing_icon_pressed")
        }else if model.scores_next == "2" {
            doneGrade.image = #imageLiteral(resourceName: "erxing_icon_pressed")
        }else if model.scores_next == "3" {
            doneGrade.image = #imageLiteral(resourceName: "sanxing_icon_pressed")
        }else if model.scores_next == "4" {
            doneGrade.image = #imageLiteral(resourceName: "sixing_icon_pressed")
        }else if model.scores_next == "5" {
            doneGrade.image = #imageLiteral(resourceName: "wuxing_icon_pressed")
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
