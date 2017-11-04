//
//  FriendsModel.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/4.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyJSON

class FriendsModel: NSObject {
    ///用户的姓名
    var user_name : String!
    ///用户所在地区
    var user_area : String!
    ///用户学号或者工号
    var user_num : String!
    ///是否已经是好友
    var isFriend : Bool!
    ///用户类型（1，学生 。2，老师）
    var user_type : String!
    ///用户头像
    var user_photo : String!
    ///所在班级
    var user_class : String!


    class func setValueForFriendsModel(json: JSON) -> FriendsModel {
        
        let model = FriendsModel()
        model.user_name = json["user_name"].stringValue
        model.user_area = json["user_area"].stringValue
        model.user_num = json["user_num"].stringValue
        model.isFriend = json["isFriend"].boolValue
        model.user_type = json["user_type"].stringValue
        model.user_photo = json["user_photo"].stringValue
        model.user_class = json["user_class"].stringValue

        return model
    }
}
