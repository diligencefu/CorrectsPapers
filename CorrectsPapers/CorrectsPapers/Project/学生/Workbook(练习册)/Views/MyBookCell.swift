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
    
    @IBOutlet weak var bookTitle: UILabel!
    
    @IBOutlet weak var objName: UIButton!
    @IBOutlet weak var classMark: UIButton!
    
    @IBOutlet weak var correctTeacher: UILabel!
    
    @IBOutlet weak var bookState: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func MyBookCellSetValue(model:WorkBookModel) {
        
        let colors = [kGaryColor(num: 149),kSetRGBColor(r: 255, g: 157, b: 47),kSetRGBColor(r: 255, g: 157, b: 47),kSetRGBColor(r: 255, g: 92, b: 95),kSetRGBColor(r: 255, g: 78, b: 78),kSetRGBColor(r: 113, g: 207, b: 46)]
        
        classMark.layer.borderColor = kGaryColor(num: 176).cgColor
        classMark.setTitleColor(kGaryColor(num: 176), for: .normal)
        classMark.layer.borderWidth = 1
        classMark.layer.cornerRadius = 9
        classMark.clipsToBounds = true
        classMark.setTitle(model.class_name, for: .normal)
        
        objName.clipsToBounds = true
        objName.layer.cornerRadius = 9
        objName.layer.borderWidth = 1
        objName.setTitle(model.subject_name, for: .normal)
        
        bookImage.kf.setImage(with:  URL(string:model.cover_photo)!, placeholder: #imageLiteral(resourceName: "photos_image_default"), options: nil, progressBlock: nil, completionHandler: nil)

        bookTitle.text = model.work_book_name
        
        
        if (model.correct_teacher != "") {
            
            correctTeacher.text = model.correct_teacher
        }else{
            correctTeacher.text = "Michael"
        }
        
        classMark.snp.updateConstraints { (make) in
            make.width.equalTo(getLabWidth(labelStr: model.class_name, font: kFont24, height: 18) + 20)
        }
        
        objName.snp.updateConstraints { (make) in
            make.width.equalTo(getLabWidth(labelStr: model.subject_name, font: kFont24, height: 18) + 20)
        }
        
        var state = ""
        if model.correct_state == 0 {
            state = "未分配老师"
            correctTeacher.text = "暂无"
        }else if model.correct_state == 1 {
            state = "未批改"
        }else if model.correct_state == 2 {
            state = "正在批改"
        }else if model.correct_state == 3 {
            state = "退回-照片模糊改"
        }else if model.correct_state == 4 {
            state = "已批改"
        }
        
        
        bookState.text = state
        bookState.textColor = colors[model.correct_state!]
        
        if model.subject_name == "数学" {
            objName.layer.borderColor = kSetRGBColor(r: 102, g: 200, b: 205).cgColor
            objName.setTitleColor(kSetRGBColor(r: 102, g: 200, b: 205), for: .normal)
        }else if model.subject_name == "语文" {
            objName.layer.borderColor = kSetRGBColor(r: 205, g: 112, b: 106).cgColor
            objName.setTitleColor(kSetRGBColor(r: 205, g: 112, b: 106), for: .normal)
        }else if model.subject_name == "英语" {
            objName.layer.borderColor = kSetRGBColor(r: 255, g: 174, b: 102).cgColor
            objName.setTitleColor(kSetRGBColor(r: 255, g: 174, b: 102), for: .normal)
        }else if model.subject_name == "政治" {
            objName.layer.borderColor = kSetRGBColor(r: 87, g: 138, b: 242).cgColor
            objName.setTitleColor(kSetRGBColor(r: 87, g: 138, b: 242), for: .normal)
        }else if model.subject_name == "物理" {
            objName.layer.borderColor = kSetRGBColor(r: 87, g: 138, b: 242).cgColor
            objName.setTitleColor(kSetRGBColor(r: 87, g: 138, b: 242), for: .normal)
        }else if model.subject_name == "生物" {
            objName.layer.borderColor = kSetRGBColor(r: 130, g: 20, b: 242).cgColor
            objName.setTitleColor(kSetRGBColor(r: 130, g: 20, b: 242), for: .normal)
        }else if model.subject_name == "化学" {
            objName.layer.borderColor = kSetRGBColor(r: 246, g: 100, b: 168).cgColor
            objName.setTitleColor(kSetRGBColor(r: 246, g: 100, b: 168), for: .normal)
        }
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
