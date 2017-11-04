//
//  ApplyModel.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/4.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyJSON

class ApplyModel: NSObject {
    ///申请人名字
    var user_name : String!
    ///申请人地区
    var user_area : String!
    ///申请人图像
    var user_photo : String!
    ///申请人类型
    var user_type : String!
    ///申请人工号或者学号
    var user_num : String!

    
    class func setValueForApplyModel(json: JSON) -> ApplyModel {
        
        let model = ApplyModel()
        model.user_name = json["user_name"].stringValue
        model.user_area = json["user_area"].stringValue
        model.user_photo = json["user_photo"].stringValue
        model.user_type = json["user_type"].stringValue
        model.user_num = json["user_num"].stringValue

        return model
    }

}
