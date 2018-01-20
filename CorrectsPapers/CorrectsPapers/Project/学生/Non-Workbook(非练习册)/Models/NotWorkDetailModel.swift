//
//  NotWorkDetailModel.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/27.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyJSON
class NotWorkDetailModel: NSObject {
    ///练习册名字
    var non_exercise_name : String!
    
    ///未批改前照片
    var pre_photos : Array<String>!

    ///非练习册状态
    var correct_states : String!
//
//    ///批改老师
//    var teacher_name : String!
    
    ///批改方式：1，好友批改；2，学币批改
    var correct_way : String!
    
    ///悬赏学币数量
    var rewards : String!
    
    ///批改后评语
    var pre_comment  =  ""
    
    ///再次批改后的评语
    var upd_comment  =  ""

    ///批改后的照片
    var corrected_photos : Array<String>!
    
    ///首次批改成绩
    var pre_score : String!
    
    ///再次批改后的成绩
    var upd_score : String!

    ///创建时间
    var create_date : String!
    
    ///老师
    var teacher_name : String!
    
    ///老师id
    var teacher_id : String!

    ///退回原因
    var reason : String!

    ///截止时间
    var times : String!


    class func setValueForNotWorkDetailModel(json: JSON) -> NotWorkDetailModel {
        
        let model = NotWorkDetailModel()
        model.non_exercise_name = json["non_exercise_name"].stringValue
        model.correct_states = json["correct_states"].stringValue
        model.correct_way = json["correct_way"].stringValue
        model.rewards = json["rewards"].stringValue
        model.pre_photos = BookDetailModel.setValueForWorkBookModel(json: json["pre_photos"])
        model.upd_comment = json["upd_comment"].stringValue
        model.pre_comment = json["pre_comment"].stringValue
        model.pre_score = json["pre_score"].stringValue
        model.upd_score = json["upd_score"].stringValue
        model.corrected_photos = BookDetailModel.setValueForWorkBookModel(json: json["corrected_photos"])
        model.create_date = json["create_date"].stringValue
        model.teacher_name = json["teacher_name"].stringValue
        model.reason = json["reason"].stringValue
        model.teacher_id = json["teacher_id"].stringValue
        model.times = json["times"].stringValue
        return model
    }
    
    class func setValueForWorkBookModel(json: JSON) -> Array<String> {
        let photoArr = json.arrayValue
        
        var images = [String]()
        
        for index in 0..<photoArr.count {
            let str = photoArr[index].stringValue
            images.append(str)
        }
        return images
    }

}
