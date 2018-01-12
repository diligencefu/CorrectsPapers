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
    
    
    class func setValueForAccountModel(json: JSON) -> AccountModel {
        
        let model = AccountModel()
        model.coin_add = json["coin_add"].stringValue
        model.coin_del = json["coin_del"].stringValue
        model.create_date = json["create_date"].stringValue
        
        return model
    }
}
