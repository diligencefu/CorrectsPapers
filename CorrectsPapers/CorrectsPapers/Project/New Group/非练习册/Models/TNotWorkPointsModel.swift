//
//  TNotWorkPointsModel.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/14.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyJSON

class TNotWorkPointsModel: NSObject {
    ///章节数
    var counts : String!
    ///章节标题
    var title : String!
    ///章节链接地址
    var address : String?
    
    class func setValueForTNotWorkPointsModel(json: JSON) -> TNotWorkPointsModel {
        
        let model = TNotWorkPointsModel()
        model.counts = json["counts"].stringValue
        model.title = json["title"].stringValue
        model.address = json["address"].stringValue
        return model
    }

}
