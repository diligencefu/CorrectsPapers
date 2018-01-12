//
//  TPeriodsModel.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/17.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyJSON

class TPeriodsModel: NSObject {
    ///课时id
    var periods_id : String!
    ///课时序号
    var orders : String!
    ///课时名称
    var name : String!
    

    
    class func setValueForTPeriodsModel(json: JSON) -> TPeriodsModel {
        
        let model = TPeriodsModel()
        model.periods_id = json["periods_id"].stringValue
        model.orders = json["orders"].stringValue
        model.name = json["name"].stringValue
        return model
    }
}
