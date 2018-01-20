  //
//  NetWorkTools.swift
//  Swift Test
//
//  Created by RongXing on 2017/9/16.
//  Copyright © 2017年 付耀辉. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftyUserDefaults
  
var createGroupBlock:((String,Array<Any>)->())?  //声明闭包

  
//MARK:验证码接口
public func netWorkForSendCode(phoneNumber:String,callBack:((String,Bool)->())?) ->  Void {

    let dic = ["phone":phoneNumber]
    Alamofire.request(kGet_Sms,
                      method: .get, parameters: dic,
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:DispatchQueue.main, options: .allowFragments) { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let translation =  JSOnDictory["message"].stringValue
                                let code =  JSOnDictory["code"].intValue

                                setToast(str: translation)
                                
                                if code == 1 {
                                    callBack!("",true)
                                }else{
                                    callBack!("",false)
                                }
                                
                                
                                
                                deBugPrint(item: translation)
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                        }
    }
}

  //MARK:验证码接口
  public func netWorkForCheckCode(params:[String:String],callBack:((Bool)->())?) ->  Void {
    
    Alamofire.request(kcheak_Text,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:DispatchQueue.main, options: .allowFragments) { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let translation =  JSOnDictory["message"]
                                
                                let code =  JSOnDictory["code"].intValue
                                
                                if code == 1{
                                    callBack!(true)
                                }
                                
                                if code == 5{
                                    callBack!(false)
                                    setToast(str: "该验证码已失效,请重新发送!")
                                }else if code == 6{
                                    callBack!(false)
                                    setToast(str: "短信验证码错误!")
                                }

                                deBugPrint(item: translation)
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                        }
    }
  }


//MARK:注册接口
public func netWorkForRegistAccount(params:[String:Any],callBack:((Bool)->())?) ->  Void {
//    let dataArr = NSMutableArraRy()
    Alamofire.request(kUser_Signup,
                      method: .post,
                      parameters: params,
                      encoding: URLEncoding.default,
                      headers: nil).responseJSON
                      { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let code =  JSOnDictory["code"].intValue
                                let translation =  JSOnDictory["message"].stringValue
//                                Defaults[userToken] =  JSOnDictory["SESSIONID"].stringValue
//                                Defaults[username] =  JSOnDictory["mobileCode"].stringValue

                                if code == 0{
                                    callBack!(false)
                                    setToast(str: translation)
                                }else{
                                    Defaults[userToken] =  JSOnDictory["data"]["SESSIONID"].stringValue
                                    Defaults[mCode] =  JSOnDictory["data"]["mobileCode"].stringValue

                                    callBack!(true)
                                }
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            setToast(str: "注册失败")
                        }
    }
}

  //MARK:登录接口
  public func netWorkForLogin(params:[String:Any],callBack:((Bool)->())?) ->  Void {
    //    let dataArr = NSMutableArraRy()
    Alamofire.request(kLogin_api,
                      method: .get,
                      parameters: params,
                      encoding: URLEncoding.default,
                      headers: nil).responseJSON
        { (response) in
            deBugPrint(item: response.result)
            switch response.result {
            case .success:
                
                if let j = response.result.value {
                    //SwiftyJSON解析数据
                    let JSOnDictory = JSON(j)
                    let code =  JSOnDictory["code"].intValue
                    let translation =  JSOnDictory["message"].stringValue
                    
                    if code == 0 {
                        callBack!(false)
                        setToast(str: translation)
                    }else if code == 1{
                        Defaults[userToken] =  JSOnDictory["data"]["SESSIONID"].stringValue
                        Defaults[mCode] = JSOnDictory["data"]["mobileCode"].stringValue
                        Defaults[HavePayPassword] =  JSOnDictory["data"]["HavePayPassword"].stringValue

                        if JSOnDictory["data"]["degree"].intValue == 2 {
                            Defaults[userIdentity] = kTeacher
                        }else if JSOnDictory["data"]["degree"].intValue == 1 {
                            Defaults[userIdentity] = kStudent
                        }
                        
                        callBack!(true)
                    }else{
                        callBack!(false)
                        setToast(str: translation)
                    }
                }
                break
            case .failure(let error):
                deBugPrint(item: error)
                setToast(str: "登录失败")
            }
    }
  }
  
  
//MARK: *****************老师端接口**************
//MARK: *****************老师端接口**************
//MARK: *****************老师端接口**************
//MARK: *****************老师端接口**************
//MARK: *****************老师端接口**************


//MARK:  老师端4-5被投诉记录

  public func NetWorkTeacherGetComplaintRecord(callBack:((Array<Any>,Bool)->())?) ->  Void {
    
    let params =
        ["SESSIONID":Defaults[userToken]!,
         "mobileCode":Defaults[mCode]!,
         ]
    
    var dataArr = [TComplaintModel]()
    Alamofire.request(kComplaint_By,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(dataArr,false)
                                }

                                let datas =  JSOnDictory["data"].arrayValue
                                
                                for index in 0..<datas.count {
                                    
                                    let json = datas[index]
                                    let model  = TComplaintModel.setValueForTComplaintModel(json: json)
                                    dataArr.append(model)
                                }
                                callBack!(dataArr,true)
                            }
                            
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            
                            callBack!(dataArr,false)
                            setToast(str: "获取被投诉记录")
                        }
    }
}


//MARK: 1  1-0 和 1-2  获取所有的练习册
public func NetWorkTeacherGetTAllWorkList(params:[String:Any],callBack:((Array<Any>,Bool)->())?) ->  Void {
    
    var dataArr = [WorkBookModel]()
    Alamofire.request(kGet_TAllWorkList,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:

                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(dataArr,false)
                                }

                                let datas =  JSOnDictory["data"].arrayValue
                                for index in 0..<datas.count {
                                    
                                    let json = datas[index]
                                    let model  = WorkBookModel.setValueForWorkBookModel(json: json)
                                    dataArr.append(model)
                                }
                                callBack!(dataArr,true)
                            }
                            
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(dataArr,false)
                        }
    }
}

//MARK: 26   1-1 我的练习册  - 我来批改
public func NetWorkTeacherAddMyWork(params:[String:Any],callBack:((Bool)->())?) ->  Void {
    
    Alamofire.request(kAdd_MyWork,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(false)
                                    setToast(str: "添加到练习册失败")
                                }else{
                                    callBack!(true)
                                }
                            }
                            break
                        case .failure(let _):
                            callBack!(false)
                            setToast(str: "添加到练习册失败")
                        }
    }
}


//MARK:2 1-1 我的练习册
public func NetWorkTeacherGetMyWorkList(params:[String:Any],callBack:((Array<Any>,Bool)->())?) ->  Void {
    var dataArr = [WorkBookModel]()
    Alamofire.request(kGet_MyWorkList,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let datas =  JSOnDictory["data"].arrayValue
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(dataArr,false)
                                }
                                for index in 0..<datas.count {
                                    
                                    let json = datas[index]
                                    let model  = WorkBookModel.setValueForWorkBookModel(json: json)
                                    dataArr.append(model)
                                }
                                callBack!(dataArr,true)
                            }
                            
                            break
                        case .failure( _):
                            
                            callBack!(dataArr,false)
                            setToast(str: "获取我的练习册失败")
                        }
    }
    
}


//MARK:3 1-1 我的练习册 删除
public func NetWorkTeacherDelMyWork(params:[String:String],callBack:((Bool)->())?) ->  Void {
    
    Alamofire.request(kdel_MyWork,
                      method: .get,
                      parameters: params,
                      encoding: URLEncoding.default,
                      headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(false)
                                    setToast(str: "删除练习册失败")
                                }else{
                                    callBack!(true)
                                }
                            }
                            break
                        case .failure( _):
                            callBack!(false)
                            setToast(str: "删除练习册失败")
                        }
    }
}


//MARK:4  1-3 练习册详情 根据练习册id获取详情
public func NetWorkTeacherGetTWorkDetail(params:[String:Any],callBack:((Array<Any>,Bool)->())?) ->  Void {
   
    var dataArr = [TMyWorkDetailModel]()
    Alamofire.request(kGet_TWorkDetail,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(dataArr,false)
                                }
                                
                                let datas =  JSOnDictory["data"].arrayValue
                                
                                for index in 0..<datas.count {
                                    
                                    let json = datas[index]
                                    let model  = TMyWorkDetailModel.setValueForTMyWorkDetailModel(json: json)
                                    dataArr.append(model)
                                }
                                callBack!(dataArr,true)
                            }
                            
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(dataArr,false)
                            setToast(str: "获取练习册详情失败")
                        }
    }
    
}


//MARK:5  1-3 练习册详情 - 学生作业 》根据练习册id获取详情
public func NetWorkTeacherGetTStudentWorkList(params:[String:Any],callBack:((Array<Any>,Bool)->())?) ->  Void {
    
    var dataArr = [TShowStuWorksModel]()
    Alamofire.request(kGet_TStudentWork1,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(dataArr,false)
                                }
                                
                                let datas =  JSOnDictory["data"].arrayValue
                                
                                for index in 0..<datas.count {
                                    
                                    let json = datas[index]
                                    let model  = TShowStuWorksModel.setValueForTShowStuWorksModel(json: json)
                                    dataArr.append(model)
                                }
                                callBack!(dataArr,true)
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(dataArr,false)
                            setToast(str: "获取练习册学生作业失败")
                        }
    }
    
}


  //MARK:5  1-3 练习册详情 - 学生作业 》根据练习册id获取详情
  public func NetWorkTeacherGetTStudentWorkDetail(params:[String:Any],callBack:((Array<Any>,Bool)->())?) ->  Void {
    
    var dataArr = [TShowStuWorksModel]()
    Alamofire.request(kGet_TStudentWorkDetail,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(dataArr,false)
                                }else{
                                    let datas =  JSOnDictory["data"].arrayValue
                                    
                                    for index in 0..<datas.count {
                                        
                                        let json = datas[index]
                                        let model  = TShowStuWorksModel.setValueForTShowStuWorksModel(json: json)
                                        dataArr.append(model)
                                    }
                                    callBack!(dataArr,true)
                                }
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(dataArr,false)
                            setToast(str: "获取练习册学生作业失败")
                        }
    }
    
  }


//MARK:6  1-3 练习册详情 - 已批改 >> 根据练习册id获取详情
public func NetWorkTeacherGetTStudentCorrected(params:[String:Any],callBack:((Array<Any>,Bool)->())?) ->  Void {
    
    var dataArr = [TShowGradeModel]()
    Alamofire.request(kGet_TStudentWork2,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(dataArr,false)
                                }
                                
                                let datas =  JSOnDictory["data"].arrayValue
                                
                                for index in 0..<datas.count {
                                    
                                    let json = datas[index]
                                    let model  = TShowGradeModel.setValueForTMyWorkTShowGradeModel(json: json)
                                    dataArr.append(model)
                                }
                                callBack!(dataArr,true)
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(dataArr,false)
                            setToast(str: "获取已批改作业失败")
                        }
    }
    
}


//MARK:7   1-3 练习册 - 详情 - 知识点讲解
public func NetWorkTeacherGetTPeriodPoint(params:[String:Any],callBack:((Array<Any>,Bool)->())?) ->  Void {
    
    var dataArr = [UrlModel]()
    Alamofire.request(kGet_TStudentWork3,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(dataArr,false)
                                }
                                
                                let datas =  JSOnDictory["data"].arrayValue
                                
                                for index in 0..<datas.count {
                                    
                                    let json = datas[index]
                                    let model  = UrlModel.setValueForUrlModel(json: json)
                                    dataArr.append(model)
                                }
                                callBack!(dataArr,true)
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(dataArr,false)
                            setToast(str: "获取练习册知识点失败")
                        }
    }
}


//MARK:8   1-3 练习册 - 详情 - 参考答案
public func NetWorkTeacherGetTPeriodAnswers(params:[String:Any],callBack:((Array<Any>,Bool)->())?) ->  Void {
    
    var dataArr = [UrlModel]()
    Alamofire.request(kGet_TAllAnswersByWorkId,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(dataArr,false)
                                }
                                
                                let datas =  JSOnDictory["data"].arrayValue
                                
                                for index in 0..<datas.count {
                                    
                                    let json = datas[index]
                                    let model  = UrlModel.setValueForUrlModel(json: json)
                                    dataArr.append(model)
                                }
                                callBack!(dataArr,true)
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(dataArr,false)
                            setToast(str: "获取详情 - 参考答案失败")
                        }
    }
    
}

//MARK:9  1-3 练习册详情  - 成绩统计  >> 根据练习册id获取详情
public func NetWorkTeacherGetTStudentGrades(params:[String:Any],callBack:((Array<Any>,Bool)->())?) ->  Void {

    var dataArr = [TShowGradeModel]()
    Alamofire.request(kGet_TStudentWork5,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(dataArr,false)
                                }
                                
                                let datas =  JSOnDictory["data"].arrayValue
                                
                                for index in 0..<datas.count {
                                    
                                    let json = datas[index]
                                    let model  = TShowGradeModel.setValueForTMyWorkTShowGradeModel(json: json)
                                    dataArr.append(model)
                                }
                                callBack!(dataArr,true)
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(dataArr,false)
                            setToast(str: "获取详情 - 成绩统计失败")
                        }
    }
}


//MARK: 10   1-3-1  练习册 - 上传视频
public func NetWorkTeacherGetTWorkUploadVideo(params:[String:Any],callBack:((Bool)->())?) ->  Void {
    //    let dataArr = NSMutableArraRy()
    let mainQueue = DispatchQueue.main;
    
    Alamofire.request(kGet_TWorkVideo,
                      method: .post, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(false)
                                }else{
                                    callBack!(true)
                                }
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(false)
                            setToast(str: "上传视频失败")
                        }
    }
}


