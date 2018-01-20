//
//  TNotWorkModel.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/14.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyJSON

class TNotWorkModel: NSObject {
    ///非练习册名称
    var non_exercise_name : String!
    ///非练习册ID
    var id : String!
    ///科目名称
    var subject_name : String!
    ///学生名称
    var user_name : String!
    ///封面照片
    var pre_photos : String!
    ///悬赏分
    var rewards : String?
    ///批改状态
    var state : String!
    ///id
    var non_exercise_Id : String!
    ///老师id
    var user_teacherId : String!
    ///批改方式
    var correct_way : String!
    ///有没有添加过
    var isFriend : String!
    ///班级
    var classes_name : String!
    ///学生id
    var student_id : String!
    ///退回原因
    var reason : String!
    ///老师名字
    var teacher_name : String!
    ///科目
    var subject_id : String!
    ///创建时间
    var create_date : String!

    class func setValueForTNotWorkModel(json: JSON) -> TNotWorkModel {
        
        let model = TNotWorkModel()
        model.non_exercise_name = json["non_exercise_name"].stringValue
        model.id = json["non_exercise_Id"].stringValue
        model.subject_name = json["subject_name"].stringValue
        model.user_name = json["user_name"].stringValue
        model.pre_photos = json["pre_photos"].stringValue
        model.rewards = json["rewards"].stringValue
        model.state = json["correct_states"].stringValue
        model.non_exercise_Id = json["non_exercise_Id"].stringValue
        model.user_teacherId = json["user_teacherId"].stringValue
        model.correct_way = json["correct_way"].stringValue
        model.isFriend = json["isFriend"].stringValue
        model.classes_name = json["classes_name"].stringValue
        model.student_id = json["student_id"].stringValue
        model.reason = json["reason"].stringValue
        model.teacher_name = json["teacher_name"].stringValue
        model.subject_id = json["subject_id"].stringValue
        model.create_date = json["create_date"].stringValue
        return model
    }

}
