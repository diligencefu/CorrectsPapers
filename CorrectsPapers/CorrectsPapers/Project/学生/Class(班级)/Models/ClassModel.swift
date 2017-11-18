//
//  ClassModel.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/16.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyJSON

class ClassModel: NSObject {
    ///班级id
    var classes_id : String!
    ///班级图像
    var class_photo : String!
    ///（班级名称
    var class_name : String!
    ///规定交作业时间
    var work_times : String!
    ///老师名字
    var user_name : String!
    ///班级人数
    var countStudent : String!
    ///最新一期期交作业人数
    var countWorkBookBy : String!
    ///找到多少班级数
    var counts : String!
    ///是否是班主任
    var is_head_teacher : String!

    class func setValueForClassModel(json: JSON) -> ClassModel {
        
        let model = ClassModel()
        model.classes_id = json["classes_id"].stringValue
        model.class_photo = json["class_photo"].stringValue
        model.class_name = json["class_name"].stringValue
        model.work_times = json["work_times"].stringValue
        model.user_name = json["user_name"].stringValue
        model.countStudent = json["countStudent"].stringValue
        model.countWorkBookBy = json["countWorkBookBy"].stringValue
        model.counts = json["counts"].stringValue
        model.is_head_teacher = json["is_head_teacher"].stringValue
        return model
    }

}
