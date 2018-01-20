//
//  CreateClassCell2.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/21.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class CreateClassCell2: UITableViewCell {

    
    @IBOutlet weak var theTitle: UILabel!
    
    @IBOutlet weak var textField: UITextField!
    
    
    @IBOutlet weak var subTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func CreateClassCell2ShowAll(title:String,info:String,placeholder:String) {
        
        theTitle.text = title
        subTitle.text = info
        textField.placeholder = placeholder
    }
    
    
    func CreateClassCellEdit(title:String,info:String,text:String,placeholder:String) {
        
        theTitle.text = title
        subTitle.text = text
        textField.text = info
        textField.isHidden = false
        textField.placeholder = placeholder
    }
    
    
    func CreateClassCell2(title:String,member:String) {
        
        theTitle.text = title
        textField.isHidden = true
        subTitle.text = member
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
