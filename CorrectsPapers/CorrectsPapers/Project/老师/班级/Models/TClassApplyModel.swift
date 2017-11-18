//
//  TClassApplyModel.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/17.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyJSON

class TClassApplyModel: NSObject {
    ///学生
    var studentApply : Array<TStudentModel>!
    ///老师
    var teacherApply : Array<TTeacherModel>!
    
    class func setValueForTClassApplyModel(json: JSON) -> TClassApplyModel {
        
        let model = TClassApplyModel()
        model.studentApply = TStudentModel.setValueForTStudentModel(jsonArr: json["studentApply"])
        model.teacherApply = TTeacherModel.setValueForTTeacherModel(jsonArr: json["teacherApply"])
        
        return model
    }

}
