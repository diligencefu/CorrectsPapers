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
        
        classMark.layer.borderColor = kGaryColor(num: 176).cgColor
        classMark.setTitleColor(kGaryColor(num: 176), for: .normal)
        classMark.layer.borderWidth = 1
        classMark.layer.cornerRadius = 9
        classMark.clipsToBounds = true
        classMark.setTitle(model.grade, for: .normal)
        
        objName.clipsToBounds = true
        objName.layer.cornerRadius = 9
        objName.layer.borderWidth = 1
        objName.setTitle(model.subject_name, for: .normal)
        
        bookImage.kf.setImage(with:  URL(string:model.cover_photo)!, placeholder: #imageLiteral(resourceName: "photos_image_default"), options: nil, progressBlock: nil, completionHandler: nil)

        bookTitle.text = model.work_book_name
        
        if (model.teacherName != "") {
            
            correctTeacher.text = model.teacherName
        }else{
            
            correctTeacher.text = "未分配老师"
        }
        
        classMark.snp.updateConstraints { (make) in
            make.width.equalTo(getLabWidth(labelStr: model.grade!, font: kFont24, height: 18) + 20)
        }
        
        objName.snp.updateConstraints { (make) in
            make.width.equalTo(getLabWidth(labelStr: model.subject_name, font: kFont24, height: 18) + 20)
        }
        
        bookState.text = kGetStateFromString(str:model.correcting_states!)
        bookState.textColor = kGetColorFromString(str: bookState.text!)
        
        objName.setTitleColor(kSetRGBColor(r: 255, g: 102, b: 116), for: .normal)
        objName.layer.borderColor = kSetRGBColor(r: 255, g: 102, b: 116).cgColor
        objName.layer.borderWidth = 1

    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
