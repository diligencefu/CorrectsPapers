//
//  TShowGradeModel.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/13.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyJSON

class TShowGradeModel: NSObject {
    ///学生ID
    var studentId = ""  //字面量语法声明，设置默认值，这样避免=nil的情况
    ///学生
    var user_name : String!
    ///批改成绩）
    var scores : String!
    ///改正成绩 ： 没有返回空字符串
    var scores_next : String!
    
    ///照片
    var user_photo : String?
    ///作业状态
    var state : String!
    
    ///学号
    var user_num : String?

    
    
    class func setValueForTMyWorkTShowGradeModel(json: JSON) -> TShowGradeModel {
        
        let model = TShowGradeModel()
        
        model.studentId = json["studentId"].stringValue
        model.user_name = json["user_name"].stringValue
        model.scores = json["scores"].stringValue
        model.scores_next = json["scores_next"].stringValue
        model.user_photo = json["user_photo"].stringValue
        model.user_num = json["user_num"].stringValue
        return model
    }
}