//MARK: 11   1-3-2 \ 2-2-2     （练习册 ，非练习册-上传图片）
func NetWorkTeacherUploadAnswerImages(
    params:[String:String]!,
    data: [UIImage],
    success : @escaping (_ response : [String : AnyObject])->(), failture : @escaping (_ error : Error)->()){
    
    //    let headers = ["content-type":"multipart/form-data"]
    
    Alamofire.upload(
        multipartFormData: { multipartFormData in
            
            multipartFormData.append((params["SESSIONID"]!.data(using: String.Encoding.utf8)!),
                                     withName: "SESSIONID")
            
            multipartFormData.append((params["mobileCode"]!.data(using: String.Encoding.utf8)!),
                                     withName: "mobileCode")
            
            multipartFormData.append((params["workId"]!.data(using: String.Encoding.utf8)!),
                                     withName: "workId")
            multipartFormData.append((params["date"]!.data(using: String.Encoding.utf8)!),
                                     withName: "date")
            
            for image in data {
                let data1 = UIImageJPEGRepresentation(image, 0.5)
                let temp = Int(arc4random()%1000000000)+Int(arc4random()%1000000000)
                let imageName = "Teacher/Answer_image\(temp)_image.png"
                multipartFormData.append(data1!, withName: "name", fileName: imageName, mimeType: "image/png")
            }
    },
        to: kAdd_TPic,
        headers: nil,
        encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    if let value = response.result.value as? [String: AnyObject]{
                        success(value)
                    }
                    
                    if response.result.value == nil {
                        success(["000":"000" as AnyObject])
                    }
                }
            case .failure(let encodingError):
                failture(encodingError)
            }
    }
    )
}


//MARK: 12   1-3-3  练习册  - 手动填写
public func NetWorkTeacherAddTWorkUploadContent(params:[String:Any],callBack:((Bool)->())?) ->  Void {
    let mainQueue = DispatchQueue.main;
    Alamofire.request(kAdd_TWorkContent,
                      method: .post, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(false)
                                }else{
                                    callBack!(true)
                                }
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(false)
                            setToast(str: "手动填写上传失败")
                        }
    }
}


//MARK: 13    1-3-4  练习册 - 上传知识点讲解
public func NetWorkTeacherAddTWorkUploadUploadPoints(params:[String:Any],callBack:((Bool)->())?) ->  Void {
    //    let dataArr = NSMutableArraRy()
    let mainQueue = DispatchQueue.main;
    
    Alamofire.request(kAdd_TWorkChapter,
                      method: .post, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(false)
                                }else{
                                    callBack!(true)
                                }
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(false)
                            setToast(str: "上传知识点讲解失败")
                        }
    }
}


//MARK: 14    1-3-5 练习册 - 学生往期成绩
public func NetWorkTeacherGetTScoresByStudentId(params:[String:Any],callBack:((Array<Any>,Bool)->())?) ->  Void {

    var dataArr = [TShowGradeModel]()
    Alamofire.request(kGet_TScoresByStudentId,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON{ (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(dataArr,false)
                                }
                                
                                let datas =  JSOnDictory["data"].arrayValue
                                
                                for index in 0..<datas.count {
                                    
                                    let json = datas[index]
                                    let model  = TShowGradeModel.setValueForTMyWorkTShowGradeModel(json: json)
                                    dataArr.append(model)
                                }
                                callBack!(dataArr,true)
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(dataArr,false)
                            setToast(str: "学生往期成绩失败")
                        }
    }
    
}


//MARK: 15  2-0 查询所有非练习册数据 (没有老师批改过的所有fei练习册)
public func NetWorkTeacherGetTAllNotWork(callBack:((Array<Any>,Bool)->())?) ->  Void {
    let params =
        ["SESSIONID":Defaults[userToken]!,
         "mobileCode":Defaults[mCode]!,
         ]
    var dataArr = [TNotWorkModel]()
    Alamofire.request(kGet_TAllNotWork,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(dataArr,false)
                                }
                                
                                let datas =  JSOnDictory["data"].arrayValue
                                
                                for index in 0..<datas.count {
                                    
                                    let json = datas[index]
                                    let model  = TNotWorkModel.setValueForTNotWorkModel(json: json)
                                    if model.correct_way == "2"{
                                        dataArr.append(model)
                                    }
                                }
                                callBack!(dataArr,true)
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(dataArr,false)
                            setToast(str: "获取非练习册失败")
                        }
    }
}


//MARK:16  2-1 查询所有非练习册数据 (属于自己的所有fei练习册，所有状态)
public func NetWorkTeacherGetTMyAllNotWork(params:[String:Any],callBack:((Array<Any>,Bool)->())?) ->  Void {
    
    var dataArr = [TNotWorkModel]()
    Alamofire.request(kGet_TMyAllNotWork,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(dataArr,false)
                                }
                                
                                let datas =  JSOnDictory["data"].arrayValue
                                
                                for index in 0..<datas.count {
                                    
                                    let json = datas[index]
                                    let model  = TNotWorkModel.setValueForTNotWorkModel(json: json)
                                    dataArr.append(model)
                                    deBugPrint(item: String(index)+"----->"+model.reason)
                                }
                                callBack!(dataArr,true)
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(dataArr,false)
                            setToast(str: "获取失败")
                        }
    }
    
}


//MARK:17  2-2 非练习册-详情 - 作业
public func NetWorkTeacherGetTMyNotWorkDatails(params:[String:Any],callBack:((Array<Any>,Bool)->())?) ->  Void {
    
    var dataArr = [TNotWorkDetailModel]()
    Alamofire.request(kGet_TMyNotWorkDatail,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(dataArr,false)
                                }
                                
                                let datas =  JSOnDictory["data"].arrayValue
                                
                                for index in 0..<datas.count {
                                    
                                    let json = datas[index]
                                    let model  = TNotWorkDetailModel.setValueForTNotWorkDetailModel(json: json)
                                    dataArr.append(model)
                                }
                                callBack!(dataArr,true)
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(dataArr,false)
                            setToast(str: "请求失败")
                        }
    }
    
}


//MARK:18  2-2    非练习册-详情-知识点讲解
public func NetWorkTeacherGetTMyNotWorkDatailPoints(params:[String:Any],callBack:((Array<Any>,Bool)->())?) ->  Void {
    
    var dataArr = [UrlModel]()
    Alamofire.request(kGet_TMyNotWorkDatail2,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON{ (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(dataArr,false)
                                    setToast(str: "获取数据失败")
                                }
                                
                                let datas =  JSOnDictory["data"].arrayValue
                                
                                for index in 0..<datas.count {
                                    
                                    let json = datas[index]
                                    let model  = UrlModel.setValueForUrlModel(json: json)
                                    dataArr.append(model)
                                }
                                callBack!(dataArr,true)
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(dataArr,false)
                            setToast(str: "请求失败")
                        }
    }
    
}

//MARK:19  2-2-1    非练习册-详情-参考答案
public func NetWorkTeacherGetTMyNotWorkDatailAnswers(params:[String:Any],callBack:((Array<Any>,Bool)->())?) ->  Void {

    var dataArr = [UrlModel]()
    Alamofire.request(kGet_anwersByteacher,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(dataArr,false)
                                    setToast(str: "获取数据失败")
                                }
                                
                                let datas =  JSOnDictory["data"].arrayValue
                                
                                for index in 0..<datas.count {
                                    
                                    let json = datas[index]
                                    let model  = UrlModel.setValueForUrlModel(json: json)
                                    dataArr.append(model)
                                }
                                callBack!(dataArr,true)
                            }
                            break
                        case .failure(let error):
                                deBugPrint(item: error)
                                callBack!(dataArr,false)
                                setToast(str: "请求失败")
                        }
    }
    
}


//MARK:20  2-2   非练习册-详情-成绩统计
public func NetWorkTeacherGetTMyNotWorkDatailGrades(params:[String:Any],callBack:((Array<Any>,Bool)->())?) ->  Void {
    
    var dataArr = [TShowGradeModel]()
    Alamofire.request(kGet_TMyNotWorkDatail4,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(dataArr,false)
                                    setToast(str: "获取数据失败")
                                }
                                
                                let datas =  JSOnDictory["data"].arrayValue
                                if datas.count == 0{
                                    setToast(str: JSOnDictory["message"].stringValue)
                                }
                                for index in 0..<datas.count {
                                    
                                    let json = datas[index]
                                    let model  = TShowGradeModel.setValueForTMyWorkTShowGradeModel(json: json)
                                    dataArr.append(model)
                                }
                                callBack!(dataArr,true)
                            }
                            break
                        case .failure(let error):
                                deBugPrint(item: error)
                                callBack!(dataArr,false)
                                setToast(str: "请求失败")
                        }
    }
    
}


//MARK:21  2-2-1    非练习册-详情-上传视频
public func NetWorkTeacherAddTNotWorkUploadVideo(params:[String:Any],callBack:((Bool)->())?) ->  Void {
    
    Alamofire.request(kAdd_TNotWorkVideo,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                let JSOnDictory = JSON(j)
                                
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(false)
                                    setToast(str: "上传视频失败")
                                }else{
                                    callBack!(true)
                                }
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(false)
                            setToast(str: "上传视频失败")
                        }
    }
    
}



//MARK:22  2-2-2    非练习册-详情-上传文件
public func NetWorkTeacherAddTNotWorkUploadFile(params:[String:String]!,
        data: [UIImage],
        vc:UIViewController,
        success : @escaping (_ response : [String : AnyObject])->(), failture : @escaping (_ error : Error)->()){
        vc.view.beginLoading()
        let headers = ["content-type":"multipart/form-data"]
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                
                multipartFormData.append((params["SESSIONID"]!.data(using: String.Encoding.utf8)!),
                                         withName: "SESSIONID")
                
                multipartFormData.append((params["mobileCode"]!.data(using: String.Encoding.utf8)!),
                                         withName: "mobileCode")
                
                multipartFormData.append((params["workId"]!.data(using: String.Encoding.utf8)!),
                                         withName: "workId")
                
                multipartFormData.append((params["money"]!.data(using: String.Encoding.utf8)!),
                                         withName: "money")
                
                for image in data {
                    let data1 = UIImageJPEGRepresentation(image, 0.5)
                    let temp = Int(arc4random()%1000000000)+Int(arc4random()%1000000000)
                    let imageName = "Teacher/NotWorkBookAnswer\(temp)_image.png"
                    multipartFormData.append(data1!, withName: "name"+imageName, fileName: imageName, mimeType: "image/png")
                }
                
        },
            to: kAdd_TNotWorkFile,
            headers: headers,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        if let value = response.result.value as? [String: AnyObject]{
                            success(value)
                        }
                        
                        if response.result.value == nil {
                            success(["000":"000" as AnyObject])
                        }
                    }
                    vc.view.endLoading()
                case .failure(let encodingError):
                    failture(encodingError)
                    vc.view.endLoading()
                }
        }
        )
    }


//MARK:23  2-2-3    非练习册-手动填写
public func NetWorkTeacherAddTNotWorkUploadContent(params:[String:Any],callBack:((Bool)->())?) ->  Void {
    
    Alamofire.request(kAdd_TNotWorkContent,
                      method: .post, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                let JSOnDictory = JSON(j)
                                
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(false)
                                    setToast(str: "上传答案失败")
                                }else{
                                    callBack!(true)
                                }
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(false)
                            setToast(str: "上传答案失败")
                        }
    }
    
}


//MARK:24  2-2-3    非练习册-上传知识点
public func NetWorkTeacherAddTNotWorkTheUploadPoints(params:[String:Any],callBack:((Bool)->())?) ->  Void {
    
    Alamofire.request(kAdd_TNotWorkChapter,
                      method: .post, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON{ (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                let JSOnDictory = JSON(j)
                                
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(false)
                                    setToast(str: "上传答案失败")
                                }else{
                                    callBack!(true)
                                }
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(false)
                            setToast(str: "上传答案失败")
                        }
    }
    
}


//MARK:*********************邓志辉接口*********************
//MARK:*********************邓志辉接口*********************
//MARK:*********************邓志辉接口*********************
//MARK:*********************邓志辉接口*********************
//MARK:*********************邓志辉接口*********************
//MARK:*********************邓志辉接口*********************


//MARK:4 老师第一次批改练习册
func NetWorkTeacherCorrectWrokBookFrist(
    params:[String:String]!,
    data: [UIImage],
    success : @escaping (_ response : [String : AnyObject])->(), failture : @escaping (_ error : Error)->()){
    
    //    let headers = ["content-type":"multipart/form-data"]
    
    Alamofire.upload(
        multipartFormData: { multipartFormData in
            
            multipartFormData.append((params["SESSIONID"]!.data(using: String.Encoding.utf8)!),
                                     withName: "SESSIONID")
            
            multipartFormData.append((params["mobileCode"]!.data(using: String.Encoding.utf8)!),
                                     withName: "mobileCode")
            
            multipartFormData.append((params["book_details_id"]!.data(using: String.Encoding.utf8)!),
                                     withName: "book_details_id")
            
            multipartFormData.append((params["scores"]!.data(using: String.Encoding.utf8)!),
                                     withName: "scores")
            
            multipartFormData.append((params["comment"]!.data(using: String.Encoding.utf8)!),
                                     withName: "comment")
            
            multipartFormData.append((params["student_id"]!.data(using: String.Encoding.utf8)!),
                                     withName: "student_id")
            
            multipartFormData.append((params["date"]!.data(using: String.Encoding.utf8)!),
                                     withName: "date")

            for image in data {
                let data1 = UIImageJPEGRepresentation(image, 0.5)
                let temp = Int(arc4random()%1000000000)+Int(arc4random()%1000000000)
                let imageName = "Teacher/WorkBook\(temp)_image.png"
                multipartFormData.append(data1!, withName: "name", fileName: imageName, mimeType: "image/png")
            }
            
    },
        to: kCorrect_WrokBook,
        headers: nil,
        encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    if let value = response.result.value as? [String: AnyObject]{
                        success(value)
                    }
                    
                    if response.result.value == nil {
                        success(["000":"000" as AnyObject])
                    }
                }
            case .failure(let encodingError):
                failture(encodingError)
            }
    }
    )
}


