//
//  TeacherInfoCell.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/26.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class TeacherInfoCell1: UITableViewCell {

    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var subLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
        
    
    func TeacherInfoCellForSection2(title:String,subStr:String) {
        
        subLabel.isHidden = true
        titleLabel.text = title
        textField.placeholder = subStr
    }
    
    
    func TeacherInfoCellForNormal(title:String,subStr:String) {
        
        textField.isHidden = true
        subLabel.isHidden = false
        titleLabel.text = title
        subLabel.text = subStr
    }

    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }
    
}
