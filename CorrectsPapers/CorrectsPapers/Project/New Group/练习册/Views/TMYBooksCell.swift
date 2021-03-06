//
//  TBooksCell.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/20.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class TMYBooksCell: UITableViewCell {

    
    @IBOutlet weak var bookImage: UIImageView!
    
    @IBOutlet weak var bookTitle: UILabel!
    
    @IBOutlet weak var proMark: UIButton!
    @IBOutlet weak var gradeMark: UIButton!
    
    @IBOutlet weak var submitCount: UILabel!
    @IBOutlet weak var doneCount: UILabel!
    
    @IBOutlet weak var versionMark: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func TMYBooksCellSetValue(model:WorkBookModel) {
        
        bookImage.kf.setImage(with:  URL(string:model.cover_photo)!, placeholder: #imageLiteral(resourceName: "class_default"), options: nil, progressBlock: nil, completionHandler: nil)

        gradeMark.layer.borderColor = kGaryColor(num: 111).cgColor
        gradeMark.setTitleColor(kGaryColor(num: 111), for: .normal)
        gradeMark.layer.borderWidth = 1
        gradeMark.layer.cornerRadius = 9
        gradeMark.clipsToBounds = true

        versionMark.layer.borderColor = kGaryColor(num: 111).cgColor
        versionMark.setTitleColor(kGaryColor(num: 111), for: .normal)
        versionMark.layer.borderWidth = 1
        versionMark.layer.cornerRadius = 9
        versionMark.clipsToBounds = true

        proMark.clipsToBounds = true
        proMark.layer.cornerRadius = 9
        proMark.layer.borderWidth = 1
        
        gradeMark.snp.updateConstraints { (make) in
            make.width.equalTo(getLabWidth(labelStr: model.grade!, font: kFont24, height: 18) + 20)
        }
        
        versionMark.snp.updateConstraints { (make) in
            make.width.equalTo(getLabWidth(labelStr: model.edition_id, font: kFont24, height: 18) + 20)
        }

        proMark.snp.updateConstraints { (make) in
            make.width.equalTo(getLabWidth(labelStr: model.subject_id!, font: kFont24, height: 18) + 20)
        }

        gradeMark.setTitle(model.grade, for: .normal)
        proMark.setTitle(model.subject_id, for: .normal)
        versionMark.setTitle(model.edition_id, for: .normal)
        bookTitle.text = model.work_book_name
        
        submitCount.text = model.state1
        doneCount.text = model.state2

        if model.subject_name == "生物" {
            proMark.layer.borderColor = kSetRGBColor(r: 102, g: 200, b: 205).cgColor
            proMark.setTitleColor(kSetRGBColor(r: 102, g: 200, b: 205), for: .normal)
        }else if model.subject_name == "化学" {
            proMark.layer.borderColor = kSetRGBColor(r: 205, g: 112, b: 106).cgColor
            proMark.setTitleColor(kSetRGBColor(r: 205, g: 112, b: 106), for: .normal)
        }else if model.subject_name == "英语" {
            proMark.layer.borderColor = kSetRGBColor(r: 255, g: 174, b: 102).cgColor
            proMark.setTitleColor(kSetRGBColor(r: 255, g: 174, b: 102), for: .normal)
        }else if model.subject_name == "政治" {
            proMark.layer.borderColor = kSetRGBColor(r: 87, g: 138, b: 242).cgColor
            proMark.setTitleColor(kSetRGBColor(r: 87, g: 138, b: 242), for: .normal)
        }else if model.subject_name == "物理" {
            proMark.layer.borderColor = kSetRGBColor(r: 87, g: 138, b: 242).cgColor
            proMark.setTitleColor(kSetRGBColor(r: 87, g: 138, b: 242), for: .normal)
        }
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
