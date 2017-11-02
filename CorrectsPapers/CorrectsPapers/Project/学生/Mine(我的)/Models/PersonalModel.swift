//
//  personalModel.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/1.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyJSON

class PersonalModel: NSObject {
    ///学生年级
    var user_fit_class = ""  //字面量语法声明，设置默认值，这样避免=nil的情况
    ///学生姓名
    var user_name : String!
    ///学生地区
    var user_area : String!
    ///学生头像
    var user_photo : String!
    ///学生学号
    var user_num : String!
    ///电话号码
    var user_phone : String!
    ///我的学币
    var coin_count : String?
    ///消息中心数量
    var num : String!
    ///好友数量
    var friendCount : String!

    
    
    class func setValueForPersonalModel(json: JSON) -> PersonalModel {
        
        let model = PersonalModel()
        model.user_fit_class = json["user_fit_class"].stringValue
        model.user_name = json["user_name"].stringValue
        model.user_area = json["user_area"].stringValue
        model.user_photo = json["user_photo"].stringValue
        model.user_num = json["user_num"].stringValue
        model.user_phone = json["user_phone"].stringValue
        model.coin_count = json["coin_count"].stringValue
        model.num = json["num"].stringValue
        model.friendCount = json["friendCount"].stringValue

        return model
    }
}
