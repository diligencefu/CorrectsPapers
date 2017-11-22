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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
