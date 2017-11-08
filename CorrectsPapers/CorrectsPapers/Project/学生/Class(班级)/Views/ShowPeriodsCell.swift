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

    
    
    func  setValueForShowPeriodsCell(index:NSInteger) {
        
        periodsLabel.text = "\(index)课时"
        
    }

    
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }
    
}
