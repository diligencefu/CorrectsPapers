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
        
        if model.state == "2" {
           
            use_num.text = "-"+OCTools.init().positiveFormat(model.coin_del)+"元"
            use_num.textColor = kSetRGBColor(r: 255, g: 94, b: 0)
        }else{
            use_num.text = "+"+OCTools.init().positiveFormat(model.coin_add)+"元"
            use_num.textColor = kMainColor()
        }
        use_type.text = model.coin_thing

    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
