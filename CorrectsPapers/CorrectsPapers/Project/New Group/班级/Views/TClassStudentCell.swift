//
//  TClassStudentCell.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/14.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class TClassStudentCell: UITableViewCell {
    
    @IBOutlet weak var userIcon: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userNum: UILabel!
    
    @IBOutlet weak var idMark: UILabel!    

    @IBOutlet weak var handWork: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        userIcon.layer.cornerRadius = 8*kSCREEN_SCALE
        userIcon.clipsToBounds = true

    }
    
    
    func showHeadTeacherCell(model:THeadTeacherModel) {
        handWork.isHidden = true
        if model.head_teacher_photo != "" {
            userIcon.kf.setImage(with:  URL(string:model.head_teacher_photo)!, placeholder: #imageLiteral(resourceName: "class_default"), options: nil, progressBlock: nil, completionHandler: nil)
        }
        userNum.text = model.head_teacher_num
        idMark.text = "工号"
        userName.text = model.head_teacher_name
    }
    
    func showStudentsCell(model:TStudentModel) {
        
        if model.ispay == "no" {
            handWork.isHidden = true
        }else if model.ispay == "yes" {
            handWork.isHidden = true
        }
        handWork.isHidden = true

        userIcon.kf.setImage(with:  OCTools.getEfficientAddress(model.student_photo), placeholder: #imageLiteral(resourceName: "class_default"), options: nil, progressBlock: nil, completionHandler: nil)
        userNum.text = model.student_num
        idMark.text = "学号"
        userName.text = model.student_name
    }

    func showOtherTeachersCell(model:TTeacherModel) {
        handWork.isHidden = false
        userIcon.kf.setImage(with:  URL(string:model.teacher_photo)!, placeholder: #imageLiteral(resourceName: "class_default"), options: nil, progressBlock: nil, completionHandler: nil)
        userNum.text = model.teacher_num
        idMark.text = "工号"
        userName.text = model.teacher_name
        
        if model.type == "1" {
            handWork.text = "上课老师"
        }else if model.type == "2" {
            handWork.text = "助教老师"
        }else{
            handWork.text = ""
        }
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
