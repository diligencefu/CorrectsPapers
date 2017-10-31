//
//  MyBookCell.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/17.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class MyBookCell: UITableViewCell {

    
    @IBOutlet weak var bookImage: UIImageView!
    
    @IBOutlet weak var bookDescription: UILabel!
    
    @IBOutlet weak var objName: UIButton!
    @IBOutlet weak var classMark: UIButton!
    
    @IBOutlet weak var correctTeacher: UILabel!
    
    @IBOutlet weak var bookState: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func MyBookCellSetValue(index:NSInteger) {
        
        classMark.layer.borderColor = kGaryColor(num: 111).cgColor
        classMark.setTitleColor(kGaryColor(num: 111), for: .normal)
        classMark.layer.borderWidth = 1
        classMark.layer.cornerRadius = 9
        classMark.clipsToBounds = true
        
        objName.clipsToBounds = true
        objName.layer.cornerRadius = 9
        objName.layer.borderWidth = 1
        
        classMark.snp.updateConstraints { (make) in
            make.width.equalTo(getLabWidth(labelStr: "六年级下册", font: kFont24, height: 18) + 20)
        }
        
        objName.snp.updateConstraints { (make) in
            make.width.equalTo(getLabWidth(labelStr: "语文", font: kFont24, height: 18) + 20)
        }
        
        if index%4 > 2 {
            objName.layer.borderColor = kSetRGBColor(r: 102, g: 200, b: 205).cgColor
            objName.setTitleColor(kSetRGBColor(r: 102, g: 200, b: 205), for: .normal)
        }else if index%4 > 1 {
            objName.layer.borderColor = kSetRGBColor(r: 205, g: 112, b: 106).cgColor
            objName.setTitleColor(kSetRGBColor(r: 205, g: 112, b: 106), for: .normal)
        }else if index%4 > 0 {
            objName.layer.borderColor = kSetRGBColor(r: 255, g: 174, b: 102).cgColor
            objName.setTitleColor(kSetRGBColor(r: 255, g: 174, b: 102), for: .normal)
        }else if index%4 == 0 {
            objName.layer.borderColor = kSetRGBColor(r: 87, g: 138, b: 242).cgColor
            objName.setTitleColor(kSetRGBColor(r: 87, g: 138, b: 242), for: .normal)
        }
        
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
