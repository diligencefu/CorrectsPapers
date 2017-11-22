//
//  ComplaintDetailcell.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/15.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class ComplaintDetailcell: UITableViewCell {

    @IBOutlet weak var theDate: UILabel!
    
    @IBOutlet weak var theReason: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func showTheDetail(model:TComplaintDetailModel) {
        
        theDate.text = model.create_date
        
        if model.complaints_type == "1" {
            theReason.text = "未批改"
        }else if model.complaints_type == "2" {
            theReason.text = "未按时批改"
        }else if model.complaints_type == "3" {
            theReason.text = "批改错误"
        }else if model.complaints_type == "4" {
            theReason.text = model.other
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
