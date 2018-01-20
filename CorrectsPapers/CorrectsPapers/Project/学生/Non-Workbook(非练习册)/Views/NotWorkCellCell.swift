//
//  NotWorkCellCell.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/16.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class NotWorkCellCell: UITableViewCell {

    @IBOutlet weak var bookImage: UIImageView!
    
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var proMark: UIButton!
    @IBOutlet weak var gradeMark: UIButton!
        
    @IBOutlet weak var money: UILabel!
    @IBOutlet weak var theTeacher: UILabel!
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var bookState: UILabel!

    @IBOutlet weak var crateDate: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func setDataWithModel(model:SNotWorkModel) {
    
        crateDate.setTitle(model.create_date, for: .normal)
        
        bookImage.kf.setImage(with:  URL(string:model.pre_photos)!, placeholder: #imageLiteral(resourceName: "photos_image_default"), options: nil, progressBlock: nil, completionHandler: nil)
        
        if model.correct_states == "3" || model.correct_states == "6" {
            
            var symbol = ""
            if model.reason.count > 0{
                symbol = "-"
            }
            bookState.text = kGetStateFromString(str: model.correct_states)+symbol+model.reason
        }else{
            bookState.text = kGetStateFromString(str: model.correct_states)
        }
        bookState.textColor = kGetColorFromString(str: bookState.text!)
        
        bookTitle.text = model.non_exercise_name
        
        gradeMark.layer.borderColor = kGaryColor(num: 176).cgColor
        gradeMark.setTitleColor(kGaryColor(num: 176), for: .normal)
        gradeMark.layer.borderWidth = 1
        gradeMark.layer.cornerRadius = 9
        gradeMark.clipsToBounds = true

        proMark.setTitleColor(kSetRGBColor(r: 255, g: 102, b: 116), for: .normal)
        proMark.layer.borderColor = kSetRGBColor(r: 255, g: 102, b: 116).cgColor
        proMark.clipsToBounds = true
        proMark.layer.cornerRadius = 9
        proMark.layer.borderWidth = 1

        gradeMark.snp.updateConstraints { (make) in
            make.width.equalTo(getLabWidth(labelStr: model.classes_id, font: kFont24, height: 18) + 20)
        }
        gradeMark.setTitle(model.classes_id, for: .normal)
        proMark.snp.updateConstraints { (make) in
            make.width.equalTo(getLabWidth(labelStr: model.subject_id, font: kFont24, height: 18) + 20)
        }
        proMark.setTitle(model.subject_id, for: .normal)

        if model.correct_way == "2" {
            money.text = "悬赏学币："+model.rewards + "学币"
            theTeacher.text = ""
            label.text = ""
        }else{
            money.text = "邀请"
            theTeacher.text = model.teacher_name
            label.text = "来批改"
        }
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
