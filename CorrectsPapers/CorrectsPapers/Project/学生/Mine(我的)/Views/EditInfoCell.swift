//
//  EditInfoCell.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/21.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class EditInfoCell: UITableViewCell {

    
    @IBOutlet weak var theTitle: UILabel!
    
    @IBOutlet weak var subTitle: UILabel!
    
    @IBOutlet weak var subTitle2: UILabel!
    
    @IBOutlet weak var textfield: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func EditInfoCellForFill(title:String) {
        theTitle.text = title
        subTitle.isHidden = true
        subTitle2.isHidden = true
    }
    
    func EditInfoCellForNormal(title:String,subStr:String,is1:Bool) {
        theTitle.text = title
        textfield.isHidden = true
        if is1 {
            subTitle.text = subStr
            subTitle2.isHidden = true
        }else{
            subTitle2.text = subStr
            subTitle.isHidden = true
        }
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
