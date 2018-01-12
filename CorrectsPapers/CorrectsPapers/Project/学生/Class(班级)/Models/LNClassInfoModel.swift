//
//  LNClassInfoModel.swift
//  CorrectsPapers
//
//  Created by RongXing on 2018/1/5.
//  Copyright © 2018年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyJSON

class LNClassInfoModel: NSObject {
    ///班级头像）
    var class_photo : String!
    ///班主任名字）
    var head_teacher_name : String!
    ///班级名字
    var class_name : String!
    ///规定交作业次数）
    var deadline : String!
    ///规定交作业周期）
    var delivery_cycle : String!
    ///规定交作业时间）
    var work_times : String!
    ///班级人数）
    var Cstudent : String!
    ///（课时数）
    var Cperiods : String!
    ///(上课老师集合)
    var teacher_name : Array<String>!
    ///助教集合
    var teacher_help : Array<String>!
    ///班级编号5位数）
    var class_no : String!

    
    
    class func setValueForLNClassInfoModel(json: JSON) -> LNClassInfoModel {
        
        let model = LNClassInfoModel()
        model.class_photo = json["class_photo"].stringValue
        model.head_teacher_name = json["head_teacher_name"].stringValue
        model.class_name = json["class_name"].stringValue
        model.deadline = json["deadline"].stringValue
        model.delivery_cycle = json["delivery_cycle"].stringValue
        model.work_times = json["work_times"].stringValue
        model.Cstudent = json["Cstudent"].stringValue
        model.Cperiods = json["Cperiods"].stringValue
//        model.teacher_class = json["teacher_class"].stringValue
        model.teacher_name = TNotWorkDetailModel.setValueForTeacherImages(json: json["teacher_name"])
        model.teacher_help = TNotWorkDetailModel.setValueForTeacherImages(json: json["teacher_help"])

//        model.teacher_help = json["teacher_help"].stringValue
        model.class_no = json["class_no"].stringValue

        return model
    }

}
