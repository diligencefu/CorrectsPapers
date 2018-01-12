//
//  TeacherInfoCell.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/26.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class TeacherInfoCell1: UITableViewCell,UITextFieldDelegate {

    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var subLabel: UILabel!
    
    var titleStr = ""
    
    var endEditBlock:((String,Bool)->())?  //声明闭包

    
    override func awakeFromNib() {
        super.awakeFromNib()
        textField.delegate = self
    }
        
    
    func TeacherInfoCellForSection2(title:String,subStr:String) {
        
        subLabel.isHidden = true
        titleLabel.text = title
        titleStr = title
    }
    
    
    func TeacherInfoCellForNormal(title:String,subStr:String) {
        
        textField.isHidden = true
        subLabel.isHidden = false
        titleLabel.text = title
        subLabel.text = subStr
        titleStr = title
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if endEditBlock != nil && (textField.text?.count)!>0{
            if titleStr == "身份证号码" {
                endEditBlock!(textField.text!,false)
            }else{
                endEditBlock!(textField.text!,true)
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }
    
}
