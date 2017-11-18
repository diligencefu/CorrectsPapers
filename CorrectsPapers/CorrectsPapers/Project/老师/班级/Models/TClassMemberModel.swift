//
//  TClassMemberModel.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/17.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyJSON

class TClassMemberModel: NSObject {
    
    ///班主任
    var head_teacher : THeadTeacherModel!
    ///学生
    var student : Array<TStudentModel>!
    ///老师
    var teacher : Array<TTeacherModel>!
    ///申请
    var apply : TClassApplyModel!

    
    
    class func setValueForTClassMemberModel(json: JSON) -> TClassMemberModel {
        
        let model = TClassMemberModel()
        model.head_teacher = THeadTeacherModel.setValueForTHeadTeacherModel(json: json["head_teacher"])
        model.student = TStudentModel.setValueForTStudentModel(jsonArr: json["student"])
        model.teacher = TTeacherModel.setValueForTTeacherModel(jsonArr: json["teacher"])
        model.apply = TClassApplyModel.setValueForTClassApplyModel(json: json["apply"])

        return model
    }
    
    
}
