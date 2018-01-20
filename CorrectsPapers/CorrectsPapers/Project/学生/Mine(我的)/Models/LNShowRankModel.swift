//
//  LNShowRankModel.swift
//  CorrectsPapers
//
//  Created by RongXing on 2018/1/12.
//  Copyright © 2018年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyJSON

class LNShowRankModel: NSObject {
    ///每个学生的总分
    var everyScores : String!
    ///总分
    var scoresSum : String!
    ///我的排名
    var index : String!

    
    class func setValueForLNShowRankModel(json: JSON) -> LNShowRankModel {
        
        let model = LNShowRankModel()
        model.index = json["index"].stringValue
        model.scoresSum = json["scoresSum"].stringValue
        model.everyScores = json["everyScores"].stringValue
        return model
    }

}
