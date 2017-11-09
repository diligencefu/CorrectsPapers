//
//  WorkBookModel.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/1.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import  SwiftyJSON

class WorkBookModel: BaseModel {
//    练习册id
    var work_book_Id = ""  //字面量语法声明，设置默认值，这样避免=nil的情况
    ///练习册名字
    var work_book_name : String!
    ///练习册封面照
    var cover_photo : String!
    ///班级名称
    var class_name : String!
    ///课程名称
    var subject_name : String!
    ///是否已添加标签
    var isFollow : Bool!
    ///批改状态
    var correct_state : NSInteger?

    ///批改老师
    var teacherName : String?
    
    ///用户练习册id（
    var userWorkBookId : String?
    
    ///(人数)：（老师端使用）：
    var counts : String?

    ///年级
    var grade : String?


    class func setValueForWorkBookModel(json: JSON) -> WorkBookModel {
        
        let model = WorkBookModel()
        model.work_book_Id = json["work_book_Id"].stringValue
        model.work_book_name = json["work_book_name"].stringValue
        model.cover_photo = json["cover_photo"].stringValue
        model.class_name = json["class_name"].stringValue
        model.subject_name = json["subject_name"].stringValue
        model.isFollow = json["isFollow"].boolValue
        model.correct_state = json["correcting_state"].intValue
        model.teacherName = json["teacherName"].stringValue
        model.userWorkBookId = json["userWorkBookId"].stringValue
        model.counts = json["counts"].stringValue
        model.grade = json["grade"].stringValue

        return model
    }

}
