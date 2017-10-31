//
//  WorkBookCell.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/10.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class WorkBookCell: UITableViewCell {

    
    @IBOutlet weak var bookImage: UIImageView!
    
    @IBOutlet weak var proName: UIButton!
    @IBOutlet weak var classMark: UIButton!
    
    @IBOutlet weak var bookTitle: UILabel!
    
    @IBOutlet weak var addBook: UIButton!
    @IBOutlet weak var btnBGImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        addBook.layer.cornerRadius = 5
        addBook.clipsToBounds = true
        btnBGImage.layer.cornerRadius = 5
        btnBGImage.clipsToBounds = true
        btnBGImage.image = getNavigationIMG(27, fromColor: kSetRGBColor(r: 0, g: 200, b: 255), toColor: kSetRGBColor(r: 0, g: 162, b: 255))
    }
    
    func workBookCellSetValue(index:NSInteger) {
        
        classMark.layer.borderColor = kGaryColor(num: 111).cgColor
        classMark.setTitleColor(kGaryColor(num: 111), for: .normal)
        classMark.layer.borderWidth = 1
        classMark.layer.cornerRadius = 9
        classMark.clipsToBounds = true
        
        proName.clipsToBounds = true
        proName.layer.cornerRadius = 9
        proName.layer.borderWidth = 1

        classMark.snp.updateConstraints { (make) in
            make.width.equalTo(getLabWidth(labelStr: "六年级下册", font: kFont24, height: 18) + 20)
        }
        
        proName.snp.updateConstraints { (make) in
            make.width.equalTo(getLabWidth(labelStr: "语文", font: kFont24, height: 18) + 20)
        }
        
        if index%4 > 2 {
            proName.layer.borderColor = kSetRGBColor(r: 102, g: 200, b: 205).cgColor
            proName.setTitleColor(kSetRGBColor(r: 102, g: 200, b: 205), for: .normal)
        }else if index%4 > 1 {
            proName.layer.borderColor = kSetRGBColor(r: 205, g: 112, b: 106).cgColor
            proName.setTitleColor(kSetRGBColor(r: 205, g: 112, b: 106), for: .normal)
        }else if index%4 > 0 {
            proName.layer.borderColor = kSetRGBColor(r: 255, g: 174, b: 102).cgColor
            proName.setTitleColor(kSetRGBColor(r: 255, g: 174, b: 102), for: .normal)
        }else if index%4 == 0 {
            proName.layer.borderColor = kSetRGBColor(r: 87, g: 138, b: 242).cgColor
            proName.setTitleColor(kSetRGBColor(r: 87, g: 138, b: 242), for: .normal)
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
