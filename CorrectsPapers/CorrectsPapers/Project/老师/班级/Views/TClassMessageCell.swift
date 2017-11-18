//
//  TClassMessageCell.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/15.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class TClassMessageCell: UITableViewCell {

    
    @IBOutlet weak var nitofiContent: UITextView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nitofiContent.clipsToBounds = true
        nitofiContent.layer.cornerRadius = 10*kSCREEN_SCALE
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
