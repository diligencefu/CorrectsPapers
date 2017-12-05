//
//  TNotWorkDetailModel.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/14.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyJSON

class TNotWorkDetailModel: NSObject {
    ///非练习册名称
    var user_photo : String!
    ///非练习册ID
    var id : String!
    ///批改成绩
    var pre_score : String?
    ///学生名称
    var student_name : String!
    ///学生学号
    var user_num : String!
    ///批改状态
    var state : String!
    ///创建时间
    var create_date : String!
    ///批改图片
    var pre_photos : Array<String>!
    ///批改评论
    var pre_comment : String?
    ///改正图片）
    var corrected_photos : Array<String>!
    ///改正成绩
    var upd_score : String?
    ///改正评论
    var upd_comment : String?
    ///老师名称
    var teacher_name : String?
    ///作业名称
    var non_exercise_name : String!

    class func setValueForTNotWorkDetailModel(json: JSON) -> TNotWorkDetailModel {
        
        let model = TNotWorkDetailModel()
        model.user_photo = json["user_photo"].stringValue
        model.id = json["id"].stringValue
        model.student_name = json["student_name"].stringValue
        model.user_num = json["user_num"].stringValue
        model.pre_score = json["pre_score"].stringValue
        model.state = json["correct_states"].stringValue
        model.create_date = json["create_date"].stringValue
        model.pre_photos = TNotWorkDetailModel.setValueForTeacherImages(json: json["pre_photos"])
        model.pre_comment = json["pre_comment"].stringValue
        model.id = json["id"].stringValue
        model.corrected_photos = TNotWorkDetailModel.setValueForTeacherImages(json: json["corrected_photos"])
        model.upd_score = json["upd_score"].stringValue
        model.upd_comment = json["upd_comment"].stringValue
        model.teacher_name = json["teacher_name"].stringValue
        model.non_exercise_name = json["non_exercise_name"].stringValue
        return model
    }
    
    
    class func setValueForTeacherImages(json: JSON) -> Array<String> {
        let photoArr = json.arrayValue
        
        var images = [String]()
        
        for index in 0..<photoArr.count {
            let str = photoArr[index].stringValue
            images.append(str)
        }
        return images
    }


}