//MARK:5      照片模糊退回状态
public func NetWorkTeacherGobackWrokBook(params:[String:Any],callBack:((Bool)->())?) ->  Void {
    
//    地址改过  kgoback_WrokBook
    Alamofire.request(kGo_backWrokBookfei,
                      method: .post, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let code =  JSOnDictory["code"].stringValue
                                setToast(str: JSOnDictory["message"].stringValue)
                                if code == "0" {
                                    setToast(str: "练习册退回失败")
                                    callBack!(false)
                                }else{
                                    callBack!(true)
                                }
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(false)
                            setToast(str: "练习册退回失败")
                        }
    }
    
}


//MARK:6      第二次批改
func NetWorkTeacherCorrectNextWrokBook(
    params:[String:String]!,
    data: [UIImage],
    vc:UIViewController,
    success : @escaping (_ response : [String : AnyObject])->(), failture : @escaping (_ error : Error)->()){
    vc.view.beginLoading()
    let headers = ["content-type":"multipart/form-data"]
    
    Alamofire.upload(
        multipartFormData: { multipartFormData in
            
            multipartFormData.append((params["SESSIONID"]!.data(using: String.Encoding.utf8)!),
                                     withName: "SESSIONID")
            
            multipartFormData.append((params["mobileCode"]!.data(using: String.Encoding.utf8)!),
                                     withName: "mobileCode")
            
            multipartFormData.append((params["book_details_id"]!.data(using: String.Encoding.utf8)!),
                                     withName: "book_details_id")
            
            multipartFormData.append((params["scores"]!.data(using: String.Encoding.utf8)!),
                                     withName: "scores")
            
            multipartFormData.append((params["comment"]!.data(using: String.Encoding.utf8)!),
                                     withName: "comment")
            
            multipartFormData.append((params["student_id"]!.data(using: String.Encoding.utf8)!),
                                     withName: "student_id")

            for image in data {
                let data1 = UIImageJPEGRepresentation(image, 0.5)
                let temp = Int(arc4random()%1000000000)+Int(arc4random()%1000000000)
                let imageName = "Teacher/WorkBook\(temp)_image.png"
                multipartFormData.append(data1!, withName: "name", fileName: imageName, mimeType: "image/png")
            }
            
    },
        to: kCorrect_NextWrokBook,
        headers: headers,
        encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    if let value = response.result.value as? [String: AnyObject]{
                        success(value)
                    }
                    
                    if response.result.value == nil {
                        success(["000":"000" as AnyObject])
                    }
                }
                vc.view.endLoading()
            case .failure(let encodingError):
                failture(encodingError)
                vc.view.endLoading()
            }
    }
    )
}


//MARK:10      老师批改非练习册
func NetWorkTeacherNonExercise(
    params:[String:String]!,
    data: [UIImage],
    vc:UIViewController,
    success : @escaping (_ response : [String : AnyObject])->(), failture : @escaping (_ error : Error)->()){
    let headers = ["content-type":"multipart/form-data"]
    vc.view.beginLoading()
    Alamofire.upload(
        multipartFormData: { multipartFormData in
            
            multipartFormData.append((params["SESSIONID"]!.data(using: String.Encoding.utf8)!),
                                     withName: "SESSIONID")
            
            multipartFormData.append((params["mobileCode"]!.data(using: String.Encoding.utf8)!),
                                     withName: "mobileCode")
            
            multipartFormData.append((params["non_exercise_Id"]!.data(using: String.Encoding.utf8)!),
                                     withName: "non_exercise_Id")
            
            multipartFormData.append((params["scores"]!.data(using: String.Encoding.utf8)!),
                                     withName: "scores")
            
            multipartFormData.append((params["comment"]!.data(using: String.Encoding.utf8)!),
                                     withName: "comment")
            
            multipartFormData.append((params["student_id"]!.data(using: String.Encoding.utf8)!),
                                     withName: "student_id")
            
            for image in data {
                let data1 = UIImageJPEGRepresentation(image, 0.5)
                let temp = Int(arc4random()%1000000000)+Int(arc4random()%1000000000)
                let imageName = "Teacher/Non_WorkBook\(temp)_image.png"
                multipartFormData.append(data1!, withName: "Teacher/Non_WorkBook\(temp)_image1.png", fileName: imageName, mimeType: "image/png")
            }
            
    },
        to: kCorrect_NonExercise,
        headers: headers,
        encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    if let value = response.result.value as? [String: AnyObject]{
                        success(value)
                    }
                    
                    if response.result.value == nil {
                        success(["000":"000" as AnyObject])
                    }
                    vc.view.endLoading()
                }
            case .failure(let encodingError):
                failture(encodingError)
                vc.view.endLoading()
            }
    }
    )
}


//MARK:11      老师再次批改非练习册
func NetWorkTeacherNonExerciseNext(
    params:[String:String]!,
    data: [UIImage],
    vc:UIViewController,
    success : @escaping (_ response : [String : AnyObject])->(), failture : @escaping (_ error : Error)->()){
    let headers = ["content-type":"multipart/form-data"]
    vc.view.beginLoading()
    Alamofire.upload(
        multipartFormData: { multipartFormData in
            
            multipartFormData.append((params["SESSIONID"]!.data(using: String.Encoding.utf8)!),
                                     withName: "SESSIONID")
            
            multipartFormData.append((params["mobileCode"]!.data(using: String.Encoding.utf8)!),
                                     withName: "mobileCode")
            
            multipartFormData.append((params["non_exercise_Id"]!.data(using: String.Encoding.utf8)!),
                                     withName: "non_exercise_Id")
            
            multipartFormData.append((params["scores"]!.data(using: String.Encoding.utf8)!),
                                     withName: "scores")
            
            multipartFormData.append((params["comment"]!.data(using: String.Encoding.utf8)!),
                                     withName: "comment")

            multipartFormData.append((params["student_id"]!.data(using: String.Encoding.utf8)!),
                                     withName: "student_id")
            
            for image in data {
                let data1 = UIImageJPEGRepresentation(image, 0.5)
                let temp = Int(arc4random()%1000000000)+Int(arc4random()%1000000000)
                let imageName = "Teacher/Non_WorkBook_Next\(temp)_image.png"
                multipartFormData.append(data1!, withName: "Teacher/Non_WorkBook_Next\(temp)_image1.png", fileName: imageName, mimeType: "image/png")
            }
    },
        
        to: kCorrect_NonExerciseNext,
        headers: nil,
        encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    if let value = response.result.value as? [String: AnyObject]{
                        success(value)
                    }
                    if response.result.value == nil {
                        success(["000":"000" as AnyObject])
                    }
                    vc.view.endLoading()
                }
            case .failure(let encodingError):
                failture(encodingError)
                vc.view.endLoading()
            }
    }
    )
}


//MARK:13      解散班级
public func NetWorkTeacherDeleteMyclasses(params:[String:Any],callBack:((Bool)->())?) ->  Void {
    
    Alamofire.request(kDelete_Myclasses,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(false)
                                    setToast(str: "解散班级失败")
                                }else{
                                    callBack!(true)
                                }
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(false)
                            setToast(str: "解散班级失败")
                        }
    }
}


//MARK:14      老师申请加入班级
public func NetWorkTeacherTeacherAddToClasses(params:[String:Any],callBack:((Bool)->())?) ->  Void {
    
    Alamofire.request(kTeacher_AddToClasses,
                      method: .post, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(false)
                                    setToast(str: "申请失败")
                                }else{
                                    callBack!(true)
                                }
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(false)
                            setToast(str: "申请失败")
                        }
    }
}


//MARK:15      创建班级
public func NetWorkTeacherTeacherBulidClasses(params:[String:Any],callBack:((Bool)->())?) ->  Void {
    
    Alamofire.request(kTeacher_AddToClasses,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(false)
                                    setToast(str: "创建失败")
                                }else{
                                    callBack!(true)
                                }
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(false)
                            setToast(str: "创建失败")
                        }
    }
}

  

//MARK:16      查询每个班级的课时目录
public func NetWorkTeacherTeacherSelectAllPeriods(params:[String:Any],callBack:((Array<Any>,Bool)->())?) ->  Void {
    
    var dataArr = [TPeriodsModel]()
    Alamofire.request(kSelect_AllPeriods,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    setToast(str: "获取失败")
                                    callBack!(dataArr,false)
                                }
                                let datas =  JSOnDictory["data"].arrayValue
                                for index in 0..<datas.count {
                                    
                                    let json = datas[index]
                                    let model  = TPeriodsModel.setValueForTPeriodsModel(json: json)
                                    dataArr.append(model)
                                }
                                callBack!(dataArr,true)
                            }
                            break
                        case .failure(let error):
                           deBugPrint(item: error)
                            callBack!(dataArr,false)
                            setToast(str: "获取失败")
                        }
    }
}


//MARK:17      兴建课时名称
public func NetWorkTeacherTeacherBulidperiods(params:[String:Any],callBack:((Bool)->())?) ->  Void {
    
    Alamofire.request(kBulid_periods,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON{ (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    setToast(str: "上传失败")
                                    callBack!(false)
                                }else{
                                    callBack!(true)
                                }
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            setToast(str: "上传失败")
                            callBack!(false)
                        }
    }
}


//MARK:18      查询班级作业
public func NetWorkTeacherSelectClassBook(params:[String:Any],callBack:((Array<Any>,Bool)->())?) ->  Void {
    
    var dataArr = [TShowClassWorksModel]()
    Alamofire.request(kSelect_ClassBook,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(dataArr,false)
                                    setToast(str: "获取失败")
                                }
                                
                                let datas =  JSOnDictory["data"].arrayValue
                                for index in 0..<datas.count {
                                    
                                    let json = datas[index]
                                    let model  = TShowClassWorksModel.setValueForTShowClassWorksModel(json: json)
                                    if model.type == "2" || model.type == "5" {
                                        dataArr.append(model)
                                    }
                                }
                                callBack!(dataArr,true)

                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(dataArr,false)
                            setToast(str: "获取失败")
                        }
    }
}

//MARK:19      首次批改班级作业
func NetWorkTeacherCorrecClassBook(
    params:[String:String]!,
    data: [UIImage],
    success : @escaping (_ response : [String : AnyObject])->(), failture : @escaping (_ error : Error)->()){
    let headers = ["content-type":"multipart/form-data"]
    Alamofire.upload(
        multipartFormData: { multipartFormData in
            
            multipartFormData.append((params["SESSIONID"]!.data(using: String.Encoding.utf8)!),
                                     withName: "SESSIONID")
            
            multipartFormData.append((params["mobileCode"]!.data(using: String.Encoding.utf8)!),
                                     withName: "mobileCode")
            
            multipartFormData.append((params["class_book_id"]!.data(using: String.Encoding.utf8)!),
                                     withName: "class_book_id")
            
            multipartFormData.append((params["scores"]!.data(using: String.Encoding.utf8)!),
                                     withName: "scores")
            
            multipartFormData.append((params["comment"]!.data(using: String.Encoding.utf8)!),
                                     withName: "comment")
            
            multipartFormData.append((params["student_id"]!.data(using: String.Encoding.utf8)!),
                                     withName: "student_id")

            for image in data {
                let data1 = UIImageJPEGRepresentation(image, 0.5)
                let temp = Int(arc4random()%1000000000)+Int(arc4random()%1000000000)
                let imageName = "Teacher/Non_WorkBook\(temp)_image.png"
                multipartFormData.append(data1!, withName: "Teacher/Non_WorkBook\(temp)_image1.png", fileName: imageName, mimeType: "image/png")
            }
            
    },
        to: kCorrec_ClassBook,
        headers: headers,
        encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    if let value = response.result.value as? [String: AnyObject]{
                        success(value)
                    }
                    
                    if response.result.value == nil {
                        success(["000":"000" as AnyObject])
                    }
                    
                }
            case .failure(let encodingError):
                failture(encodingError)
            }
    }
    )
}


