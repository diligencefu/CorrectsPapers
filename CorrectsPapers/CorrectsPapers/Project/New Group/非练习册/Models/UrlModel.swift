
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
    var address : String!
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
    var answard_res : String!

    ///章节
    var point_title : String?
    ///章节
    var point_address : String?
    
    var format : String?

    
    
    class func setValueForUrlModel(json: JSON) -> UrlModel {
        
        let model = UrlModel()
        
        model.address = json["answard"].stringValue
        model.title = json["title"].stringValue
        model.money = json["money"].stringValue
        model.type = json["type"].stringValue
        model.counts = json["counts"].stringValue
        model.answard_res =  json["answard_res"].stringValue
        model.point_title = json["title"].stringValue
        model.point_address = json["address"].stringValue
        model.format = json["format"].stringValue
        return model
    }
    
    
    class func setValueForTitlesAnd(json: JSON) -> Array<String> {
        let photoArr = json.arrayValue
        
        var images = [String]()
        
        for index in 0..<photoArr.count {
            let str = photoArr[index].stringValue
            images.append(str)
        }
        return images
    }

    
}
