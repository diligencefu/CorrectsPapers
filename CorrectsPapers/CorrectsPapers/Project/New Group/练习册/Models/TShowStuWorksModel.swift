//
//  TShowStuWorksModel.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/11.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyJSON

class TShowStuWorksModel: NSObject {

    ///学生姓名
    var user_name : String!
    ///学号
    var user_num : String!
    ///学生照片
    var user_photo : String!
    ///首次批改成绩
    var scores : String!
    ///批改时间
    var correcting_time : String!
    ///批改的评论
    var comment : String!
    ///批改的图片
    var photo : Array<String>!
    ///改正的图片
    var corrected_error_photo :  Array<String>!
    ///改正的成绩
    var scores_next : String!
//    改正后的评论
    var comment_next : String!
    //批改状态
    var correcting_states : String!
    //批改状态
    var state : String!
    //老师名称
    var teacher_name : String!
    //作业描述
    var result : String!
    //作业id
    var book_details_id : String!
    //学生id
    var student_id : String!

    
    class func setValueForTShowStuWorksModel(json: JSON) -> TShowStuWorksModel {
        
        let model = TShowStuWorksModel()
        model.user_name = json["user_name"].stringValue
        model.user_num = json["user_num"].stringValue
        model.user_photo = json["user_photo"].stringValue
        model.scores = json["scores"].stringValue
        model.correcting_time = json["correcting_time"].stringValue
        model.comment = json["comment"].stringValue
        model.photo = TNotWorkDetailModel.setValueForTeacherImages(json: json["photo"])
        
        model.corrected_error_photo = TNotWorkDetailModel.setValueForTeacherImages(json: json["corrected_error_photo"])
        
        model.scores_next = json["scores_next"].stringValue
        model.comment_next = json["comment_next"].stringValue
        model.correcting_states = json["state"].stringValue
        model.teacher_name = json["teacher_name"].stringValue
        model.result = json["result"].stringValue
        model.book_details_id = json["book_details_id"].stringValue
        model.student_id = json["student_id"].stringValue
        model.state = json["correcting_states"].stringValue
        return model
    }

    
}
