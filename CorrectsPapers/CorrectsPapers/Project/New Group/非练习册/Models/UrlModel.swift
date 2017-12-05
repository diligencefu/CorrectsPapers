
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
    ///答案地址
    var answard_res : String!
    ///答案标题
    var title : String!
    ///学币
    var money : String?
    ///视频 答案类型：1，视频；2，文件；3，手写答案）
    var type : String?
    
//    知识点讲解
    ///章节
    var counts : String?
    ///地址
    var address : String?

    class func setValueForUrlModel(json: JSON) -> UrlModel {
        
        let model = UrlModel()
        
        model.answard_res = json["answard_res"].stringValue
        model.title = json["title"].stringValue
        model.money = json["money"].stringValue
        model.type = json["type"].stringValue
        model.counts = json["counts"].stringValue
        model.title = json["title"].stringValue
        model.address = json["address"].stringValue
        return model
        
    }
}
