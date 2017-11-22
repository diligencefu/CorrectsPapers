//
//  TMassageCenterModel.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/18.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyJSON

class TMassageCenterModel: NSObject {
    ///原因
    var reason : String!
    ///老师id
    var userTeacherid : String!
    
    class func setValueForMessageModel(json: JSON) -> MessageModel {
        
        let model = MessageModel()
        model.reason = json["reason"].stringValue
        model.userTeacherid = json["userTeacherid"].stringValue
        return model
    }

}
