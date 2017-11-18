//
//  TNotWorkModel.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/14.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyJSON

class TNotWorkModel: NSObject {
    ///非练习册名称
    var non_exercise_name : String!
    ///非练习册ID
    var id : String!
    ///科目名称
    var subject_name : String!
    ///学生名称
    var user_name : String!
    ///封面照片
    var pre_photos : String!
    ///悬赏分
    var rewards : String?
    ///批改状态
    var state : String!

    class func setValueForTNotWorkModel(json: JSON) -> TNotWorkModel {
        
        let model = TNotWorkModel()
        model.non_exercise_name = json["non_exercise_name"].stringValue
        model.id = json["id"].stringValue
        model.subject_name = json["subject_name"].stringValue
        model.user_name = json["user_name"].stringValue
        model.pre_photos = json["pre_photos"].stringValue
        model.rewards = json["rewards"].stringValue
        model.state = json["state"].stringValue
        return model
    }

}
