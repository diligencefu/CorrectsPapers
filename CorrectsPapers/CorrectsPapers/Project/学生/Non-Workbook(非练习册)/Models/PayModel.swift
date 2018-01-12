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
    ///买没买
    var isPay : String!
    ///学币
    var money : String!
    ///老师id
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


class PayVideoModel: NSObject {
    ///买没买
    var isPay : String!
    ///学币
    var scores_one : String!
    ///老师id
    var head_teacher_id : String!

    class func setValueForPayVideoModel(json: JSON) -> PayVideoModel {
        
        let model = PayVideoModel()
        
        model.isPay = json["ispay"].stringValue
        model.scores_one = json["scores_one"].stringValue
        model.head_teacher_id = json["head_teacher_id"].stringValue
        return model
    }
    
}
