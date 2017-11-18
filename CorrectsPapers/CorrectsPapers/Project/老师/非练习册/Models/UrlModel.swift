
//
//  UrlModel.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/10.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyJSON

class UrlModel: NSObject {
    ///视频地址
    var videoUrl : String!
    ///视频描述
    var describe : String!
    ///视频描述
    var period : String?
    ///视频价格
    var price : String?
    
    ///章节数
    var counts : String?
    ///标题
    var title : String?
    ///章节链接地址
    var address : String?
    

    class func setValueForUrlModel(json: JSON) -> UrlModel {
        
        let model = UrlModel()
        
        model.videoUrl = json["videoUrl"].stringValue
        model.describe = json["describe"].stringValue
        model.period = json["period"].stringValue
        model.price = json["price"].stringValue
        model.counts = json["counts"].stringValue
        model.title = json["title"].stringValue
        model.address = json["address"].stringValue
        return model
    }
}