//MARK:20      再次批改班级作业
func NetWorkTeacherCorrectClassBookNext(
    params:[String:String]!,
    data: [UIImage],
    success : @escaping (_ response : [String : AnyObject])->(), failture : @escaping (_ error : Error)->()){
    let headers = ["content-type":"multipart/form-data"]
    Alamofire.upload(
        multipartFormData: { multipartFormData in
            
            multipartFormData.append((params["SESSIONID"]!.data(using: String.Encoding.utf8)!),
                                     withName: "SESSIONID")
            
            multipartFormData.append((params["mobileCode"]!.data(using: String.Encoding.utf8)!),
                                     withName: "mobileCode")
            multipartFormData.append((params["class_book_id"]!.data(using: String.Encoding.utf8)!),
                                     withName: "class_book_id")
            
            multipartFormData.append((params["scores"]!.data(using: String.Encoding.utf8)!),
                                     withName: "scores")
            
            multipartFormData.append((params["comment"]!.data(using: String.Encoding.utf8)!),
                                     withName: "comment")
            
            multipartFormData.append((params["student_id"]!.data(using: String.Encoding.utf8)!),
                                     withName: "student_id")
            
            for image in data {
                let data1 = UIImageJPEGRepresentation(image, 0.5)
                let temp = Int(arc4random()%1000000000)+Int(arc4random()%1000000000)
                let imageName = "Teacher/Non_WorkBook_Next\(temp)_image.png"
                multipartFormData.append(data1!, withName: "Teacher/Non_WorkBook_Next\(temp)_image1.png", fileName: imageName, mimeType: "image/png")
            }
            
    },
        to: kCorrec_ClassBookNext,
        headers: headers,
        encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    if let value = response.result.value as? [String: AnyObject]{
                        success(value)
                    }
                    
                    if response.result.value == nil {
                        success(["000":"000" as AnyObject])
                    }
                    
                }
            case .failure(let encodingError):
                failture(encodingError)
            }
    }
    )
}


//MARK:21     获取班级成员
public func NetWorkTeacherGetClassMember(params:[String:Any],callBack:((Array<Any>,Bool)->())?) ->  Void {
    
    var dataArr = [TClassMemberModel]()
    Alamofire.request(kGet_ClassMember,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON{ (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(dataArr,false)
                                    setToast(str: "获取失败")
                                }
                                
                                let datas =  JSOnDictory["data"]
                                let model  = TClassMemberModel.setValueForTClassMemberModel(json: datas)
                                dataArr.append(model)
                                callBack!(dataArr,true)
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(dataArr,false)
                            setToast(str: "获取失败")
                        }
    }
}


//MARK:22    我来批改
public func NetWorkTeacherBulidNonByTeacher(params:[String:Any],callBack:((Bool)->())?) ->  Void {
    
    Alamofire.request(kBulid_NonByTeacher,
                      method: .post, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    setToast(str: "添加失败")
                                    callBack!(false)
                                }else{
                                    callBack!(true)
                                }
                            }
                            
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(false)
                            setToast(str: "添加失败")
                        }
    }
    
}


//MARK:23   照片模糊退回状态
public func NetWorkTeacherGobackWrokBookFei(params:[String:Any],callBack:((Bool)->())?) ->  Void {
    
    Alamofire.request(kGo_backWrokBookfei,
                      method: .post, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let code =  JSOnDictory["code"].stringValue
                                setToast(str: JSOnDictory["message"].stringValue)
                                if code == "0" {
                                    callBack!(false)
                                }else{
                                    callBack!(true)
                                }
                            }
                            
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(false)
                        }
    }
    
}
  
  
  //MARK:23 老师获取练习册学生成绩，班级学生成绩（最近大课时），班级学生往期成绩列表，通用接口
  public func NetWorkTeacherGetStudentScroes(params:[String:Any],callBack:((Array<Any>,Bool)->())?) ->  Void {
    
    var dataArr = [TShowGradeModel]()
    Alamofire.request(kGet_StudentScroes,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON{ (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(dataArr,false)
                                    setToast(str: "获取失败")
                                }
                                
                                let datas =  JSOnDictory["data"].arrayValue
                                for index in 0..<datas.count {
                                    
                                    let json = datas[index]
                                    let model  = TShowGradeModel.setValueForTMyWorkTShowGradeModel(json: json)
                                    dataArr.append(model)
                                }
                                callBack!(dataArr,true)
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(dataArr,false)
                            setToast(str: "获取失败")
                        }
    }
  }
  
  //MARK:25 接口说明 ：  老师退出班级
  public func NetWorkTeachersOutOfClass(params:[String:Any],callBack:@escaping (Bool)->()) ->  Void {
    
    Alamofire.request(kGet_OutOfClass,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON{ (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack(false)
                                }else{
                                    callBack(true)
                                }
                                
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            setToast(str: "退出失败")
                        }
    }
  }

  
  
  
  
  
  
//MARK:(老师端  编辑资料)接口
  public func NetWorkTeachersEditorTeacher(params:[String:Any],callBack:@escaping (Bool)->()) ->  Void {
    
    Alamofire.request(kEditor_Teacher,
                      method: .post, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON{ (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack(false)
                                    setToast(str: "获取失败")
                                }else{
                                    callBack(true)
                                }
                                
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            setToast(str: "上传失败")
                        }
    }
  }


  //MARK:(老师端  编辑资料)接口
  func editorTeacherUpLoadImageRequest(
    params:[String:String]!,
    data: [UIImage],
    name: [String],
    success : @escaping (_ response : [String : AnyObject])->(), failture : @escaping (_ error : Error)->()){
    
    Alamofire.upload(
        multipartFormData: { multipartFormData in
            
            multipartFormData.append((params["SESSIONID"]!.data(using: String.Encoding.utf8)!),
                                     withName: "SESSIONID")
            multipartFormData.append((params["mobileCode"]!.data(using: String.Encoding.utf8)!),
                                     withName: "mobileCode")
            multipartFormData.append((params["type"]!.data(using: String.Encoding.utf8)!),
                                     withName: "type")

            for image in data {
                let data1 = UIImageJPEGRepresentation(image, 0.5)
                let temp = Int(arc4random()%1000000000)+Int(arc4random()%1000000000)
                let imageName = "teacher/User_Head_Icon/edit\(temp)_image.png"
                multipartFormData.append(data1!, withName: "teacher/User_Head_Icon/edit\(temp)_image1.png", fileName: imageName, mimeType: "image/png")
            }
            
    },
        to: kEditor_TeacherHelp,
        headers: nil,
        encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    if let value = response.result.value as? [String: AnyObject]{
                        success(value)
                        let json = JSON(value)
                        deBugPrint(item: json)
                        if json["code"] == "1" {
                        }
                    }
                    
                    if response.result.value == nil {
                        success(["000":"000" as AnyObject])
                    }
                    
                }
            case .failure(let encodingError):
                failture(encodingError)
            }
    }
    )
  }
  
  
  
  //MARK:获取消息详情（老师）
  public func NetWorkTeachersGetMsgDetailsTeacher(params:[String:Any],callBack:@escaping (Bool,String)->()) ->  Void {
    
    Alamofire.request(kGet_getMsgByTeacher,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON{ (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack(false,"")
                                    setToast(str: "获取失败")
                                }else{
                                    callBack(true,JSOnDictory["data"]["reason"].stringValue)
                                }
                                
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            setToast(str: "获取失败")
                            callBack(false,"")
                        }
    }
  }

  
  //MARK: 29    接口说明 ：     删除个别消息(通用接口)，传msgId则单删除，不传msgId,删除全部
  public func NetWorkTeachersDelMsgTeacher(params:[String:Any],callBack:@escaping (Bool)->()) ->  Void {
    
    Alamofire.request(kDel_Msg,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON{ (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack(false)
                                    setToast(str: "删除失败")
                                }else{
                                    callBack(true)
                                }
                                
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            setToast(str: "上传失败")
                        }
    }
  }
  
  
  //MARK: 34    接口说明 ： 创建班级通知
  public func NetWorkTeachersAddNotify(params:[String:Any],callBack:@escaping (Bool)->()) ->  Void {
    
    Alamofire.request(kAdd_Notify,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON{ (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack(false)
                                    setToast(str: "上传失败")
                                }else{
                                    callBack(true)
                                }
                                
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            setToast(str: "上传失败")
                        }
    }
  }

  
  //MARK: 35    接口说明 ： 获取班级通知
  public func NetWorkTeachersGetNotify(params:[String:Any],callBack:@escaping (String,Bool)->()) ->  Void {
    
    Alamofire.request(kGet_Notify,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON{ (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let code =  JSOnDictory["code"].stringValue
                                let text =  JSOnDictory["data"]["text"].stringValue
                                if code == "0" {
                                    callBack("",false)
                                    setToast(str: "上传失败")
                                }else{
                                    callBack(text,true)
                                }
                                
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack("",false)
                            setToast(str: "上传失败")
                        }
    }
  }

  
  //MARK: 36    接口说明 ：同意申请加入班级通用接口
  public func NetWorkTeachersApplyOkTeacher(params:[String:Any],callBack:@escaping (Bool)->()) ->  Void {
    
    Alamofire.request(kApply_Ok,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON{ (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack(false)
                                    setToast(str: "操作失败")
                                }else{
                                    callBack(true)
                                }
                                
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            setToast(str: "上传失败")
                        }
    }
  }
  
  
  //MARK: 38    接口说明 ：分别把老师和学生添加到班级
  public func NetWorkForInvitation(params:[String:Any],callBack:((Array<Any>,Bool)->())?) ->  Void {
    var dataArr = [ApplyModel]()
    Alamofire.request(kInvitation_Api,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let datas =  JSOnDictory["data"].arrayValue
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(dataArr,false)
                                    setToast(str: "请求失败")
                                }
                                for index in 0..<datas.count {
                                    
                                    let json = datas[index]
                                    
                                    let model  = ApplyModel.setValueForApplyModel(json: json)
                                    dataArr.append(model)
                                }
                                
                                callBack!(dataArr,true)
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(dataArr,false)
                            setToast(str: "请求失败")
                        }
    }
  }
  
  
  //MARK: 38    接口说明 ：分别把老师和学生添加到班级
  public func NetWorkTeachersAddToClass(params:[String:String],callBack:@escaping (Bool)->()) ->  Void {
    
    Alamofire.request(kAdd_ToClass,
                      method: .post, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON{ (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack(false)
                                    setToast(str: "操作失败")
                                }else{
                                    callBack(true)
                                }
                                
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            setToast(str: "上传失败")
                        }
    }
  }

  
  //MARK:39  课时内已批改的学生成绩,可以按名字或者学号搜索
  public func NetWorkTeacherGetCheckAgoCorrected(params:[String:Any],callBack:((Array<Any>,Bool)->())?) ->  Void {
    
    var dataArr = [TShowGradeModel]()
    Alamofire.request(kCheck_Ago,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(dataArr,false)
                                    setToast(str: "获取失败")
                                }
                                
                                let datas =  JSOnDictory["data"].arrayValue
                                
                                for index in 0..<datas.count {
                                    
                                    let json = datas[index]
                                    let model  = TShowGradeModel.setValueForTMyWorkTShowGradeModel(json: json)
                                    dataArr.append(model)
                                }
                                callBack!(dataArr,true)
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(dataArr,false)
                            setToast(str: "获取失败")
                        }
    }
  }
  
  
  //MARK:40    查询单个学生班级作业
  public func NetWorkTeacherGetClassBookList(params:[String:Any],callBack:((Array<Any>,Bool)->())?) ->  Void {
    
    var dataArr = [TShowClassWorksModel]()
    Alamofire.request(kGet_ClassBookList,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(dataArr,false)
                                    setToast(str: "获取失败")
                                }
                                
                                let datas =  JSOnDictory["data"].arrayValue
                                for index in 0..<datas.count {
                                    
                                    let json = datas[index]
                                    let model  = TShowClassWorksModel.setValueForTShowClassWorksModel(json: json)
                                    if model.type == "2" || model.type == "5" {
                                        dataArr.append(model)
                                    }
                                }
                                callBack!(dataArr,true)
                                
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(dataArr,false)
                            setToast(str: "获取失败")
                        }
    }
  }

  
  //MARK: 41   1-3-1  练习册 - 上传视频
  public func NetWorkTeacherUpLoadInClass(params:[String:Any],callBack:((Bool)->())?) ->  Void {
    
    Alamofire.request(kLoad_InClass,
                      method: .post, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(false)
                                }else{
                                    callBack!(true)
                                }
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(false)
                            setToast(str: "上传视频失败")
                        }
    }
  }

  
  //MARK:42 接口说明 ：  课时内上传课程讲义文件和作业
  public func NetWorkTeacherAddClassFiles(params:[String:String]!,
                                                  data: [UIImage],
                                                  vc:UIViewController,
                                                  success : @escaping (_ response : [String : AnyObject])->(), failture : @escaping (_ error : Error)->()){
    vc.view.beginLoading()
    let headers = ["content-type":"multipart/form-data"]
    
    Alamofire.upload(
        multipartFormData: { multipartFormData in
            
            multipartFormData.append((params["SESSIONID"]!.data(using: String.Encoding.utf8)!),
                                     withName: "SESSIONID")
            
            multipartFormData.append((params["mobileCode"]!.data(using: String.Encoding.utf8)!),
                                     withName: "mobileCode")
            
            multipartFormData.append((params["periods_id"]!.data(using: String.Encoding.utf8)!),
                                     withName: "periods_id")
            
            multipartFormData.append((params["money"]!.data(using: String.Encoding.utf8)!),
                                     withName: "money")
            
            multipartFormData.append((params["type"]!.data(using: String.Encoding.utf8)!),
                                     withName: "type")

            for image in data {
                let data1 = UIImageJPEGRepresentation(image, 0.5)
                let temp = Int(arc4random()%1000000000)+Int(arc4random()%1000000000)
                let imageName = "Teacher/Calss_video_Answer\(temp)_image.png"
                multipartFormData.append(data1!, withName: "name"+imageName, fileName: imageName, mimeType: "image/png")
            }
            
    },
        to: kLoad_InClassDoc,
        headers: headers,
        encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    if let value = response.result.value as? [String: AnyObject]{
                        success(value)
                    }
                    
                    if response.result.value == nil {
                        success(["000":"000" as AnyObject])
                    }
                }
                vc.view.endLoading()
            case .failure(let encodingError):
                failture(encodingError)
                vc.view.endLoading()
            }
    }
    )
  }

  
  
  //MARK:43  2-2-1    老师端获取自己上传过的课时内容
  public func NetWorkTeacherGetPreiodsByteacher(params:[String:Any],callBack:((Array<Any>,Bool)->())?) ->  Void {
    
    var dataArr = [UrlModel]()
    Alamofire.request(kGet_PreiodsByteacher,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(dataArr,false)
                                    setToast(str: "获取数据失败")
                                }
                                
                                let datas =  JSOnDictory["data"].arrayValue
                                
                                for index in 0..<datas.count {
                                    
                                    let json = datas[index]
                                    let model  = UrlModel.setValueForUrlModel(json: json)
                                    dataArr.append(model)
                                }
                                callBack!(dataArr,true)
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(dataArr,false)
                            setToast(str: "请求失败")
                        }
    }
    
  }

  
  
  //MARK: 44   接口说明 ： 班级编辑
  public func NetWorkTeacherEditoClasses(params:[String:Any],callBack:((Bool)->())?) ->  Void {
    
    Alamofire.request(kEditor_Classes,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(false)
                                }else{
                                    callBack!(true)
                                }
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(false)
                            setToast(str: "上传失败")
                        }
    }
  }

  
  
  //MARK:45.接口说明 ： 班级编辑辅助接口
  func editorTeacherEditoClassesHelp(
    params:[String:String]!,
    data: [UIImage],
    name: [String],
    success : @escaping (_ response : [String : AnyObject])->(), failture : @escaping (_ error : Error)->()){
    
    Alamofire.upload(
        multipartFormData: { multipartFormData in
            
            multipartFormData.append((params["SESSIONID"]!.data(using: String.Encoding.utf8)!),
                                     withName: "SESSIONID")
            multipartFormData.append((params["mobileCode"]!.data(using: String.Encoding.utf8)!),
                                     withName: "mobileCode")
            
            for image in data {
                let data1 = UIImageJPEGRepresentation(image, 0.5)
                let temp = Int(arc4random()%1000000000)+Int(arc4random()%1000000000)
                let imageName = "teacher/class_icon/edit\(temp)_image.png"
                multipartFormData.append(data1!, withName: "teacher/User_Head_Icon/edit\(temp)_image1.png", fileName: imageName, mimeType: "image/png")
            }
            
    },
        to: kEditor_ClassesHelp,
        headers: nil,
        encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    if let value = response.result.value as? [String: AnyObject]{
                        success(value)
                        let json = JSON(value)
                        deBugPrint(item: json)
                        if json["code"] == "1" {
                        }
                    }
                    
                    if response.result.value == nil {
                        success(["000":"000" as AnyObject])
                    }
                    
                }
            case .failure(let encodingError):
                failture(encodingError)
            }
    }
    )
  }

  
  
  //MARK: 48    接口说明 ：删除班级成员
  public func NetWorkTeachersDelclassPelTeacher(params:[String:Any],callBack:@escaping (Bool)->()) ->  Void {
    
    Alamofire.request(kDel_classPel,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON{ (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack(false)
                                    setToast(str: "操作失败")
                                }else{
                                    callBack(true)
                                }
                                
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            setToast(str: "上传失败")
                        }
    }
  }



