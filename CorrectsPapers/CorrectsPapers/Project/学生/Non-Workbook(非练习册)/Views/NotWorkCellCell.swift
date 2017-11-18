//
//  NotWorkCellCell.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/16.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class NotWorkCellCell: UITableViewCell {

    @IBOutlet weak var bookImage: UIImageView!
    
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var proMark: UIButton!
    @IBOutlet weak var gradeMark: UIButton!
        
    @IBOutlet weak var money: UILabel!
    @IBOutlet weak var theTeacher: UILabel!
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var bookState: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func setDataWithModel() {
        
        if "type" == "1" {
            money.text = "悬赏学币：80学币"
            theTeacher.text = ""
            label.text = ""
        }else{
            money.text = "邀请"
            theTeacher.text = "王老师"
            label.text = "来批改"
        }
        
        
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
