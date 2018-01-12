//
//  MessageModel.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/6.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyJSON

class MessageModel: NSObject {
    ///学生Id
    var userStudentid : String!
    ///老师id
    var userTeacherid : String!
    ///是否是新消息
    var isNewRecord : String!
    ///内容
    var reason : String!
    ///消息id
    var id : String!
    ///学生姓名
    var user_name : String!
    ///(是否已读状态：0：代表未读，1：已读)
    var isread : String!

    class func setValueForMessageModel(json: JSON) -> MessageModel {
        
        let model = MessageModel()
        model.userStudentid = json["userStudentid"].stringValue
        model.userTeacherid = json["userTeacherid"].stringValue
        model.isNewRecord = json["isNewRecord"].stringValue
        model.reason = json["reason"].stringValue
        model.id = json["id"].stringValue
        model.user_name = json["user_name"].stringValue
        model.isread = json["isread"].stringValue
        return model
    }
}
