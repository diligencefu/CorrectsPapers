//
//  TNotWorkInfoCell.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/15.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class TNotWorkInfoCell: UITableViewCell {

    @IBOutlet weak var theType: UILabel!
    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var theGrade: UILabel!
    @IBOutlet weak var subject: UILabel!
    
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var label1: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    
    func TNotWorkInfoCellValues(model:TNotWorkModel) {
        
        if model.correct_way == "2" {
            theType.text = "悬赏学币"
            label.text = "悬赏学币："
            label1.text = ""
            count.text = model.rewards
            count.textColor = kGaryColor(num: 101)
            theGrade.text = model.classes_name
        }else{
            theType.text = "邀请好友批改"
            label.text = "邀请"
            label1.text = "来批改"
            count.text = model.teacher_name
            count.textColor = kGetColorFromString(str: "未批改")
            theGrade.text = model.classes_name
        }

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
