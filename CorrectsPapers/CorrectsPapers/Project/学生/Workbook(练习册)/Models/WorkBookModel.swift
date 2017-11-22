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
    var isFollow : String!
    
    ///批改老师
    var teacherName : String?
    
    ///用户练习册id（
    var userWorkBookId : String?
    
    ///(人数)：（老师端使用）：
    var count : String?

    ///年级
    var grade : String?
    ///学期
    var semester : String?

    ///已交人数
    var correct_ti : String?

    ///book id
    var id : String?
    
    ///已批改人数
    var state1 : String?
    
    ///交作业人数
    var state2 : String?
    
    ///批改状态:1、未上传；2、未批改；3、退回；4已批改 5:错题 未批改 6错题退回 7错题已批改
    var correcting_states : String?
    
    class func setValueForWorkBookModel(json: JSON) -> WorkBookModel {
        
        let model = WorkBookModel()
        model.work_book_Id = json["work_book_Id"].stringValue
        model.work_book_name = json["work_book_name"].stringValue
        model.cover_photo = json["cover_photo"].stringValue
        model.class_name = json["class_name"].stringValue
        model.subject_name = json["subject_name"].stringValue
        model.isFollow = json["isFollow"].stringValue
        model.teacherName = json["teacherName"].stringValue
        model.userWorkBookId = json["userWorkBookId"].stringValue
        model.count = json["count"].stringValue
        model.grade = json["grade"].stringValue
        model.semester = json["semester"].stringValue
        model.correct_ti = json["correct_ti"].stringValue
        model.id = json["id"].stringValue
        model.state2 = json["state2"].stringValue
        model.state1 = json["state1"].stringValue
        model.correcting_states = json["correcting_states"].stringValue

        return model
    }

}
