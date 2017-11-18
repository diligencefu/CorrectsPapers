//
//  THeadTeacherModel.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/17.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyJSON

class THeadTeacherModel: NSObject {
    ///id
    var head_teacher_id : String!
    ///名字
    var head_teacher_name : String!
    ///工号
    var head_teacher_num : String!
    ///头像
    var head_teacher_photo : String!
    ///是否是班主任
    var isMe : String!

    
    
    class func setValueForTHeadTeacherModel(json: JSON) -> THeadTeacherModel {
        
        let model = THeadTeacherModel()
        model.head_teacher_id = json["head_teacher_id"].stringValue
        model.head_teacher_name = json["head_teacher_name"].stringValue
        model.head_teacher_num = json["head_teacher_num"].stringValue
        model.head_teacher_photo = json["head_teacher_photo"].stringValue
        model.isMe = json["isMe"].stringValue
        return model
    }

}
