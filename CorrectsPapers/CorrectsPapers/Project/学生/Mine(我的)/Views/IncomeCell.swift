//
//  IncomeCell.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/17.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class IncomeCell: UITableViewCell {

    @IBOutlet weak var use_date: UILabel!
    
    @IBOutlet weak var use_type: UILabel!
    
    @IBOutlet weak var use_num: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    
    func setValuesForIncomeCell(model:AccountModel) {
        
        use_date.text = model.create_date
        
        if model.coin_add == "0" {
            use_num.text = "-"+model.coin_del+"元"
            use_type.text = "观看视频"
        }else{
            use_num.text = "+"+model.coin_add+"元"
            use_type.text = "充值学币"
        }
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
