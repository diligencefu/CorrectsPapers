//
//  TMyWorkDetailModel.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/11.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyJSON

class TMyWorkDetailModel: NSObject {
    ///练习册名称
    var work_book_name = ""  //字面量语法声明，设置默认值，这样避免=nil的情况
    ///已批改人数
    var state2 : String!
    ///总人数
    var count : String!
    ///交作业人数
    var state1 : String!
    ///印刷版次图片
    var edition_photo : String!
    
    
    class func setValueForTMyWorkDetailModel(json: JSON) -> TMyWorkDetailModel {
        
        let model = TMyWorkDetailModel()
        model.work_book_name = json["work_book_name"].stringValue
        model.state2 = json["state2"].stringValue
        model.count = json["count"].stringValue
        model.state1 = json["state1"].stringValue
        model.edition_photo = json["edition_photo"].stringValue
        return model
    }
}
