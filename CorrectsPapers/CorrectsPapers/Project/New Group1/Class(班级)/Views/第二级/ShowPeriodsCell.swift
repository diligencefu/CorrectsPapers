//
//  ShowPeriodsCell.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/6.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class ShowPeriodsCell: UITableViewCell {

    @IBOutlet weak var periodsLabel: UILabel!
    
    @IBOutlet weak var periodsContent: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    
    
    func  setValueForShowPeriodsCell(model:TPeriodsModel) {
        
        periodsLabel.text = "第"+model.orders+"课时"
        periodsContent.text = model.name
    }

    
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }
    
}
