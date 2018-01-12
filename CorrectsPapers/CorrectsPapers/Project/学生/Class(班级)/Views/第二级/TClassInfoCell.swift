//
//  TClassInfoCell.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/20.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class TClassInfoCell: UITableViewCell {

    @IBOutlet weak var classIcon: UIImageView!
    
    @IBOutlet weak var className: UILabel!
    @IBOutlet weak var mainTeacher: UILabel!
    
    @IBOutlet weak var tutorials: UILabel!
    @IBOutlet weak var helpTeacher: UILabel!
    
    
    @IBOutlet weak var submitType: UILabel!
    
    @IBOutlet weak var finishDate: UILabel!
    @IBOutlet weak var suvmitCount: UILabel!
    @IBOutlet weak var memCount: UILabel!
    
    @IBOutlet weak var classNum: UILabel!
    
    
    @IBOutlet weak var editBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        editBtn.setBackgroundImage(getNavigationIMG(27, fromColor: kSetRGBColor(r: 0, g: 200, b: 255), toColor: kSetRGBColor(r: 0, g: 162, b: 255)), for: .normal)
        editBtn.clipsToBounds = true
        editBtn.layer.cornerRadius = 10*kSCREEN_SCALE
    }

    
    func TClassInfoCellForStudent(model:LNClassInfoModel,isHeadTeacher:Bool) {
        
        if isHeadTeacher {
            editBtn.isHidden = false
        }else{
            editBtn.isHidden = true
        }
        
        classIcon.kf.setImage(with:  URL(string:model.class_photo)!, placeholder: #imageLiteral(resourceName: "class_default"), options: nil, progressBlock: nil, completionHandler: nil)
        className.text = model.class_name
        mainTeacher.text = model.head_teacher_name
        if model.teacher_name.count > 0 {
            tutorials.text = model.teacher_name.joined(separator: ",")
        }else{
            tutorials.text = "暂无上课老师"
        }
        if model.teacher_help.count > 0 {
            helpTeacher.text = model.teacher_help.joined(separator: ",")
        }else{
            helpTeacher.text = "暂无助教老师"
        }
        submitType.text = model.delivery_cycle
        suvmitCount.text = model.deadline
        finishDate.text = model.work_times
        memCount.text = model.Cstudent+"人"
        classNum.text = model.class_no
    }
    
    
    func TClassInfoCellForTeacher() {
        editBtn.isHidden = false
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
