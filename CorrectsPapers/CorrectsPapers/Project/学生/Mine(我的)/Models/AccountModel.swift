//
//  AccountModel.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/3.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyJSON

class AccountModel: NSObject {
    
    ///增加学币
    var coin_add : String!
    ///使用学币
    var coin_del : String!
    ///使用日期
    var create_date : String!
    ///使用途径
    var coin_thing : String!
    ///学币使用类型：1，新增；2，消费)
    var state : String!

    
    class func setValueForAccountModel(json: JSON) -> AccountModel {
        
        let model = AccountModel()
        model.coin_add = json["coin_add"].stringValue
        model.coin_del = json["coin_del"].stringValue
        model.create_date = json["create_date"].stringValue
        model.state = json["state"].stringValue
        model.coin_thing = json["coin_thing"].stringValue

        return model
    }
}
