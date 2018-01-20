//
//  SMessageModel.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/12/12.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyJSON

class SMessageModel: NSObject {
    ///（消息id）
    var msgId : String!
    ///（消息说明）
    var reason : String!
    ///（老师姓名）
    var user_name : String!
    ///（消息类型
    var type : String!
    ///(是否已读状态：0：代表未读，1：已读)
    var isread : String!

    class func setValueForSMessageModel(json: JSON) -> SMessageModel {
        
        let model = SMessageModel()
        model.msgId = json["msgId"].stringValue
        model.reason = json["reason"].stringValue
        model.user_name = json["user_name"].stringValue
        model.isread = json["isread"].stringValue
        model.type = json["type"].stringValue
        return model
    }

}
