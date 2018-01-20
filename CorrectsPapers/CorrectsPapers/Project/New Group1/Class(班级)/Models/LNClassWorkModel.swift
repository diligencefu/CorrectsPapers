//
//  LNClassWorkModel.swift
//  CorrectsPapers
//
//  Created by RongXing on 2018/1/9.
//  Copyright © 2018年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyJSON

class LNClassWorkModel: NSObject {
    ///作业标题
    var title : String!
    ///作业图片
    var photo : Array<String>!
    ///学生名字
    var student_name : String!
    ///学生头像
    var user_photo : String!
    ///学生学号
    var user_num : String!
    ///（创建时间）
    var create_date : String!
    ///（老师名字）
    var teacher_name : String!
    ///首次评语）
    var content : String!

    
    class func setValueForLNClassWorkModel(json: JSON) -> LNClassWorkModel {
        
        let model = LNClassWorkModel()
        model.title = json["title"].stringValue
        model.student_name = json["student_name"].stringValue
        model.user_photo = json["user_photo"].stringValue
        model.user_num = json["user_num"].stringValue
        model.create_date = json["create_date"].stringValue
        model.teacher_name = json["teacher_name"].stringValue
        model.content = json["content"].stringValue
        model.photo = BookDetailModel.setValueForWorkBookModel(json: json["photo"])
        return model
    }

}