//MARK:意见和建议
public func netWorkForSuggestion(params:[String:Any],callBack:((Bool)->())?) ->  Void {
    
    Alamofire.request(kAdd_Suggestion,
                      method: .post, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(false)
                                    setToast(str: "上传失败")
                                }else{
                                    callBack!(true)
                                    setToast(str: JSOnDictory["message"].stringValue)
                                }
                            }
                            
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(false)
                            setToast(str: "上传失败")
                        }
    }
    
}

//MARK:4-4消息中心
public func netWorkForGetMessages(params:[String:Any],callBack:((Array<Any>,Bool)->())?) ->  Void {
    var dataArr = [SMessageModel]()
    
    Alamofire.request(kGet_MsgbyTeacher,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(dataArr,false)
                                    setToast(str: "获取失败")
                                }
                                let datas =  JSOnDictory["data"].arrayValue
                                for index in 0..<datas.count {
                                    
                                    let json = datas[index]
                                    let model  = SMessageModel.setValueForSMessageModel(json: json)
                                    dataArr.append(model)
                                }
                                callBack!(dataArr,true)
                            }
                            break
                        case .failure(let error):
                            callBack!(dataArr,false)
                            setToast(str: "获取失败")
                        }
    }
    
}


  //MARK:22(学生端 再次提交非练习册练习)接口
  public func netWorkForInsertClasses(
    params:[String:String]!,
    data: [UIImage],
    name: [String],
    success : @escaping (_ response : [String : AnyObject])->(), failture : @escaping (_ error : Error)->()){
    
    let headers = ["content-type":"multipart/form-data"]
    Alamofire.upload(
        multipartFormData: { multipartFormData in
            
            multipartFormData.append((params["SESSIONID"]!.data(using: String.Encoding.utf8)!),
                                     withName: "SESSIONID")
            
            multipartFormData.append((params["mobileCode"]!.data(using: String.Encoding.utf8)!),
                                     withName: "mobileCode")
            
            multipartFormData.append((params["class_name"]!.data(using: String.Encoding.utf8)!),
                                     withName: "class_name")
            
            multipartFormData.append((params["periods"]!.data(using: String.Encoding.utf8)!),
                                     withName: "periods")
            
            multipartFormData.append((params["delivery_cycle"]!.data(using: String.Encoding.utf8)!),
                                     withName: "delivery_cycle")
            
            multipartFormData.append((params["work_times"]!.data(using: String.Encoding.utf8)!),
                                     withName: "work_times")
            
            multipartFormData.append((params["deadline"]!.data(using: String.Encoding.utf8)!),
                                     withName: "deadline")
            
            multipartFormData.append((params["teachers"]!.data(using: String.Encoding.utf8)!),
                                     withName: "teachers")
            
            multipartFormData.append((params["teachers_help"]!.data(using: String.Encoding.utf8)!),
                                     withName: "teachers_help")
            
            multipartFormData.append((params["students"]!.data(using: String.Encoding.utf8)!),
                                     withName: "students")
            
            for i in 0..<data.count {
                let temp = Int(arc4random()%1000000000)+Int(arc4random()%1000000000)
                multipartFormData.append(UIImagePNGRepresentation(data[i])!, withName: "Student/Not_WorkBook_Next\(temp)_image\(i).png", fileName: "Student/Not_WorkBook_Nextii\(temp)_image\(i).png", mimeType: "image/png")
            }
    },
        to: kBulidClasses,
        headers: headers,
        encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    if let value = response.result.value as? [String: AnyObject]{
                        success(value)
                        let json = JSON(value)
                        deBugPrint(item: json)
                        if json["code"].stringValue == "0" {
                            setToast(str: "创建失败")
                        }
                        
                    }
                    
                    if response.result.value == nil {
                        success(["000":"000" as AnyObject])
                    }
                    
                }
            case .failure(let encodingError):
                failture(encodingError)
            }
    }
    )
  }


//MARK:(老师端4-3-1添加好友)接口
public func netWorkForInsertFriends(params:[String:Any],callBack:((Bool)->())?) ->  Void {
    //    let dataArr = NSMutableArraRy()
    
    Alamofire.request(kInsert_Friend,
                      method: .post, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(false)
                                    setToast(str: "发送请求失败")
                                }else{
                                    callBack!(true)
                                }
                            }
                            break
                        case .failure(let error):
                           deBugPrint(item: error)
                            callBack!(false)
                            setToast(str: "发送请求失败")
                        }
    }
}





//MARK: *****************学生端接口**************
//MARK: *****************学生端接口**************
//MARK: *****************学生端接口**************
//MARK: *****************学生端接口**************
//MARK: *****************学生端接口**************


//MARK:(学生端获取所有的练习册)接口
public func netWorkForGetAllWorkBook(callBack:((Array<Any>,Bool)->())?) -> Void {
    
    var dataArr = [WorkBookModel]()
    let params =
        ["SESSIONID":Defaults[userToken]!,
         "mobileCode":Defaults[mCode]!
            ]
    Alamofire.request(kGet_AllWorkBook,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:                            
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(dataArr,false)
                                    setToast(str: "获取失败")
                                }
                                let datas =  JSOnDictory["data"].arrayValue
                                
                                for index in 0..<datas.count {
                                    
                                    let json = datas[index]
                                    let model  = WorkBookModel.setValueForWorkBookModel(json: json)
                                    if model.isFollow == "false" {
                                        dataArr.append(model)
                                    }
                                }
                                callBack!(dataArr,true)
                            }

                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            setToast(str: "获取所有的练习册失败")
                            callBack!(dataArr,false)
                        }
    }
    
}

//MARK:(学生端搜索练习册)接口
public func netWorkForSearchWorkBook(params:[String:Any],callBack:((Array<Any>,Bool)->())?) ->  Void {
    //    let dataArr = NSMutableArraRy()
    var dataArr = [WorkBookModel]()
    Alamofire.request(kGet_AllWorkBook,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON{ (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let datas =  JSOnDictory["data"].arrayValue
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(dataArr,false)
                                    setToast(str: "搜索失败")
                                }

                                for index in 0..<datas.count {
                                    
                                    let json = datas[index]
                                    let model  = WorkBookModel.setValueForWorkBookModel(json: json)
                                    dataArr.append(model)
                                }
                                callBack!(dataArr,true)
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(dataArr,false)
                            setToast(str: "搜索失败")
                        }
    }
    
}


//MARK:(学生端  添加练习册)接口
public func netWorkForAddWorkBookToMe(params:[String:Any],callBack:((Bool)->())?) ->  Void {
    //    let dataArr = NSMutableArraRy()
    
    Alamofire.request(kAdd_WorkBookToMe,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(false)
                                    setToast(str: "添加练习册失败")
                                }else{
                                    callBack!(true)
                                }
                            }
                            callBack!(true)
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(false)
                            setToast(str: "添加练习册失败")
                        }
    }
    
}


//MARK:(学生端  我的练习册)接口
public func netWorkForMyWorkBook(callBack:((Array<Any>,Bool)->())?) ->  Void {
    
    var dataArr = [WorkBookModel]()
    let dic = ["SESSIONID":Defaults[userToken]!,
               "mobileCode":Defaults[mCode]!]
    Alamofire.request(kMy_WorkBook,
                      method: .get, parameters: dic,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:                            
                            
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let datas =  JSOnDictory["data"].arrayValue
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(dataArr,false)
                                    setToast(str: "获取失败")
                                }
                                
                                for index in 0..<datas.count {
                                    
                                    let json = datas[index]

                                    let model  = WorkBookModel.setValueForWorkBookModel(json: json)
                                    dataArr.append(model)
                                }
                                
                                callBack!(dataArr,true)
                            }
                            
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(dataArr,false)
                            setToast(str: "获取失败")
                        }
    }
    
}


//MARK:(学生端  删除我的练习册)接口
public func netWorkForDeleteMyWorkBook(params:[String:Any],callBack:((Bool)->())?) ->  Void {
    //    let dataArr = NSMutableArraRy()
    
    Alamofire.request(kDelete_MyWorkBook,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(false)
                                    setToast(str: "删除失败")
                                }else{
                                    callBack!(true)
                                }
                            }
                            break
                        case .failure(let error):
                            callBack!(false)
                            setToast(str: "删除失败")
                        }
    }
    
}


//MARK:(学生端  上传图片到练习册)接口
func netWorkForUploadWorkBook(
    params:[String:String]!,
    data: [UIImage],
    name: [String],
    success : @escaping (_ response : [String : AnyObject])->(), failture : @escaping (_ error : Error)->()){
    
    //    let headers = ["content-type":"multipart/form-data"]
    
    Alamofire.upload(
        multipartFormData: { multipartFormData in
            
            multipartFormData.append((params["SESSIONID"]!.data(using: String.Encoding.utf8)!),
                                     withName: "SESSIONID")
            
            multipartFormData.append((params["mobileCode"]!.data(using: String.Encoding.utf8)!),
                                     withName: "mobileCode")
            
            multipartFormData.append((params["result"]!.data(using: String.Encoding.utf8)!),
                                     withName: "result")

            multipartFormData.append((params["userWorkBookId"]!.data(using: String.Encoding.utf8)!),
                                     withName: "userWorkBookId")
            
            for image in data {
                let data1 = UIImageJPEGRepresentation(image, 0.5)
                let temp = Int(arc4random()%1000000000)+Int(arc4random()%1000000000)
                let imageName = "Student/WorkBook\(temp)_image.png"
                multipartFormData.append(data1!, withName: "Student/WorkBook\(temp)_image1.png", fileName: imageName, mimeType: "image/png")
            }
    },
        to: kUpload_WorkBook,
        headers: nil,
        encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    if let value = response.result.value as? [String: AnyObject]{
                        success(value)
                    }
                    
                    if response.result.value == nil {
                        success(["000":"defeat" as AnyObject])
                    }
                    
                }
            case .failure(let encodingError):
                failture(encodingError)
            }
    }
    )
}


