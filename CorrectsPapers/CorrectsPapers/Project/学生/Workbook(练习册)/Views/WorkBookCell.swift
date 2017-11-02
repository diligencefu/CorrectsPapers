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
    
    var addWorkBookBlock:((String)->())?  //声明闭包

    override func awakeFromNib() {
        super.awakeFromNib()

        addBook.layer.cornerRadius = 5
        addBook.clipsToBounds = true
        btnBGImage.layer.cornerRadius = 5
        btnBGImage.clipsToBounds = true
        btnBGImage.image = getNavigationIMG(27, fromColor: kSetRGBColor(r: 0, g: 200, b: 255), toColor: kSetRGBColor(r: 0, g: 162, b: 255))
    }
    
    
    func workBookCellSetValue(model:WorkBookModel) {
        
        classMark.layer.borderColor = kGaryColor(num: 176).cgColor
        classMark.setTitleColor(kGaryColor(num: 176), for: .normal)
        classMark.layer.borderWidth = 1
        classMark.layer.cornerRadius = 9
        classMark.clipsToBounds = true
        
        proName.clipsToBounds = true
        proName.layer.cornerRadius = 9
        proName.layer.borderWidth = 1

        classMark.snp.updateConstraints { (make) in
            make.width.equalTo(getLabWidth(labelStr: model.class_name, font: kFont24, height: 18) + 20)
        }
        classMark.setTitle(model.class_name, for: .normal)
        proName.snp.updateConstraints { (make) in
            make.width.equalTo(getLabWidth(labelStr: model.subject_name, font: kFont24, height: 18) + 20)
        }
        proName.setTitle(model.subject_name, for: .normal)

        bookTitle.text = model.work_book_name
        
        bookImage.kf.setImage(with:  URL(string:model.cover_photo)!, placeholder: #imageLiteral(resourceName: "photos_image_default"), options: nil, progressBlock: nil, completionHandler: nil)
        
        if model.subject_name == "生物" {
            proName.layer.borderColor = kSetRGBColor(r: 102, g: 200, b: 205).cgColor
            proName.setTitleColor(kSetRGBColor(r: 102, g: 200, b: 205), for: .normal)
        }else if model.subject_name == "化学" {
            proName.layer.borderColor = kSetRGBColor(r: 205, g: 112, b: 106).cgColor
            proName.setTitleColor(kSetRGBColor(r: 205, g: 112, b: 106), for: .normal)
        }else if model.subject_name == "英语" {
            proName.layer.borderColor = kSetRGBColor(r: 255, g: 174, b: 102).cgColor
            proName.setTitleColor(kSetRGBColor(r: 255, g: 174, b: 102), for: .normal)
        }else if model.subject_name == "政治" {
            proName.layer.borderColor = kSetRGBColor(r: 87, g: 138, b: 242).cgColor
            proName.setTitleColor(kSetRGBColor(r: 87, g: 138, b: 242), for: .normal)
        }else if model.subject_name == "物理" {
            proName.layer.borderColor = kSetRGBColor(r: 87, g: 138, b: 242).cgColor
            proName.setTitleColor(kSetRGBColor(r: 87, g: 138, b: 242), for: .normal)
        }
        
    }
    
    
    @IBAction func addBookAction(_ sender: UIButton) {
        if addWorkBookBlock != nil {
            addWorkBookBlock!("")
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
