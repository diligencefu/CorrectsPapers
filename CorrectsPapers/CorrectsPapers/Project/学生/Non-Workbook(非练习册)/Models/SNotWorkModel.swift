//
//  SNotWorkModel.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/22.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyJSON

class SNotWorkModel: NSObject {
    ///练习册名字
    var non_exercise_name : String!
    ///练习册封面照
    var pre_photos : String!
    ///年级id
    var classes_id : String!
    ///科目id
    var subject_id : String!
    ///非练习册状态
    var correct_states : String!
    ///批改老师
    var teacher_name : String!
    ///批改方式：1，好友批改；2，学币批改
    var correct_way : String!
    ///悬赏学币数量
    var rewards : String!
    ///总页码数）
    var sumPage : String!
    ///id）
    var non_exercise_id : String!
    ///退回原因
    var reason : String!
    ///创建时间
    var create_date : String!
    
    
    class func setValueForSNotWorkModel(json: JSON) -> SNotWorkModel {
        
        let model = SNotWorkModel()
        model.non_exercise_name = json["non_exercise_name"].stringValue
        model.pre_photos = json["pre_photos"].stringValue
        model.classes_id = json["classes_id"].stringValue
        model.subject_id = json["subject_id"].stringValue
        model.teacher_name = json["teacher_name"].stringValue
        model.correct_states = json["correct_states"].stringValue
        model.correct_way = json["correct_way"].stringValue
        model.rewards = json["rewards"].stringValue
        model.sumPage = json["sumPage"].stringValue
        model.non_exercise_id = json["non_exercise_id"].stringValue
        model.reason = json["reason"].stringValue
        model.create_date = json["create_date"].stringValue
        return model
    }

}