//MARK:(学生端  再次上传图片到练习册)接口
func netWorkForUploadWorkBookNext(
    params:[String:String]!,
    data: [UIImage],
    name: [String],
    success : @escaping (_ response : [String : AnyObject])->(), failture : @escaping (_ error : Error)->()){
    let headers = ["content-type":"multipart/form-data"]
    Alamofire.upload(
        multipartFormData: { multipartFormData in
            
            multipartFormData.append((params["SESSIONID"]!.data(using: String.Encoding.utf8)!),
                                     withName: "SESSIONID")
            
            multipartFormData.append((params["mobileCode"]!.data(using: String.Encoding.utf8)!),
                                     withName: "mobileCode")
           
            if params.keys.contains("book_details_id") {
                multipartFormData.append((params["book_details_id"]!.data(using: String.Encoding.utf8)!),
                                         withName: "book_details_id")
            }
            
//            if params.keys.contains("workBookId") {
//                multipartFormData.append((params["workBookId"]!.data(using: String.Encoding.utf8)!),
//                                         withName: "workBookId")
//            }

            

            for image in data {
                let data1 = UIImageJPEGRepresentation(image, 0.5)
                let temp = Int(arc4random()%1000000000)+Int(arc4random()%1000000000)
                let imageName = "Student/WorkBook/Next\(temp)_image.png"
                multipartFormData.append(data1!, withName: "Student/WorkBook/Next\(temp)_image1.png", fileName: imageName, mimeType: "image/png")
            }
    },
        to: kUpload_WorkBookNext,
        headers: headers,
        encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    if let value = response.result.value as? [String: AnyObject]{
                        success(value)
                    }
                    
                    if response.result.value == nil {
                        success(["000":"defeat" as AnyObject])
                    }
                    
                }
            case .failure(let encodingError):
                failture(encodingError)
            }
    }
    )
}

  
  
  //MARK:38   练习册和非练习册，班级作业退回后重新上传通用接口
  func netWorkForUploadWorkBookSecondBulidBook(
    params:[String:String]!,
    data: [UIImage],
    name: [String],
    success : @escaping (_ response : [String : AnyObject])->(), failture : @escaping (_ error : Error)->()){
    let headers = ["content-type":"multipart/form-data"]
    Alamofire.upload(
        multipartFormData: { multipartFormData in
            
            multipartFormData.append((params["SESSIONID"]!.data(using: String.Encoding.utf8)!),
                                     withName: "SESSIONID")
            
            multipartFormData.append((params["mobileCode"]!.data(using: String.Encoding.utf8)!),
                                     withName: "mobileCode")
            
            
            multipartFormData.append((params["bookId"]!.data(using: String.Encoding.utf8)!),
                                         withName: "bookId")
            
            if params.keys.contains("type") {
                multipartFormData.append((params["type"]!.data(using: String.Encoding.utf8)!),
                                         withName: "type")
            }
            
            
            
            for image in data {
                let data1 = UIImageJPEGRepresentation(image, 0.5)
                let temp = Int(arc4random()%1000000000)+Int(arc4random()%1000000000)
                let imageName = "Student/WorkBook/Next\(temp)_image.png"
                multipartFormData.append(data1!, withName: "Student/WorkBook/Next\(temp)_image1.png", fileName: imageName, mimeType: "image/png")
            }
    },
        to: kSecond_BulidBook,
        headers: headers,
        encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    if let value = response.result.value as? [String: AnyObject]{
                        success(value)
                    }
                    
                    if response.result.value == nil {
                        success(["000":"defeat" as AnyObject])
                    }
                    
                }
            case .failure(let encodingError):
                failture(encodingError)
            }
    }
    )
  }

  
//MARK:(学生端  获取用户练习册详情)接口
public func netWorkForGetWorkBookByTime(params:[String:Any],callBack:((Array<Any>,Bool)->())?) ->  Void {
    
    var dataArr = [BookDetailModel]()
    
    Alamofire.request(kGetWork_BookByTime,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(dataArr,false)
                                    setToast(str: "获取失败")
                                }

                                let model  = BookDetailModel.setValueForBookDetailModel(json: JSOnDictory["data"])
                                    dataArr.append(model)
                                
                                callBack!(dataArr,true)
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(dataArr,false)
                            setToast(str: "获取失败")
                        }
    }
    
}


//MARK:(学生端  用户根据时间查询该练习册详情的日期)接口
public func netWorkForGetWorkBookTime(params:[String:Any],callBack:((Array<Any>,Bool)->())?) ->  Void {
    
    var dataArr = [String]()
    Alamofire.request(kGetWork_BookTime,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(dataArr,false)
                                    setToast(str: "获取日期失败")
                                }

                                let datas =  JSOnDictory["data"].arrayValue

                                for index in 0..<datas.count {
                                    let json = datas[index]
                                    let str = json.stringValue
                                    dataArr.append(str)
                                }
                                callBack!(dataArr,true)
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(dataArr,false)
                            setToast(str: "获取日期失败")
                        }
    }
}


//MARK:(学生端  投诉)接口
public func netWorkForBulidComplaint(params:[String:Any],callBack:((Bool)->())?) ->  Void {
    //    let dataArr = NSMutableArraRy()
    
    Alamofire.request(kBulid_Complaint,
                      method: .post, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON{ (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(false)
                                    setToast(str: "投诉失败")
                                }else{
                                    callBack!(true)
                                }
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(false)
                            setToast(str: " 投诉失败")
                            callBack!(false)
                        }
    }
    
}


//MARK:8(学生端  新建练习册)接口
func netWorkForBulidWrokBook(
    params:[String:String]!,
    data: [UIImage],
    name: [String],
    success : @escaping (_ response : [String : AnyObject])->(), failture : @escaping (_ error : Error)->()){
    
    //    let headers = ["content-type":"multipart/form-data"]
    
    Alamofire.upload(
        multipartFormData: { multipartFormData in
            
            multipartFormData.append((params["SESSIONID"]!.data(using: String.Encoding.utf8)!),
                                     withName: "SESSIONID")
            
            multipartFormData.append((params["mobileCode"]!.data(using: String.Encoding.utf8)!),
                                     withName: "mobileCode")
            multipartFormData.append((params["work_book_name"]!.data(using: String.Encoding.utf8)!),
                                     withName: "work_book_name")
            
            multipartFormData.append((params["subject_id"]!.data(using: String.Encoding.utf8)!),
                                     withName: "subject_id")
            
            multipartFormData.append((params["classes_id"]!.data(using: String.Encoding.utf8)!),
                                     withName: "classes_id")
            
            multipartFormData.append((params["edition_id"]!.data(using: String.Encoding.utf8)!),
                                     withName: "edition_id")
            
            multipartFormData.append((params["type"]!.data(using: String.Encoding.utf8)!),
                                     withName: "type")

            for image in data {
                let data1 = UIImageJPEGRepresentation(image, 0.5)
                let temp = Int(arc4random()%1000000000)+Int(arc4random()%1000000000)
                let imageName = "student/New_WorkBook\(temp)_image.png"
                multipartFormData.append(data1!, withName: "student/New_WorkBook\(temp)_image1.png", fileName: imageName, mimeType: "image/png")
            }
    },
        to: kBulid_WrokBook,
        headers: nil,
        encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    if let value = response.result.value as? [String: AnyObject]{
                        success(value)
                    }
                    
                    if response.result.value == nil {
                        success(["000":"000" as AnyObject])
                    }
                    
                }
            case .failure(let encodingError):
                failture(encodingError)
            }
    }
    )
}



//MARK:(学生端  我的资料)接口
public func netWorkForMyData(params:[String:String],callBack:((Array<Any>,Bool)->())?) ->  Void {

    var dataArr = [PersonalModel]()
    Alamofire.request(kMy_Data,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let datas =  JSOnDictory["data"].arrayValue
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(dataArr,false)
//                                    setToast(str: "获取资料失败")
                                }else{
                                    
                                    for index in 0..<datas.count {
                                        
                                        let json = datas[index]
                                        
                                        let model  = PersonalModel.setValueForPersonalModel(json: json)
                                        dataArr.append(model)
                                    }
                                    callBack!(dataArr,true)
                                }
                            }
                                break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(dataArr,false)
//                            setToast(str: "获取资料失败")
                        }
    }
    
}


//MARK:(学生端  编辑资料)接口
func editorStudentUpLoadImageRequest(
                        params:[String:String]!,
                        data: [UIImage],
                        name: [String],
                        success : @escaping (_ response : [String : AnyObject])->(), failture : @escaping (_ error : Error)->()){
    
//    let headers = ["content-type":"multipart/form-data"]
    
    Alamofire.upload(
        multipartFormData: { multipartFormData in
            
            multipartFormData.append((params["SESSIONID"]!.data(using: String.Encoding.utf8)!),
                                     withName: "SESSIONID")
            multipartFormData.append((params["mobileCode"]!.data(using: String.Encoding.utf8)!),
                                     withName: "mobileCode")
            multipartFormData.append((params["phone"]!.data(using: String.Encoding.utf8)!),
                                     withName: "phone")
            multipartFormData.append((params["idea"]!.data(using: String.Encoding.utf8)!),
                                     withName: "idea")
            multipartFormData.append((params["grade"]!.data(using: String.Encoding.utf8)!),
                                     withName: "grade")
//            for i in 0..<data.count {
//                multipartFormData.append(UIImagePNGRepresentation(data[i])!, withName: "appPhoto", fileName: name[i], mimeType: "image/png")
//            }
            
            for image in data {
                let data1 = UIImageJPEGRepresentation(image, 0.5)
                let temp = Int(arc4random()%1000000000)+Int(arc4random()%1000000000)
                let imageName = "Student/User_Head_Icon/edit\(temp)_image.png"
                multipartFormData.append(data1!, withName: "Student/User_Head_Icon/edit\(temp)_image1.png", fileName: imageName, mimeType: "image/png")
            }
            
    },
        to: kEditor_Student,
        headers: nil,
        encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    if let value = response.result.value as? [String: AnyObject]{
                        success(value)
                        let json = JSON(value)
                        deBugPrint(item: json)
                        if json["code"].stringValue == "1" {
                        }
                    }
                    
                    if response.result.value == nil {
                        success(["000":"000" as AnyObject])
                    }
                    
                }
            case .failure(let encodingError):
                failture(encodingError)
            }
    }
    )
}


//MARK:(学生端 查询我的学币使用)接口
public func netWorkForMyCoin(callBack:((Array<Any>,String,Bool)->())?) ->  Void {
    
    var dataArr = [AccountModel]()
    let params = [
        "SESSIONID":Defaults[userToken]!,
        "mobileCode":Defaults[mCode]!
    ]
    
    Alamofire.request(kMy_Coin,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let datas =  JSOnDictory["data"]["coin"].arrayValue
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(dataArr,"",false)
                                    setToast(str: "获取学币失败")
                                }

                                for index in 0..<datas.count {
                                    
                                    let json = datas[index]
                                    
                                    let model  = AccountModel.setValueForAccountModel(json: json)
                                    dataArr.append(model)
                                }
                                
                                callBack!(dataArr,JSOnDictory["data"]["sumCoin"].stringValue,true)
                            }
                            
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(dataArr,"",false)
                            setToast(str: "获取学币失败")
                        }
    }
    
}


//MARK:(学生端  查询指定)接口
public func netWorkForGetSpecifiedUser(params:[String:String],callBack:((Array<Any>,Bool)->())?) ->  Void {
    
    var dataArr = [FriendsModel]()
    Alamofire.request(kGet_AllPeope,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:

                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let datas =  JSOnDictory["data"]["AllPeope"].arrayValue
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(dataArr,false)
                                    setToast(str: "查找失败")
                                }
                                for index in 0..<datas.count {
                                    
                                    let json = datas[index]
                                    
                                    let model  = FriendsModel.setValueForFriendsModel(json: json)
                                    if model.isFriend == "false" && model.user_num != Defaults[userNum]{
                                        dataArr.append(model)
                                    }
                                }
                                if dataArr.count == 0 {
                                     setToast(str: "未找到该用户")
                                }
                                callBack!(dataArr,true)
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            setToast(str: "查找失败")
                            callBack!(dataArr,false)
                        }
    }
}

//MARK:(学生端  查询所有用户)接口
public func netWorkForGetAllPeope(callBack:((Array<Any>,Bool)->())?) ->  Void {
    
    var dataArr = [FriendsModel]()
    let params = [
        "SESSIONID":Defaults[userToken]!,
        "mobileCode":Defaults[mCode]!
    ]
    Alamofire.request(kGet_AllPeope,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
               
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let datas =  JSOnDictory["data"]["AllPeope"].arrayValue
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(dataArr,false)
                                    setToast(str: "查找失败")
                                }
                                for index in 0..<datas.count {
                                    
                                    let json = datas[index]
                                    
                                    let model  = FriendsModel.setValueForFriendsModel(json: json)
                                    dataArr.append(model)
                                }
                                
                                callBack!(dataArr,true)
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(dataArr,false)
                            setToast(str: "查找失败")
                        }
    }
}


//MARK:(学生端 申请成为好友)接口
public func netWorkForApplyFriend(params:[String:String],callBack:((Bool)->())?) ->  Void {
    //    let dataArr = NSMutableArraRy()
    Alamofire.request(kApply_Friend,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(false)
                                    setToast(str: "发送申请失败")
                                }else{
                                    callBack!(true)
                                }
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            
                            setToast(str: "发送申请失败")
                            callBack!(false)
                        }
    }

}


