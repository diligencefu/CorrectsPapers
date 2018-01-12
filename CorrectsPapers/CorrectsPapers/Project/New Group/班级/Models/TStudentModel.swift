//
//  TStudentModel.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/17.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyJSON

class TStudentModel: NSObject {
    ///类型
    var apply_type : String!
    ///是不是自己
    var isMe : String!
    ///
    var ispay : String!
    ///学生id
    var student_id : String!
    ///姓名
    var student_name : String!
    ///学号
    var student_num : String!
    ///学生头像
    var student_photo : String!
    
    class func setValueForTStudentModel(jsonArr: JSON) -> Array<TStudentModel> {
        
        var dataArr = [TStudentModel]()
        let datas = jsonArr.arrayValue
        for index in 0..<datas.count {
            let json = datas[index]
            let model = TStudentModel()
            model.apply_type = json["apply_type"].stringValue
            model.isMe = json["isMe"].stringValue
            model.ispay = json["ispay"].stringValue
            model.student_id = json["student_id"].stringValue
            model.student_name = json["student_name"].stringValue
            model.student_num = json["student_num"].stringValue
            model.student_photo = json["student_photo"].stringValue
            dataArr.append(model)
        }
        return dataArr
    }

    class func setValueForTStudentModel_Me(json: JSON) -> TStudentModel {
        let model = TStudentModel()
        model.apply_type = json["apply_type"].stringValue
        model.isMe = json["isMe"].stringValue
        model.ispay = json["ispay"].stringValue
        model.student_id = json["student_id"].stringValue
        model.student_name = json["student_name"].stringValue
        model.student_num = json["student_num"].stringValue
        model.student_photo = json["student_photo"].stringValue
        return model
    }
}
