//
//  TComplaintDetailModel.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/16.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyJSON

class TComplaintDetailModel: NSObject {
    ///
    var complainant : String!
    ///
    var complaints_type : String!
    //
    var create_date : String!
    ///
    var other : String!
    
    class func setValueForTComplaintDetailModel(json: JSON) -> Array<TComplaintDetailModel> {
        
        var dataArr = [TComplaintDetailModel]()
        let datas = json.arrayValue
        for index in 0..<datas.count {
            let json = datas[index]
            let model = TComplaintDetailModel()
            model.complainant = json["complainant"].stringValue
            model.complaints_type = json["complaints_type"].stringValue
            model.create_date = json["create_date"].stringValue
            model.other = json["other"].stringValue
            dataArr.append(model)
        }
        return dataArr
    }

}