//MARK:14(学生端 查看好友申请表)接口
public func netWorkForApplyList(callBack:((Array<Any>,Bool)->())?) {
    
    let params = [
        "SESSIONID":Defaults[userToken]!,
        "mobileCode":Defaults[mCode]!
    ]
    var dataArr = [ApplyModel]()
    Alamofire.request(kApply_List,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let datas =  JSOnDictory["data"].arrayValue
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(dataArr,false)
                                    setToast(str: "请求失败")
                                }

                                for index in 0..<datas.count {
                                    
                                    let json = datas[index]
                                    
                                    let model  = ApplyModel.setValueForApplyModel(json: json)
                                    dataArr.append(model)
                                }
                                
                                if datas.count == 0 {
                                    setToast(str: JSOnDictory["message"].stringValue)
                                    callBack!(dataArr,false)
                                }else{
                                    callBack!(dataArr,true)
                                }
                                
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(dataArr,false)
                            setToast(str: "请求失败")
                        }
    }
}


//MARK:15(学生端 对请求进行操作)接口
public func netWorkForDoAllow(params:[String:Any],callBack:((Bool)->())?) ->  Void {
    //    let dataArr = NSMutableArraRy()
    
    Alamofire.request(kDo_Allow,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(false)
                                    setToast(str: "请求失败")
                                }else{

                                    callBack!(true)
                                }

                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(false)
                            setToast(str: "请求失败")
                            callBack!(false)
                        }
    }
}


//MARK:17(学生端 我的好友并按类型区分)接口
public func netWorkForMyFriend(callBack:((Array<Any>,Bool)->())?) ->  Void {
    let params = [
        "SESSIONID":Defaults[userToken]!,
        "mobileCode":Defaults[mCode]!
    ]
    var dataArr = [ApplyModel]()
    Alamofire.request(kMy_Friend,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let datas =  JSOnDictory["data"].arrayValue
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(dataArr,false)
                                    setToast(str: "请求失败")
                                }
                                for index in 0..<datas.count {
                                    
                                    let json = datas[index]
                                    
                                    let model  = ApplyModel.setValueForApplyModel(json: json)
                                    dataArr.append(model)
                                }
                                
                                callBack!(dataArr,true)
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(dataArr,false)
                            setToast(str: "请求失败")
                        }
    }
}


//MARK:18(学生端 删除我的好友)接口
public func netWorkForDelMyFriend(params:[String:String],callBack:((Bool)->())?) ->  Void {
    //    let dataArr = NSMutableArraRy()
    
    Alamofire.request(kdel_MyFriend,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let datas =  JSOnDictory["code"].stringValue
                                if datas == "0" {
                                    callBack!(false)
                                    setToast(str: "删除好友失败")
                                }else{
                                    callBack!(false)
                                }
                            }
                            
                            callBack!(true)
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            setToast(str: "删除好友失败")
                            callBack!(false)
                        }
    }
}


//MARK:20(学生端 创建非练习册的时候需要选择好友老师批改)接口
public func netWorkForModle_exercise(params:[String:Any],callBack:((Bool)->())?) ->  Void {
    //    let dataArr = NSMutableArraRy()
    Alamofire.request(kModle_exercise,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let datas =  JSOnDictory["code"].stringValue
                                if datas == "0" {
                                }
                            }
                            callBack!(true)
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            
                            setToast(str: "选择好友老师失败")
                            callBack!(false)
                        }
    }
}


//MARK:21(学生端 创建非练习册)接口
func netWorkForBulidnon_exercise(
    params:[String:String]!,
    data: [UIImage],
    name: [String],
    success : @escaping (_ response : [String : AnyObject])->(), failture : @escaping (_ error : Error)->()){
    
    let headers = ["content-type":"multipart/form-data"]
    Alamofire.upload(
        multipartFormData: { multipartFormData in
            
            multipartFormData.append((params["SESSIONID"]!.data(using: String.Encoding.utf8)!),
                                     withName: "SESSIONID")
            
            multipartFormData.append((params["mobileCode"]!.data(using: String.Encoding.utf8)!),
                                     withName: "mobileCode")
            
            multipartFormData.append((params["non_exercise_name"]!.data(using: String.Encoding.utf8)!),
                                     withName: "non_exercise_name")
            
            multipartFormData.append((params["correct_way"]!.data(using: String.Encoding.utf8)!),
                                     withName: "correct_way")
            
            multipartFormData.append((params["rewards"]!.data(using: String.Encoding.utf8)!),
                                     withName: "rewards")
            
            multipartFormData.append((params["classes_id"]!.data(using: String.Encoding.utf8)!),
                                     withName: "classes_id")
            
            multipartFormData.append((params["subject_id"]!.data(using: String.Encoding.utf8)!),
                                     withName: "subject_id")
            
            multipartFormData.append((params["freind_id"]!.data(using: String.Encoding.utf8)!),
                                     withName: "freind_id")

            for i in 0..<data.count {
                let temp = Int(arc4random()%1000000000)+Int(arc4random()%1000000000)
                multipartFormData.append(UIImagePNGRepresentation(data[i])!, withName: "Student/Not_WorkBook_Next\(temp)_image\(i).png", fileName: "Student/Not_WorkBook_Nextii\(temp)_image\(i).png", mimeType: "image/png")
            }
    },
        to: kBulidnon_exercise,
        headers: headers,
        encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    if let value = response.result.value as? [String: AnyObject]{
                        success(value)
                        let json = JSON(value)
                        deBugPrint(item: json)
                        if json["code"] == "1" {
                        }
                    }
                    
                    if response.result.value == nil {
                        success(["000":"000" as AnyObject])
                    }
                    
                }
            case .failure(let encodingError):
                failture(encodingError)
            }
    }
    )
}



//MARK:22(学生端 再次提交非练习册练习)接口
public func netWorkForAddNonExerciseNext(
    params:[String:String]!,
    data: [UIImage],
    name: [String],
    success : @escaping (_ response : [String : AnyObject])->(), failture : @escaping (_ error : Error)->()){
    
    let headers = ["content-type":"multipart/form-data"]
    Alamofire.upload(
        multipartFormData: { multipartFormData in
            
            multipartFormData.append((params["SESSIONID"]!.data(using: String.Encoding.utf8)!),
                                     withName: "SESSIONID")
            
            multipartFormData.append((params["mobileCode"]!.data(using: String.Encoding.utf8)!),
                                     withName: "mobileCode")

            multipartFormData.append((params["non_exercise_Id"]!.data(using: String.Encoding.utf8)!),
                                     withName: "non_exercise_Id")

            for i in 0..<data.count {
                let temp = Int(arc4random()%1000000000)+Int(arc4random()%1000000000)
                multipartFormData.append(UIImagePNGRepresentation(data[i])!, withName: "Student/Not_WorkBook_Next\(temp)_image\(i).png", fileName: "Student/Not_WorkBook_Nextii\(temp)_image\(i).png", mimeType: "image/png")
            }
    },
        to: kAdd_NonExerciseNext,
        headers: headers,
        encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    if let value = response.result.value as? [String: AnyObject]{
                        success(value)
                        let json = JSON(value)
                        deBugPrint(item: json)
                        if json["code"].stringValue == "1" {
                        }

                    }
                    
                    if response.result.value == nil {
                        success(["000":"000" as AnyObject])
                    }
                    
                }
            case .failure(let encodingError):
                failture(encodingError)
            }
    }
    )
}


//MARK:24(学生端 我的班级)接口
public func netWorkForMyClassStudent(params:[String:Any],callBack:((Array<Any>,Bool)->())?) ->  Void {
    
    var dataArr = [ClassModel]()
    Alamofire.request(kGet_MyClass,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let datas =  JSOnDictory["data"].arrayValue
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    setToast(str: "请求失败")
                                    callBack!(dataArr,false)
                                }
                                for index in 0..<datas.count {
                                    
                                    let json = datas[index]
                                    
                                    let model  = ClassModel.setValueForClassModel(json: json)
                                    dataArr.append(model)
                                }
                                callBack!(dataArr,true)
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(dataArr,false)
                            setToast(str: "请求失败")
                        }
    }
}
  
  
  //MARK:24(老师端 我的班级)接口
  public func netWorkForMyClass(params:[String:Any],callBack:((Array<Any>,Bool)->())?) ->  Void {
    
    var dataArr = [ClassModel]()
    Alamofire.request(kMy_Classes,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let datas =  JSOnDictory["data"].arrayValue
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    setToast(str: "请求失败")
                                    callBack!(dataArr,false)
                                }
                                
                                for index in 0..<datas.count {
                                    let json = datas[index]
                                    let model  = ClassModel.setValueForClassModel(json: json)
                                    dataArr.append(model)
                                }
                                callBack!(dataArr,true)
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(dataArr,false)
                            setToast(str: "请求失败")
                        }
    }
  }



//MARK:25(学生端  退出班级)接口
public func netWorkForQuitClass(params:[String:Any],callBack:((Bool)->())?) ->  Void {
    Alamofire.request(kDelete_Class,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            
                            callBack!(true)
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            
                            callBack!(false)
                        }
    }
}


//MARK:26(学生端  学生加入班级)接口
public func netWorkForJoinClass(params:[String:Any],callBack:((Bool)->())?) ->  Void {
    Alamofire.request(kAdd_ToStudentClass,
                      method: .post, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:DispatchQueue.main, options: .allowFragments) { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            
                            callBack!(true)
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            
                            callBack!(false)
                        }
    }
}


//MARK:27(学生端  学生创建班级作业)接口
func upLoadClassWorkImageRequest(
                                   params:[String:String],
                                   data: [UIImage],
                                   name: [String],
                                   success : @escaping (_ response : [String : AnyObject])->(),
                                   failture : @escaping (_ error : Error)->()){
    
    let headers = ["content-type":"multipart/form-data"]
    
    Alamofire.upload(
        multipartFormData: { multipartFormData in
            
            multipartFormData.append((params["SESSIONID"]!.data(using: String.Encoding.utf8)!),
                                     withName: "SESSIONID")
            multipartFormData.append((params["mobileCode"]!.data(using: String.Encoding.utf8)!),
                                     withName: "mobileCode")
            multipartFormData.append((params["periods_id"]!.data(using: String.Encoding.utf8)!),
                                     withName: "periods_id")
            
            multipartFormData.append((params["title"]!.data(using: String.Encoding.utf8)!),
                                     withName: "title")
            
            for i in 0..<data.count {
                let temp = Int(arc4random()%1000000000)+Int(arc4random()%1000000000)
                multipartFormData.append(UIImagePNGRepresentation(data[i])!, withName: "Student/Class_WorkBook\(temp)_image\(i)1.png", fileName: "Student/Class_WorkBook\(temp)_image\(i).png", mimeType: "image/png")
            }
            
    },
        to: kBulid_ClassBook,
        headers: headers,
        encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    if let value = response.result.value as? [String: AnyObject]{
                        success(value)
                        let json = JSON(value)
                        deBugPrint(item: json)
                        if json["code"] == "1" {
                        }
                    }
                }
            case .failure(let encodingError):
                deBugPrint(item: encodingError)
                failture(encodingError)
            }
    })
}


//MARK:28(学生端  学生二次提交班级作业)接口
func upLoadClassWorkImageRequestNext(
    params:[String:String],
    data: [UIImage],
    name: [String],
    success : @escaping (_ response : [String : AnyObject])->(),
    failture : @escaping (_ error : Error)->()){
    
    let headers = ["content-type":"multipart/form-data"]
    
    Alamofire.upload(
        multipartFormData: { multipartFormData in
            
            multipartFormData.append((params["SESSIONID"]!.data(using: String.Encoding.utf8)!),
                                     withName: "SESSIONID")
            
            multipartFormData.append((params["mobileCode"]!.data(using: String.Encoding.utf8)!),
                                     withName: "mobileCode")
            
            multipartFormData.append((params["classes_book_id"]!.data(using: String.Encoding.utf8)!),
                                     withName: "classes_book_id")
            
            for i in 0..<data.count {
                let temp = Int(arc4random()%1000000000)+Int(arc4random()%1000000000)
                multipartFormData.append(UIImagePNGRepresentation(data[i])!, withName: "Student/Class_WorkBook\(temp)Next_image\(i)1.png", fileName: "Student/Class_WorkBook\(temp)Next_image\(i).png", mimeType: "image/png")
            }
            
    },
        to: kBulid_ClassBookNext,
        headers: headers,
        encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    if let value = response.result.value as? [String: AnyObject]{
                        success(value)
                    }
                }
            case .failure(let encodingError):
                deBugPrint(item: encodingError)
                failture(encodingError)
            }
    })
}


  //MARK:29(学生端  根据课时id查询我的课时作业)接口
  public func netWorkForGetMyClassBookByPeriods(params:[String:Any],callBack:((Array<Any>,Bool)->())?) ->  Void {
    
    var dataArr = [TClassWorkModel]()
    Alamofire.request(kGet_MyClassBookByPeriods,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let datas =  JSOnDictory["data"].arrayValue
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    setToast(str: "请求失败")
                                    callBack!(dataArr,false)
                                }
                                for index in 0..<datas.count {
                                    
                                    let json = datas[index]
                                    let model  = TClassWorkModel.setValueForTClassWorkModel(json: json)
                                    dataArr.append(model)
                                }
                            }
                            callBack!(dataArr,true)
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            
                            callBack!(dataArr,false)
                        }
    }
  }

  //MARK:30(学生端  根据课时id查询我的课时作业)接口
  public func netWorkForGetStudentScoress(params:[String:Any],callBack:((Array<Any>,String,String,Bool)->())?) ->  Void {
    
    var dataArr = [LNShowRankModel]()
    Alamofire.request(kGet_StudentScores,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let datas =  JSOnDictory["data"]["other"].arrayValue
                                let code =  JSOnDictory["code"].stringValue
                                let isMe =  JSOnDictory["data"]["me"]["isMe"].stringValue
                                let myScores =  JSOnDictory["data"]["me"]["myScores"].stringValue

                                
                                if code == "0" {
                                    setToast(str: "请求失败")
                                    callBack!(dataArr,"","",false)
                                }
                                for index in 0..<datas.count {
                                    
                                    let json = datas[index]
                                    let model  = LNShowRankModel.setValueForLNShowRankModel(json: json)
                                    dataArr.append(model)
                                }
                                callBack!(dataArr,isMe,myScores,true)
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            
                            callBack!(dataArr,"","",false)
                        }
    }
  }


