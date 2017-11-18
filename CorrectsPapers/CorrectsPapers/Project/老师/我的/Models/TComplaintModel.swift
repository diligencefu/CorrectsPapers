//
//  TComplaintModel.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/16.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyJSON

class TComplaintModel: NSObject {
    ///用户名
    var user_name : String!
    ///用户编号
    var user_num : String!
    ///头像
    var user_photo : String!
    ///详细内容
    var coms : Array<TComplaintDetailModel>!
    ///记录id
    var id : String!
    
    class func setValueForTComplaintModel(json: JSON) -> TComplaintModel {
        
        let model = TComplaintModel()
        model.user_name = json["user_name"].stringValue
        model.user_num = json["user_num"].stringValue
        model.user_photo = json["user_photo"].stringValue
        model.coms = TComplaintDetailModel.setValueForTComplaintDetailModel(json: json["coms"])
        model.id = json["id"].stringValue
        return model
    }
}
