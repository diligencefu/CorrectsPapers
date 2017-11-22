//
//  TTeacherModel.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/17.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyJSON

class TTeacherModel: NSObject {
    ///类型
    var type : String!
    ///是不是自己
    var isMe : String!
    ///老师id
    var teacher_id : String!
    ///老师姓名
    var teacher_name : String!
    ///工号
    var teacher_num : String!
    ///老师头像
    var teacher_photo : String!
    
    class func setValueForTTeacherModel(jsonArr: JSON) -> Array<TTeacherModel> {
        
        var dataArr = [TTeacherModel]()
        let datas = jsonArr.arrayValue
        for index in 0..<datas.count {
            let json = datas[index]
            let model = TTeacherModel()
            model.type = json["type"].stringValue
            model.isMe = json["isMe"].stringValue
            model.teacher_id = json["teacher_id"].stringValue
            model.teacher_name = json["teacher_name"].stringValue
            model.teacher_num = json["teacher_num"].stringValue
            model.teacher_photo = json["teacher_photo"].stringValue
            dataArr.append(model)
        }
        return dataArr
    }

}
