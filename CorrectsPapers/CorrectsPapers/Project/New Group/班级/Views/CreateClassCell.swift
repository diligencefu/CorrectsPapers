//
//  CreateClassCell.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/21.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class CreateClassCell: UITableViewCell {

    
    @IBOutlet weak var classTitle: UILabel!
    
    @IBOutlet weak var className: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    func CreateClassCellNormal(title:String,name:String) {
        className.text = name
        classTitle.text = title
    }    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
