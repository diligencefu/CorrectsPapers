//
//  TClassModel.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/17.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyJSON

class TClassModel: NSObject {
    ///班级id
    var id : String!
    ///班级照片
    var class_photo : String!
    ///（班级名称
    var class_name : String!
    ///截止时间）
    var work_times : String!
    ///班主任名字
    var user_name : String!
    ///班级人数
    var all_num : String!
    ///交作业情况：学生人数
    var s_num : String!
    ///交作业情况：已交人数
    var pre_num : String!
    ///是否为创建人
    var founder : String!

    
    class func setValueForTClassModel(json: JSON) -> TClassModel {
        
        let model = TClassModel()
        model.id = json["id"].stringValue
        model.class_photo = json["class_photo"].stringValue
        model.class_name = json["class_name"].stringValue
        model.work_times = json["work_times"].stringValue
        model.user_name = json["user_name"].stringValue
        model.all_num = json["all_num"].stringValue
        model.s_num = json["s_num"].stringValue
        model.founder = json["founder"].stringValue
        return model
    }

}
