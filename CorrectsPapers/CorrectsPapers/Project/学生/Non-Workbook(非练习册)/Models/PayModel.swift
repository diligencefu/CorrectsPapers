//
//  PayModel.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/12/2.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyJSON
class PayModel: NSObject {
    ///答案地址
    var isPay : String!
    ///答案标题
    var money : String!
    ///学币
    var teacher_id : String?
    ///视频 答案类型：1，视频；2，文件；3，手写答案）
    var type : String?
    
    class func setValueForPayModel(json: JSON) -> PayModel {
        
        let model = PayModel()
        
        model.isPay = json["isPay"].stringValue
        model.money = json["money"].stringValue
        model.teacher_id = json["teacher_id"].stringValue
        model.type = json["type"].stringValue
        return model
    }

}
