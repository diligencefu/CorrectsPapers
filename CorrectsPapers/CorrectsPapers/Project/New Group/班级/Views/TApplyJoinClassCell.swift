//
//  TApplyJoinClassCell.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/14.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class TApplyJoinClassCell: UITableViewCell {

    @IBOutlet weak var userIcon: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userNum: UILabel!
    
    
    @IBOutlet weak var idMark: UILabel!
    
    @IBOutlet weak var refuse: UIButton!
    @IBOutlet weak var agree: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        userIcon.layer.cornerRadius = 8*kSCREEN_SCALE
        userIcon.clipsToBounds = true
        
        refuse.layer.cornerRadius = 10*kSCREEN_SCALE
        refuse.clipsToBounds = true
        refuse.layer.borderColor = kSetRGBColor(r: 255, g: 55, b: 55).cgColor
        refuse.layer.borderWidth = 1
        
        agree.layer.cornerRadius = 10*kSCREEN_SCALE
        agree.setBackgroundImage(getNavigationIMG(27, fromColor: kSetRGBColor(r: 0, g: 200, b: 255), toColor: kSetRGBColor(r: 0, g: 162, b: 255)), for: .normal)
        agree.clipsToBounds = true
        
    }

    
    func TApplyJoinClassCellForTeacher(model:TTeacherModel) {
        
        userIcon.kf.setImage(with:  URL(string:model.teacher_photo)!, placeholder: #imageLiteral(resourceName: "photos_image_default"), options: nil, progressBlock: nil, completionHandler: nil)
        userNum.text = model.teacher_num
        userName.text = model.teacher_name
        idMark.text = "工号"
    }
    
    func TApplyJoinClassCellForStudent(model:TStudentModel) {
        userIcon.kf.setImage(with:  URL(string:model.student_photo)!, placeholder: #imageLiteral(resourceName: "photos_image_default"), options: nil, progressBlock: nil, completionHandler: nil)
        userNum.text = model.student_num
        userName.text = model.student_name
        idMark.text = "学号"
    }    
    
    @IBAction func refuseAction(_ sender: UIButton) {
        
        
    }
    
    
    @IBAction func agreeAction(_ sender: UIButton) {
        
        
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
