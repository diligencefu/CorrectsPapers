//
//  TBookCell.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/20.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class TShowBookCell: UITableViewCell {

    @IBOutlet weak var bookImage: UIImageView!
    
    @IBOutlet weak var bookTitle: UILabel!
    
    @IBOutlet weak var proMark: UIButton!
    
    @IBOutlet weak var gradeMark: UIButton!
    
    
    @IBOutlet weak var label1: UIButton!
    @IBOutlet weak var label2: UIButton!
    
    @IBOutlet weak var studentCount: UILabel!
    @IBOutlet weak var termDate: UILabel!
    
    @IBOutlet weak var addBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addBtn.setBackgroundImage(getNavigationIMG(27, fromColor: kSetRGBColor(r: 0, g: 200, b: 255), toColor: kSetRGBColor(r: 0, g: 162, b: 255)), for: .normal)
        addBtn.layer.cornerRadius = 5
        addBtn.clipsToBounds = true
        
    }
    func TShowBookCellSetValue(index:NSInteger) {
        
        gradeMark.layer.borderColor = kGaryColor(num: 111).cgColor
        gradeMark.setTitleColor(kGaryColor(num: 111), for: .normal)
        gradeMark.layer.borderWidth = 1
        gradeMark.layer.cornerRadius = 9
        gradeMark.clipsToBounds = true
        
        proMark.clipsToBounds = true
        proMark.layer.cornerRadius = 9
        proMark.layer.borderWidth = 1
        
        gradeMark.snp.updateConstraints { (make) in
            make.width.equalTo(getLabWidth(labelStr: "六年级下册", font: kFont24, height: 18) + 20)
        }
        
        proMark.snp.updateConstraints { (make) in
            make.width.equalTo(getLabWidth(labelStr: "语文", font: kFont24, height: 18) + 20)
        }
        
        if index%4 > 2 {
            proMark.layer.borderColor = kSetRGBColor(r: 102, g: 200, b: 205).cgColor
            proMark.setTitleColor(kSetRGBColor(r: 102, g: 200, b: 205), for: .normal)
        }else if index%4 > 1 {
            proMark.layer.borderColor = kSetRGBColor(r: 205, g: 112, b: 106).cgColor
            proMark.setTitleColor(kSetRGBColor(r: 205, g: 112, b: 106), for: .normal)
        }else if index%4 > 0 {
            proMark.layer.borderColor = kSetRGBColor(r: 255, g: 174, b: 102).cgColor
            proMark.setTitleColor(kSetRGBColor(r: 255, g: 174, b: 102), for: .normal)
        }else if index%4 == 0 {
            proMark.layer.borderColor = kSetRGBColor(r: 87, g: 138, b: 242).cgColor
            proMark.setTitleColor(kSetRGBColor(r: 87, g: 138, b: 242), for: .normal)
        }
        
    }
    
    
    func TShowBookCellForSearch(index:NSInteger) {
        
        gradeMark.layer.borderColor = kGaryColor(num: 111).cgColor
        gradeMark.setTitleColor(kGaryColor(num: 111), for: .normal)
        gradeMark.layer.borderWidth = 1
        gradeMark.layer.cornerRadius = 9
        gradeMark.clipsToBounds = true
        
        proMark.clipsToBounds = true
        proMark.layer.cornerRadius = 9
        proMark.layer.borderWidth = 1
        
        studentCount.isHidden = true
        termDate.isHidden = true
        label1.isHidden = true
        label2.isHidden = true
        
        gradeMark.snp.updateConstraints { (make) in
            make.width.equalTo(getLabWidth(labelStr: "六年级下册", font: kFont24, height: 18) + 20)
        }
        
        proMark.snp.updateConstraints { (make) in
            make.width.equalTo(getLabWidth(labelStr: "语文", font: kFont24, height: 18) + 20)
        }
        
        if index%4 > 2 {
            proMark.layer.borderColor = kSetRGBColor(r: 102, g: 200, b: 205).cgColor
            proMark.setTitleColor(kSetRGBColor(r: 102, g: 200, b: 205), for: .normal)
        }else if index%4 > 1 {
            proMark.layer.borderColor = kSetRGBColor(r: 205, g: 112, b: 106).cgColor
            proMark.setTitleColor(kSetRGBColor(r: 205, g: 112, b: 106), for: .normal)
        }else if index%4 > 0 {
            proMark.layer.borderColor = kSetRGBColor(r: 255, g: 174, b: 102).cgColor
            proMark.setTitleColor(kSetRGBColor(r: 255, g: 174, b: 102), for: .normal)
        }else if index%4 == 0 {
            proMark.layer.borderColor = kSetRGBColor(r: 87, g: 138, b: 242).cgColor
            proMark.setTitleColor(kSetRGBColor(r: 87, g: 138, b: 242), for: .normal)
        }
        
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
