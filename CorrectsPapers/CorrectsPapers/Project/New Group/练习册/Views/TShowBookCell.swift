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
    
    var addWorkBlock:(()->())?  //声明闭包

    override func awakeFromNib() {
        super.awakeFromNib()
        addBtn.setBackgroundImage(getNavigationIMG(27, fromColor: kSetRGBColor(r: 0, g: 200, b: 255), toColor: kSetRGBColor(r: 0, g: 162, b: 255)), for: .normal)
        addBtn.layer.cornerRadius = 5
        addBtn.clipsToBounds = true
        
    }
    func TShowBookCellSetValue(model:WorkBookModel) {
        
        gradeMark.layer.borderColor = kGaryColor(num: 111).cgColor
        gradeMark.setTitleColor(kGaryColor(num: 111), for: .normal)
        
        proMark.layer.borderColor = kSetRGBColor(r: 255, g: 102, b: 116).cgColor
        proMark.setTitleColor(kSetRGBColor(r: 255, g: 102, b: 116), for: .normal)

        gradeMark.layer.borderWidth = 1
        gradeMark.layer.cornerRadius = 9
        gradeMark.clipsToBounds = true
        
        proMark.clipsToBounds = true
        proMark.layer.cornerRadius = 9
        proMark.layer.borderWidth = 1
        
        gradeMark.snp.updateConstraints { (make) in
            make.width.equalTo(getLabWidth(labelStr: model.grade!, font: kFont24, height: 18) + 20)
        }
        
        proMark.snp.updateConstraints { (make) in
            make.width.equalTo(getLabWidth(labelStr: model.subject_name, font: kFont24, height: 18) + 20)
        }
        
        
        gradeMark.setTitle(model.grade, for: .normal)
        
        
        
        studentCount.text = model.count! + "人"
        
        proMark.setTitle(model.subject_name, for: .normal)
        
        bookTitle.text = model.work_book_name
        
        termDate.text = model.semester
        
        bookImage.kf.setImage(with:  URL(string:model.cover_photo)!, placeholder: #imageLiteral(resourceName: "photos_image_default"), options: nil, progressBlock: nil, completionHandler: nil)
        
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
    
    
    @IBAction func addWorkAction(_ sender: UIButton) {
        
        if addWorkBlock != nil {
            addWorkBlock!()
        }
        

    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