//MARK: 31  接口说明 ： 非练习册列表展示（每页6条显示）
public func NetWorkTeacherGetExerciseList(params:[String:Any],callBack:((Array<Any>,Bool)->())?) ->  Void {
    
    var dataArr = [SNotWorkModel]()
    Alamofire.request(kGet_ExerciseList,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                       deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(dataArr,false)
                                    setToast(str: "获取非练习册失败")
                                }
                                
                                let datas =  JSOnDictory["data"]
                                
                                for index in 0..<datas.count {
                                    let json = datas[index]
                                    let model  = SNotWorkModel.setValueForSNotWorkModel(json: json)
                                    dataArr.append(model)
                                }
                                callBack!(dataArr,true)
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(dataArr,false)
                            setToast(str: "获取非练习册失败")
                        }
    }
}


//MARK:32   接口说明 ： 根据练习册或者非练习册id获取相对应的知识点
public func NetWorkStudentGetKnowledgePoint(params:[String:Any],callBack:((Array<Any>,Bool)->())?) ->  Void {
    
    var dataArr = [UrlModel]()
    Alamofire.request(kGet_KnowledgePoint,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(dataArr,false)
                                    setToast(str: "获取失败")
                                }
                                
                                let datas =  JSOnDictory["data"].arrayValue
                                
                                for index in 0..<datas.count {
                                    
                                    let json = datas[index]
                                    let model  = UrlModel.setValueForUrlModel(json: json)
                                    dataArr.append(model)
                                }
                                callBack!(dataArr,true)
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(dataArr,false)
                            setToast(str: "获取练习册知识点失败")
                        }
    }
}


//MARK:33   接口说明 ：  学币交易事物处理通用方法,以及学币充值
public func NetWorkStudentUpdownAnswrs(params:[String:Any],callBack:((Bool)->())?) ->  Void {
//    kUp_DownAnswrs
    Alamofire.request(kUp_DownAnswrs,
                      method: .post, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(false)
                                }else if code == "1" {
                                    callBack!(true)
                                }else if code == "11" {
                                    setToast(str: "学币余额不足")
                                    callBack!(false)
                                }else if code == "8" {
                                    setToast(str: "密码错误，请重新输入")
                                    callBack!(false)
                                }else if code == "12" {
                                    setToast(str: "还未创建支付密码")
                                    callBack!(false)
                                }
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(false)
                        }
    }
}


//MARK:34   接口说明 ：  练习册答案表信息接口  不传时间，会按今天的时间来查询
public func NetWorkStudentGetAnswrs(params:[String:Any],callBack:((Array<Any>,Bool)->())?) ->  Void {
    
    var dataArr = [UrlModel]()
    Alamofire.request(kGet_Answrs,
                      method:.get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(dataArr,false)
                                }
                                let datas =  JSOnDictory["data"].arrayValue
                                for index in 0..<datas.count {
                                    let json = datas[index]
                                    let model  = UrlModel.setValueForUrlModel(json: json)
                                    dataArr.append(model)
                                }
                                callBack!(dataArr,true)
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(dataArr,false)
                        }
    }
}






//MARK:35    接口说明 ：  非练习册，班级作业，答案表信息通用接口
public func NetWorkStudentGetOtherAnswrs(params:[String:Any],callBack:((Array<Any>,Bool)->())?) ->  Void {
    
    var dataArr = [UrlModel]()
    Alamofire.request(kGet_OtherAnswrs,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(dataArr,false)
                                }
                                let datas =  JSOnDictory["data"].arrayValue
                                
                                for index in 0..<datas.count {
                                    
                                    let json = datas[index]
                                    let model  = UrlModel.setValueForUrlModel(json: json)
                                    dataArr.append(model)
                                }
                                callBack!(dataArr,true)
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(dataArr,false)
                        }
    }
}


//MARK:36   接口说明 ：   判断该答案已付过款的类型，值为空，表示都未付过款
public func NetWorkStudentCheckPay(params:[String:Any],callBack:((Array<Any>,Bool)->())?) ->  Void {
    var dataArr = [PayModel]()
    Alamofire.request(kCheck_Pay,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(dataArr,false)
                                }else{
//                                    setToast(str: JSOnDictory["message"].stringValue)
                                }
                                let datas =  JSOnDictory["data"].arrayValue
                                
                                for index in 0..<datas.count {
                                    
                                    let json = datas[index]
                                    let model  = PayModel.setValueForPayModel(json: json)
                                    dataArr.append(model)
                                }
                                callBack!(dataArr,true)
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(dataArr,false)
                        }
    }   
}

  
  
  

//MARK:37    接口说明 ：   非练习册详情接口
public func NetWorkStudentGetAllnon_exercise(params:[String:Any],callBack:((Array<Any>,Bool)->())?) ->  Void {
    
    var dataArr = [NotWorkDetailModel]()
    Alamofire.request(kGet_Allnon_exercise,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(dataArr,false)
                                }
                                let datas =  JSOnDictory["data"].arrayValue
                                
                                for index in 0..<datas.count {
                                    
                                    let json = datas[index]
                                    let model  = NotWorkDetailModel.setValueForNotWorkDetailModel(json: json)
                                    dataArr.append(model)
                                }
                                callBack!(dataArr,true)
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(dataArr,false)
                        }
    }
}


  
  //MARK:37    接口说明 ：   非练习册详情接口
  public func NetWorkStudentGetMsgBystudent(params:[String:Any],callBack:((Array<Any>,Bool)->())?) ->  Void {
    
    var dataArr = [SMessageModel]()
    Alamofire.request(kGet_MsgBystudent,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(dataArr,false)
                                }
                                let datas =  JSOnDictory["data"].arrayValue
                                
                                for index in 0..<datas.count {
                                    
                                    let json = datas[index]
                                    let model  = SMessageModel.setValueForSMessageModel(json: json)
                                    dataArr.append(model)
                                }
                                callBack!(dataArr,true)
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(dataArr,false)
                        }
    }
  }


  //MARK:39  学生端练习册成绩统计，班级5星作业，通用接口
  public func NetWorkTeacherGetScroes(params:[String:String],callBack:((Array<Any>,Bool)->())?) ->  Void {
    
    var dataArr = NSMutableArray()
    Alamofire.request(kGet_Scroes,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(dataArr as! Array<Any>,false)
                                    setToast(str: "获取数据失败")
                                }
                                
                                let datas =  JSOnDictory["data"].arrayValue
                                if datas.count == 0{
                                    if JSOnDictory["message"].stringValue.count > 0 {
                                        setToast(str: JSOnDictory["message"].stringValue)
                                    }
                                }
                                for index in 0..<datas.count {
                                    
                                    let json = datas[index]
                                    
                                    if params["type"] == "1" {
                                        let model  = TShowGradeModel.setValueForTMyWorkTShowGradeModel(json: json)
                                        dataArr.add(model)
                                    }else{
                                        let model  = LNClassWorkModel.setValueForLNClassWorkModel(json: json)
                                        dataArr.add(model)
                                    }                                    
                                }
                                callBack!(dataArr as! Array<Any>,true)
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(dataArr as! Array<Any>,false)
                            setToast(str: "请求失败")
                        }
    }
    
  }

  
  //MARK:42 接口说明 ：课程目录接口（学生端
  public func netWorkForGetClassContents(params:[String:String],callBack:((Array<Any>,Bool)->())?) ->  Void {
    
    let dataArr = NSMutableArray()
    Alamofire.request(kGet_ClassContents,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(dataArr as! Array<Any>,false)
                                }
                                let datas =  JSOnDictory["data"].arrayValue
                                
                                if params["type"] == "2" {
                                    let model  = LNClassMemberModel.setValueForLNClassMemberModel(json: JSOnDictory["data"])
                                    dataArr.add(model)
                                }else{
                                    for index in 0..<datas.count {
                                        
                                        let json = datas[index]
                                        
                                        if params["type"] == "1" {
                                            let model  = TPeriodsModel.setValueForTPeriodsModel(json: json)
                                            dataArr.add(model)
                                        }else if params["type"] == "3" {
                                            let model  = LNClassInfoModel.setValueForLNClassInfoModel(json: json)
                                            dataArr.add(model)
                                        }else if params["type"] == "4" {
                                            let model  = TShowGradeModel.setValueForTMyWorkTShowGradeModel(json: json)
                                            dataArr.add(model)
                                        }
                                    }
                                }
                                callBack!(dataArr as! Array<Any>,true)
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(dataArr as! Array<Any>,true)
                        }
    }
  }


////MARK:(学生端 对请求进行操作)接口
//public func netWorkForGetWorkBookTime(callBack:@escaping (Bool)->()?) ->  Void {
//    //    let dataArr = NSMutableArraRy()
//
//    Alamofire.request(kGetWork_BookByTime,
//                      method: .post, parameters: nil,
//                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:DispatchQueue.main, options: .allowFragments) { (response) in
//                        print(response.result)
//                        switch response.result {
//                        case .success:
//
//                            //                            setToast(str: "创建成功")
//                            callBack(true)
//                            break
//                        case .failure(let error):
//                            print(error)
//
//                            setToast(str: "对请求进行操作失败")
//                            callBack(false)
//                        }
//    }
//}

  
  
  //MARK:43   接口说明 ：   判断课时课程等内容是否已经付过款
  public func NetWorkStudentCheckPayDoc(params:[String:Any],callBack:((Array<Any>,Bool)->())?) ->  Void {
    var dataArr = [PayModel]()
    Alamofire.request(kCheck_PayDoc,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(dataArr,false)
                                }else{
//                                    setToast(str: JSOnDictory["message"].stringValue)
                                }
                                let datas =  JSOnDictory["data"].arrayValue
                                
                                for index in 0..<datas.count {
                                    
                                    let json = datas[index]
                                    let model  = PayModel.setValueForPayModel(json: json)
                                    dataArr.append(model)
                                }
                                callBack!(dataArr,true)
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(dataArr,false)
                        }
    }
  }

  
  
  //MARK:44    接口说明 ：  对应获取班级课时内课时内容
  public func NetWorkStudentGetPeriodsList(params:[String:Any],callBack:((Array<Any>,Bool)->())?) ->  Void {
    
    var dataArr = [UrlModel]()
    Alamofire.request(kGet_PeriodsList,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(dataArr,false)
                                }
                                let datas =  JSOnDictory["data"].arrayValue
                                
                                for index in 0..<datas.count {
                                    
                                    let json = datas[index]
                                    let model  = UrlModel.setValueForUrlModel(json: json)
                                    dataArr.append(model)
                                }
                                callBack!(dataArr,true)
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(dataArr,false)
                        }
    }
  }

  
  //MARK:45   接口说明 ：  判断课时是否已开通单次作业
  public func NetWorkStudentCheckBuyClassBook(params:[String:Any],callBack:((Array<Any>,Bool)->())?) ->  Void {
    
    var dataArr = [PayVideoModel]()
    
    Alamofire.request(kCheck_BuyClassBook,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(dataArr,false)
                                }else{
                                    let datas =  JSOnDictory["data"]
                                    let model  = PayVideoModel.setValueForPayVideoModel(json: datas)
                                    dataArr.append(model)
                                    callBack!(dataArr,true)
                                }
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(dataArr,true)
                        }
    }
  }
  
  //MARK:47   接口说明 ： 撤销上传的练习册或者非练习册
  public func NetWorkStudentBackWorkBook(params:[String:Any],callBack:((Bool)->())?) ->  Void {
    
    Alamofire.request(kBack_WorkBook,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(false)
                                }else{
                                    callBack!(true)
                                }
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(true)
                        }
    }
  }
  
  
  //MARK:获取消息详情（学生）
  public func NetWorkTeachersGetMsgDetailsStudent(params:[String:Any],callBack:@escaping (Bool,String)->()) ->  Void {
    
    Alamofire.request(kGet_MsgDetailsS,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON{ (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack(false,"")
                                    setToast(str: "获取失败")
                                }else{
                                    callBack(true,JSOnDictory["data"]["reason"].stringValue)
                                }
                                
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            setToast(str: "获取失败")
                            callBack(false,"")
                        }
    }
  }


public func requestData(params:Any,callBack:((String)->())?) ->  Void {
//    let dataArr = NSMutableArray()
           Alamofire.request("kRegistAccount",
                      method: .get, parameters: nil,
                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                        deBugPrint(item: response)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let translation =  JSOnDictory["result"]
                                
                                let product_list = translation["product_list"].arrayValue
                                
                                for index in 0..<product_list.count {
                                    
                                    let json = product_list[index]
                                    deBugPrint(item: json)

//                                    let model  = TestModel.getTheModels(json: json)
                                    
//                                    dataArr.add(model)
                                }
//                                callBack!(dataArr as! Array<Any>)
                            }
                        case .failure(let error):
                            deBugPrint(item: error)
                        }
    }
}

class NetWorkTools: NSObject {

}
