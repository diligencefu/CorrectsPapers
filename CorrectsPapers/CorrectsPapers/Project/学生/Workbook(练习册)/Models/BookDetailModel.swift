//
//  BookDetailModel.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/1.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyJSON

class BookDetailModel: BaseModel {
    ///练习册2张照片,图片用“|”隔开返回
    var photo : Array<String>!
    ///作业描述
    var result : String!
    ///批改时间
    var correcting_time : String!
    ///批改状态
    var correcting_states : String!
    ///批改后的照片
    var corrected_error_photo : Array<String>!
    ///批改老师编号
    var teacher_id : String?
    ///批改老师姓名
    var teacher_name : String!
    ///老师工号
    var teacher_num : String!
    ///首次的得分1-5
    var scores : String!
    ///再次得分1-5
    var scores_next : String!
    ///老师首次评语
    var comment : String?
    ///老师再次评语
    var comment_next : String?
    ///创建时间
    var create_date : String?
    ///id
    var book_details_id : String!
    ///id
    var times : String!
    ///退回原因
    var reason : String!


    class func setValueForBookDetailModel(json: JSON) -> BookDetailModel {
        
        let model = BookDetailModel()
        model.photo = BookDetailModel.setValueForWorkBookModel(json: json["photo"])
        model.result = json["result"].stringValue
        model.correcting_time = json["correcting_time"].stringValue
        model.comment = json["comment"].stringValue
        model.correcting_states = json["correcting_states"].stringValue
        model.corrected_error_photo = BookDetailModel.setValueForWorkBookModel(json: json["corrected_error_photo"])
        model.teacher_id = json["teacher_id"].stringValue
        model.teacher_name = json["teacher_name"].stringValue
        model.teacher_num = json["teacher_num"].stringValue
        model.scores = json["scores"].stringValue
        model.scores_next = json["scores_next"].stringValue
        model.comment_next = json["comment_next"].stringValue
        model.create_date = json["create_date"].stringValue
        model.book_details_id = json["book_details_id"].stringValue
        model.times = json["times"].stringValue
        model.reason = json["reason"].stringValue
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
