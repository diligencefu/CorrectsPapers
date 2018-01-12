//
//  TClassWorkModel.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/17.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyJSON

class TClassWorkModel: NSObject {
    ///班级作业id
    var class_book_id : String!
    ///班级作业标题
    var title : String!
    ///首次上传作业图
    var photo : Array<String>!
    ///再次上传作业图）
    var photo_next : Array<String>!
    ///班级作业状态
    var type : String!
    ///首次评语
    var content : String!
    ///再次批改评语
    var content_next : String!
    ///首次得分
    var scores : String!
    ///再次得分
    var scores_next : String?
    ///批改时间
    var p_datetime : String!
    ///学生id
    var student_id : String!
    ///学生名字
    var user_name : String!
    ///学生头像）
    var user_photo : String!
    ///学生学号
    var student_num : String!
    ///批改老师工号
    var teacher_num : String!
    ///批改老师mingzi
    var teacher_name : String!
    ///再次批改老师工号
    var teacher_next_num : String?
    ///二次老师批改姓名
    var teacher_next_name : String?
    ///退回原因）
    var reason : String?
    ///(不满5分，显示的倒计时，满五分显示"")
    var time : String?
    ///创建时间）
    var create_date : String!

    class func setValueForTClassWorkModel(json: JSON) -> TClassWorkModel {
        
        let model = TClassWorkModel()
        model.class_book_id = json["class_book_id"].stringValue
        model.title = json["title"].stringValue
        model.photo = BookDetailModel.setValueForWorkBookModel(json: json["photo"])
        model.photo_next = BookDetailModel.setValueForWorkBookModel(json: json["photo_next"])
        model.type = json["type"].stringValue
        model.content = json["content"].stringValue
        model.content_next = json["content_next"].stringValue
        model.scores = json["scores"].stringValue
        model.scores_next = json["scores_next"].stringValue
        model.p_datetime = json["p_datetime"].stringValue
        model.student_id = json["student_id"].stringValue
        model.user_name = json["user_name"].stringValue
        model.user_photo = json["user_photo"].stringValue
        model.teacher_num = json["teacher_num"].stringValue
        model.teacher_name = json["teacher_name"].stringValue
        model.teacher_next_num = json["teacher_next_num"].stringValue
        model.student_num = json["student_num"].stringValue
        model.teacher_next_name = json["teacher_next_name"].stringValue
        model.reason = json["reason"].stringValue
        model.time = json["time"].stringValue
        model.create_date = json["create_date"].stringValue
        return model
    }
}
