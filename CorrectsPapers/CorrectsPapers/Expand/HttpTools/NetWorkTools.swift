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

var createGroupBlock:((String,Array<Any>)->())?  //声明闭包

//MARK:验证码接口
public func netWorkForSendCode(phoneNumber:String,callBack:((String)->())?) ->  Void {

    let dic = ["phone":"12345678945"]
    Alamofire.request(kGet_Sms,
                      method: .get, parameters: dic,
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:DispatchQueue.main, options: .allowFragments) { (response) in
                        print(response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let translation =  JSOnDictory["message"]
                                print(translation)
                            }
                            break
                        case .failure(let error):
                            print(error)
                        }
    }
}


//MARK:注册接口
public func netWorkForRegistAccount(params:[String:Any],callBack:((String)->())?) ->  Void {
//    let dataArr = NSMutableArraRy()
    let mainQueue = DispatchQueue.main;
    
    Alamofire.request(kLogin_User,
                      method: .post,
                      parameters: params,
                      encoding: URLEncoding.default,
                      headers: nil).responseJSON(
                      queue:mainQueue,
                      options: .allowFragments)
                      { (response) in
                        print(response.result)
                        switch response.result {
                        case .success:
                            
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let code =  JSOnDictory["code"].intValue
                                
                                if code == 0{
                                    callBack!("failure")
                                }else{
                                    callBack!("haha")
                                }
                            }
                            setToast(str: "完成")
                            break
                        case .failure(let error):
                            print(error)
                            setToast(str: "注册失败")
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
        ["SESSIONID":"1",
         "mobileCode":"on",
         ]
    
    var dataArr = [TComplaintModel]()
    Alamofire.request("http://192.168.1.181:8080/duties/m/rongxing/mine/getComplaints",
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:DispatchQueue.main, options: .allowFragments) { (response) in
                        print(response.result)
                        switch response.result {
                        case .success:
                            
                            setToast(str: "完成")
                            
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    setToast(str: "上传成功返回失败")
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
                            print(error)
                            
                            callBack!(dataArr,false)
                            setToast(str: "获取被投诉记录")
                        }
    }
}


//MARK: 1  1-0 和 1-2  获取所有的练习册
public func NetWorkTeacherGetTAllWorkList(params:[String:Any],callBack:((Array<Any>,Bool)->())?) ->  Void {
    
    var dataArr = [WorkBookModel]()
    Alamofire.request(kGet_TAllWorkList,
                      method: .get, parameters: nil,
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:DispatchQueue.main, options: .allowFragments) { (response) in
                        print(response.result)
                        switch response.result {
                        case .success:

                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    setToast(str: "上传成功返回失败")
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
                            print(error)
                            callBack!(dataArr,false)
                        }
    }
}

//MARK: 26   1-1 我的练习册  - 我来批改
public func NetWorkTeacherAddMyWork(params:[String:Any],callBack:((Bool)->())?) ->  Void {
    
    Alamofire.request(kAdd_MyWork,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:DispatchQueue.main, options: .allowFragments) { (response) in
                        print(response.result)
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
                                    setToast(str: "添加到练习册成功")
                                }
                            }
                            break
                        case .failure(let error):
                            print(error)
                            
                            callBack!(false)
                            setToast(str: "添加到练习册失败")
                        }
    }
}


//MARK:2 1-1 我的练习册
public func NetWorkTeacherGetMyWorkList(params:[String:Any],callBack:((Array<Any>,Bool)->())?) ->  Void {
    var dataArr = [WorkBookModel]()
    let mainQueue = DispatchQueue.main;
    
    Alamofire.request(kGet_MyWorkList,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:mainQueue, options: .allowFragments) { (response) in
                        print(response.result)
                        switch response.result {
                        case .success:
                            
                            setToast(str: "完成")
                            
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
                        case .failure(let error):
                            
                            callBack!(dataArr,false)
                            setToast(str: "获取我的练习册失败")
                        }
    }
    
}


//MARK:3 1-1 我的练习册 删除
public func NetWorkTeacherDelMyWork(params:[String:String],callBack:((Bool)->())?) ->  Void {
    
    let mainQueue = DispatchQueue.main;
    Alamofire.request(kdel_MyWork,
                      method: .get,
                      parameters: params,
                      encoding: URLEncoding.default,
                      headers: nil).responseJSON(queue:mainQueue, options: .allowFragments) { (response) in
                        print(response.result)
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
                                    setToast(str: "删除练习册成功")
                                }
                            }
                            break
                        case .failure(let error):
                            callBack!(false)
                            setToast(str: "删除练习册失败")
                        }
    }
}


//MARK:4  1-3 练习册详情 根据练习册id获取详情
public func NetWorkTeacherGetTWorkDetail(params:[String:Any],callBack:((Array<Any>,Bool)->())?) ->  Void {
   
    var dataArr = [TMyWorkDetailModel]()
    let mainQueue = DispatchQueue.main;
    Alamofire.request(kGet_TWorkDetail,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:mainQueue, options: .allowFragments) { (response) in
                        print(response.result)
                        switch response.result {
                        case .success:
                            
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(dataArr,false)
                                    setToast(str: "上传成功返回失败")
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
                            print(error)
                            callBack!(dataArr,false)
                            setToast(str: "获取练习册详情失败")
                        }
    }
    
}


//MARK:5  1-3 练习册详情 - 学生作业 》根据练习册id获取详情
public func NetWorkTeacherGetTStudentWorkList(params:[String:Any],callBack:((Array<Any>,Bool)->())?) ->  Void {
    
    var dataArr = [TShowStuWorksModel]()
    let mainQueue = DispatchQueue.main;
    Alamofire.request(kGet_TStudentWork1,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:mainQueue, options: .allowFragments) { (response) in
                        print(response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(dataArr,false)
                                    setToast(str: "上传成功返回失败")
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
                            print(error)
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
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:DispatchQueue.main, options: .allowFragments) { (response) in
                        print(response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(dataArr,false)
                                    setToast(str: "上传成功返回失败")
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
                            print(error)
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
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:DispatchQueue.main, options: .allowFragments) { (response) in
                        print(response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(dataArr,false)
                                    setToast(str: "上传成功返回失败")
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
                            print(error)
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
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:DispatchQueue.main, options: .allowFragments) { (response) in
                        print(response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(dataArr,false)
                                    setToast(str: "上传成功返回失败")
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
                            print(error)
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
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:DispatchQueue.main, options: .allowFragments) { (response) in
                        print(response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(dataArr,false)
                                    setToast(str: "上传成功返回失败")
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
                            print(error)
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
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:mainQueue, options: .allowFragments) { (response) in
                        print(response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    setToast(str: "上传成功返回失败")
                                    callBack!(false)
                                }else{
                                    callBack!(true)
                                }
                            }
                            break
                        case .failure(let error):
                            print(error)
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
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:mainQueue, options: .allowFragments) { (response) in
                        print(response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    setToast(str: "上传成功返回失败")
                                    callBack!(false)
                                }else{
                                    callBack!(true)
                                }
                            }
                            break
                        case .failure(let error):
                            print(error)
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
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:mainQueue, options: .allowFragments) { (response) in
                        print(response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    setToast(str: "上传成功返回失败")
                                    callBack!(false)
                                }else{
                                    callBack!(true)
                                }
                            }
                            break
                        case .failure(let error):
                            print(error)
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
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:DispatchQueue.main, options: .allowFragments) { (response) in
                        print(response.result)
                        switch response.result {
                        case .success:
                            
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(dataArr,false)
                                    setToast(str: "上传成功返回失败")
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
                            print(error)
                            callBack!(dataArr,false)
                            setToast(str: "学生往期成绩失败")
                        }
    }
    
}


//MARK: 15  2-0 查询所有非练习册数据 (没有老师批改过的所有fei练习册)
public func NetWorkTeacherGetTAllNotWork(callBack:((Array<Any>,Bool)->())?) ->  Void {
    let params =
        ["SESSIONID":SESSIONIDT,
         "mobileCode":mobileCodeT,
         ]
    var dataArr = [TNotWorkModel]()
    Alamofire.request(kGet_TAllNotWork,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:DispatchQueue.main, options: .allowFragments) { (response) in
                        print(response.result)
                        switch response.result {
                        case .success:
                            
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(dataArr,false)
                                    setToast(str: "上传成功返回失败")
                                }
                                
                                let datas =  JSOnDictory["data"].arrayValue
                                
                                for index in 0..<datas.count {
                                    
                                    let json = datas[index]
                                    let model  = TNotWorkModel.setValueForTNotWorkModel(json: json)
                                    dataArr.append(model)
                                }
                                callBack!(dataArr,true)
                            }
                            break
                        case .failure(let error):
                            print(error)
                            callBack!(dataArr,false)
                            setToast(str: "教师端获取所有fei练习册失败")
                        }
    }
}


//MARK:16  2-1 查询所有非练习册数据 (属于自己的所有fei练习册，所有状态)
public func NetWorkTeacherGetTMyAllNotWork(callBack:((Array<Any>,Bool)->())?) ->  Void {
    
    let params =
        ["SESSIONID":SESSIONIDT,
         "mobileCode":mobileCodeT,
         ]
    var dataArr = [TNotWorkModel]()
    Alamofire.request(kGet_TMyAllNotWork,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:DispatchQueue.main, options: .allowFragments) { (response) in
                        print(response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(dataArr,false)
                                    setToast(str: "上传成功返回失败")
                                }
                                
                                let datas =  JSOnDictory["data"].arrayValue
                                
                                for index in 0..<datas.count {
                                    
                                    let json = datas[index]
                                    let model  = TNotWorkModel.setValueForTNotWorkModel(json: json)
                                    dataArr.append(model)
                                }
                                callBack!(dataArr,true)
                            }
                            break
                        case .failure(let error):
                            print(error)
                            callBack!(dataArr,false)
                            setToast(str: "属于自己的所有fei练习册失败")
                        }
    }
    
}


//MARK:17  2-2 非练习册-详情 - 作业
public func NetWorkTeacherGetTMyNotWorkDatails(params:[String:Any],callBack:((Array<Any>,Bool)->())?) ->  Void {
    
    var dataArr = [TNotWorkDetailModel]()
    Alamofire.request(kGet_TMyNotWorkDatail,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:DispatchQueue.main, options: .allowFragments) { (response) in
                        print(response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(dataArr,false)
                                    setToast(str: "上传成功返回失败")
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
                            print(error)
                            callBack!(dataArr,false)
                            setToast(str: "非练习册-详情失败")
                        }
    }
    
}


//MARK:18  2-2    非练习册-详情-知识点讲解
public func NetWorkTeacherGetTMyNotWorkDatailPoints(params:[String:Any],callBack:((Array<Any>,Bool)->())?) ->  Void {
    
    var dataArr = [UrlModel]()
    Alamofire.request(kGet_TMyNotWorkDatail2,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:DispatchQueue.main, options: .allowFragments) { (response) in
                        print(response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(dataArr,false)
                                    setToast(str: "上传成功返回失败")
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
                            print(error)
                            callBack!(dataArr,false)
                            setToast(str: "非练习册-知识点讲解失败")
                        }
    }
    
}

//MARK:19  2-2-1    非练习册-详情-参考答案
public func NetWorkTeacherGetTMyNotWorkDatailAnswers(params:[String:Any],callBack:((Array<Any>,Bool)->())?) ->  Void {

    
    var dataArr = [TNotWorkModel]()
    Alamofire.request(kGet_TMyNotWorkDatail3,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:DispatchQueue.main, options: .allowFragments) { (response) in
                        print(response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(dataArr,false)
                                    setToast(str: "上传成功返回失败")
                                }
                                
                                let datas =  JSOnDictory["data"].arrayValue
                                
                                for index in 0..<datas.count {
                                    
                                    let json = datas[index]
                                    let model  = TNotWorkModel.setValueForTNotWorkModel(json: json)
                                    dataArr.append(model)
                                }
                                callBack!(dataArr,true)
                            }
                            break
                        case .failure(let error):
                                print(error)
                                callBack!(dataArr,false)
                                setToast(str: "非练习册参考答案失败")
                        }
    }
    
}


//MARK:20  2-2   非练习册-详情-成绩统计
public func NetWorkTeacherGetTMyNotWorkDatailGrades(params:[String:Any],callBack:((Array<Any>,Bool)->())?) ->  Void {
    
    var dataArr = [TNotWorkModel]()
    Alamofire.request(kGet_TMyNotWorkDatail4,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:DispatchQueue.main, options: .allowFragments) { (response) in
                        print(response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(dataArr,false)
                                    setToast(str: "上传成功返回失败")
                                }
                                
                                let datas =  JSOnDictory["data"].arrayValue
                                
                                for index in 0..<datas.count {
                                    
                                    let json = datas[index]
                                    let model  = TNotWorkModel.setValueForTNotWorkModel(json: json)
                                    dataArr.append(model)
                                }
                                callBack!(dataArr,true)
                            }
                            break
                        case .failure(let error):
                                print(error)
                                callBack!(dataArr,false)
                                setToast(str: "非练习册-成绩统计失败")
                        }
    }
    
}


//MARK:21  2-2-1    非练习册-详情-上传视频
public func NetWorkTeacherAddTNotWorkUploadVideo(params:[String:Any],callBack:((Bool)->())?) ->  Void {
    
    Alamofire.request(kAdd_TNotWorkVideo,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:DispatchQueue.main, options: .allowFragments) { (response) in
                        print(response.result)
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
                                    setToast(str: "上传视频成功")
                                }
                            }
                            break
                        case .failure(let error):
                            print(error)
                            callBack!(false)
                            setToast(str: "上传视频失败")
                        }
    }
    
}


//MARK:未完成
//MARK:22  2-2-2    非练习册-详情-上传文件
public func NetWorkTeacherAddTNotWorkUploadFile(params:[String:Any],callBack:((Bool)->())?) ->  Void {
    
    Alamofire.request(kAdd_TNotWorkFile,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:DispatchQueue.main, options: .allowFragments) { (response) in
                        print(response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                let JSOnDictory = JSON(j)
                                
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(false)
                                    setToast(str: "上传文件失败")
                                }else{
                                    callBack!(true)
                                    setToast(str: "上传文件成功")
                                }
                            }
                            break
                        case .failure(let error):
                            print(error)
                            
                            setToast(str: "上传文件失败")
                        }
    }
    
}


//MARK:23  2-2-3    非练习册-手动填写
public func NetWorkTeacherAddTNotWorkUploadContent(params:[String:Any],callBack:((Bool)->())?) ->  Void {
    
    Alamofire.request(kAdd_TNotWorkContent,
                      method: .post, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:DispatchQueue.main, options: .allowFragments) { (response) in
                        print(response.result)
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
                                    setToast(str: "上传答案成功")
                                }
                            }
                            break
                        case .failure(let error):
                            print(error)
                            callBack!(false)
                            setToast(str: "上传答案失败")
                        }
    }
    
}


//MARK:24  2-2-3    非练习册-上传知识点
public func NetWorkTeacherAddTNotWorkTheUploadPoints(params:[String:Any],callBack:((Bool)->())?) ->  Void {
    
    Alamofire.request(kAdd_TNotWorkChapter,
                      method: .post, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:DispatchQueue.main, options: .allowFragments) { (response) in
                        print(response.result)
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
                                    setToast(str: "上传答案成功")
                                }
                            }
                            break
                        case .failure(let error):
                            print(error)
                            callBack!(false)
                            setToast(str: "上传答案失败")
                        }
    }
    
}


//MARK:邓志辉接口
//MARK:邓志辉接口
//MARK:邓志辉接口
//MARK:邓志辉接口
//MARK:邓志辉接口
//MARK:邓志辉接口


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
    
    Alamofire.request(kgoback_WrokBook,
                      method: .put, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:DispatchQueue.main, options: .allowFragments) { (response) in
                        print(response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    setToast(str: "练习册退回失败")
                                    callBack!(false)
                                }else{
                                    callBack!(true)
                                    setToast(str: "练习册退回成功")
                                }
                            }

                            break
                        case .failure(let error):
                            print(error)
                            callBack!(false)
                            setToast(str: "练习册退回失败")
                        }
    }
    
}

//MARK:6      第二次批改
func NetWorkTeacherCorrectNextWrokBook(
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
            
            multipartFormData.append((params["book_details_id"]!.data(using: String.Encoding.utf8)!),
                                     withName: "book_details_id")
            
            multipartFormData.append((params["scores_next"]!.data(using: String.Encoding.utf8)!),
                                     withName: "scores_next")
            
            multipartFormData.append((params["comment_next"]!.data(using: String.Encoding.utf8)!),
                                     withName: "comment_next")
            
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
            case .failure(let encodingError):
                failture(encodingError)
            }
    }
    )
}


//MARK:10      老师批改非练习册
func NetWorkTeacherNonExercise(
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
            multipartFormData.append((params["non_exercise_Id"]!.data(using: String.Encoding.utf8)!),
                                     withName: "non_exercise_Id")
            
            multipartFormData.append((params["scores"]!.data(using: String.Encoding.utf8)!),
                                     withName: "scores")
            
            multipartFormData.append((params["comment"]!.data(using: String.Encoding.utf8)!),
                                     withName: "comment")
            
            for image in data {
                let data1 = UIImageJPEGRepresentation(image, 0.5)
                let temp = Int(arc4random()%1000000000)+Int(arc4random()%1000000000)
                let imageName = "Teacher/Non_WorkBook\(temp)_image.png"
                multipartFormData.append(data1!, withName: "name", fileName: imageName, mimeType: "image/png")
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
                    
                }
            case .failure(let encodingError):
                failture(encodingError)
            }
    }
    )
}


//MARK:11      老师再次批改非练习册
func NetWorkTeacherNonExerciseNext(
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
            multipartFormData.append((params["non_exercise_Id"]!.data(using: String.Encoding.utf8)!),
                                     withName: "non_exercise_Id")
            
            multipartFormData.append((params["scores_next"]!.data(using: String.Encoding.utf8)!),
                                     withName: "scores_next")
            multipartFormData.append((params["comment_next"]!.data(using: String.Encoding.utf8)!),
                                     withName: "comment_next")
            
            for image in data {
                let data1 = UIImageJPEGRepresentation(image, 0.5)
                let temp = Int(arc4random()%1000000000)+Int(arc4random()%1000000000)
                let imageName = "Teacher/Non_WorkBook_Next\(temp)_image.png"
                multipartFormData.append(data1!, withName: "name", fileName: imageName, mimeType: "image/png")
            }
            
    },
        to: kCorrect_NonExerciseNext,
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


//MARK:13      解散班级
public func NetWorkTeacherDeleteMyclasses(params:[String:Any],callBack:((Bool)->())?) ->  Void {
    
    Alamofire.request(kDelete_Myclasses,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:DispatchQueue.main, options: .allowFragments) { (response) in
                        print(response.result)
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
                                    setToast(str: "解散班级成功")
                                }
                            }
                            break
                        case .failure(let error):
                            print(error)
                            callBack!(false)
                            setToast(str: "解散班级失败")
                        }
    }
}


//MARK:14      老师申请加入班级
public func NetWorkTeacherTeacherAddToClasses(params:[String:Any],callBack:((Bool)->())?) ->  Void {
    
    Alamofire.request(kTeacher_AddToClasses,
                      method: .post, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:DispatchQueue.main, options: .allowFragments) { (response) in
                        print(response.result)
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
                                    setToast(str: "申请成功")
                                }
                            }
                            break
                        case .failure(let error):
                            print(error)
                            callBack!(false)
                            setToast(str: "申请失败")
                        }
    }
}


//MARK:15      创建班级
public func NetWorkTeacherTeacherBulidClasses(params:[String:Any],callBack:((Bool)->())?) ->  Void {
    
    Alamofire.request(kTeacher_AddToClasses,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:DispatchQueue.main, options: .allowFragments) { (response) in
                        print(response.result)
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
                                    setToast(str: "创建成功")
                                }
                            }
                            break
                        case .failure(let error):
                            print(error)
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
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:DispatchQueue.main, options: .allowFragments) { (response) in
                        print(response.result)
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
                            print(error)
                            callBack!(dataArr,false)
                            setToast(str: "获取失败")
                        }
    }
}


//MARK:17      兴建课时名称
public func NetWorkTeacherTeacherBulidperiods(params:[String:Any],callBack:((Bool)->())?) ->  Void {
    
    Alamofire.request(kBulid_periods,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:DispatchQueue.main, options: .allowFragments) { (response) in
                        print(response.result)
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
                                    setToast(str: "上传成功")
                                    callBack!(true)
                                }
                            }
                            break
                        case .failure(let error):
                            print(error)
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
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:DispatchQueue.main, options: .allowFragments) { (response) in
                        print(response.result)
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
                                    dataArr.append(model)
                                }
                                callBack!(dataArr,true)

                            }
                            break
                        case .failure(let error):
                            print(error)
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
            
            multipartFormData.append((params["scroes"]!.data(using: String.Encoding.utf8)!),
                                     withName: "scroes")
            
            multipartFormData.append((params["comment"]!.data(using: String.Encoding.utf8)!),
                                     withName: "comment")
            
            for image in data {
                let data1 = UIImageJPEGRepresentation(image, 0.5)
                let temp = Int(arc4random()%1000000000)+Int(arc4random()%1000000000)
                let imageName = "Teacher/Non_WorkBook\(temp)_image.png"
                multipartFormData.append(data1!, withName: "name", fileName: imageName, mimeType: "image/png")
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
            
            multipartFormData.append((params["scores_next"]!.data(using: String.Encoding.utf8)!),
                                     withName: "scores_next")
            multipartFormData.append((params["comment_next"]!.data(using: String.Encoding.utf8)!),
                                     withName: "comment_next")
            
            for image in data {
                let data1 = UIImageJPEGRepresentation(image, 0.5)
                let temp = Int(arc4random()%1000000000)+Int(arc4random()%1000000000)
                let imageName = "Teacher/Non_WorkBook_Next\(temp)_image.png"
                multipartFormData.append(data1!, withName: "name", fileName: imageName, mimeType: "image/png")
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
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:DispatchQueue.main, options: .allowFragments) { (response) in
                        print(response.result)
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
                            print(error)
                            callBack!(dataArr,false)
                            setToast(str: "获取失败")
                        }
    }
}


//MARK:意见和建议
public func netWorkForSuggestion(params:[String:Any],callBack:((Bool)->())?) ->  Void {
    //    let dataArr = NSMutableArraRy()
    let mainQueue = DispatchQueue.main;
    
    Alamofire.request(kInsert_Suggestion,
                      method: .post, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:mainQueue, options: .allowFragments) { (response) in
                        print(response.result)
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
                                    setToast(str: "上传成功")
                                }
                            }
                            
                            break
                        case .failure(let error):
                            print(error)
                            callBack!(false)
                            setToast(str: "上传失败")
                        }
    }
    
}

//MARK:4-4消息中心
public func netWorkForGetMessages(params:[String:Any],callBack:((Array<Any>,Bool)->())?) ->  Void {
    var dataArr = [MessageModel]()
    let mainQueue = DispatchQueue.main;
    
    Alamofire.request(kGet_Messages,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:mainQueue, options: .allowFragments) { (response) in
                        print(response.result)
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
                                    let model  = MessageModel.setValueForMessageModel(json: json)
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


//MARK:(老师端3-3创建班级)接口
public func netWorkForInsertClasses(params:[String:Any],callBack:((Bool)->())?) ->  Void {
    //    let dataArr = NSMutableArraRy()

    Alamofire.request("kInsert_Classes",
                      method: .post,
                      parameters: params,
                      encoding: URLEncoding.default,
                      headers: nil).responseJSON(queue:DispatchQueue.main,
                                                 options: .allowFragments)
                      { (response) in
                        
                        print(response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(false)
                                    setToast(str: "获取失败")
                                }else{
                                    callBack!(true)
                                    setToast(str: "创建成功")
                                }
                            }
                            break
                        case .failure(let error):
                            print(error)
                            callBack!(false)
                            setToast(str: "获取失败")
                        }
    }
    
}


//MARK:(老师端4-3-1添加好友)接口
public func netWorkForInsertFriends(params:[String:Any],callBack:((Bool)->())?) ->  Void {
    //    let dataArr = NSMutableArraRy()
    
    Alamofire.request(kInsert_Friend,
                      method: .post, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:DispatchQueue.main, options: .allowFragments) { (response) in
                        print(response.result)
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
                                    setToast(str: "发送请求成功")
                                }
                            }
                            break
                        case .failure(let error):
                            print(error)
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
        ["SESSIONID":SESSIONID,
         "mobileCode":mobileCode
            ]
    Alamofire.request(kGet_AllWorkBook,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:DispatchQueue.main, options: .allowFragments) { (response) in
                        print(response.result)
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
                            print(error)
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
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:DispatchQueue.main, options: .allowFragments) { (response) in
                        print(response.result)
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
                            print(error)
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
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:DispatchQueue.main, options: .allowFragments) { (response) in
                        print(response.result)
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
                                    setToast(str: "添加作业成功")
                                }
                            }
                            callBack!(true)
                            break
                        case .failure(let error):
                            print(error)
                            callBack!(false)
                            setToast(str: "添加练习册失败")
                        }
    }
    
}


//MARK:(学生端  我的练习册)接口
public func netWorkForMyWorkBook(callBack:((Array<Any>,Bool)->())?) ->  Void {
    
    var dataArr = [WorkBookModel]()
    let dic = ["SESSIONID":SESSIONID,"mobileCode":mobileCode]
    Alamofire.request(kMy_WorkBook,
                      method: .get, parameters: dic,
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:DispatchQueue.main, options: .allowFragments) { (response) in
                        print(response.result)
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
                            print(error)
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
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:DispatchQueue.main, options: .allowFragments) { (response) in
                        print(response.result)
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
                                    setToast(str: "删除成功")
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
                multipartFormData.append(data1!, withName: "name", fileName: imageName, mimeType: "image/png")
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
            
            multipartFormData.append((params["book_details_id"]!.data(using: String.Encoding.utf8)!),
                                     withName: "book_details_id")
            
            for image in data {
                let data1 = UIImageJPEGRepresentation(image, 0.5)
                let temp = Int(arc4random()%1000000000)+Int(arc4random()%1000000000)
                let imageName = "Student/WorkBook/Next\(temp)_image.png"
                multipartFormData.append(data1!, withName: "name", fileName: imageName, mimeType: "image/png")
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

//MARK:(学生端  获取用户练习册详情)接口
public func netWorkForGetWorkBookByTime(params:[String:Any],callBack:((Array<Any>,Bool)->())?) ->  Void {
    
    var dataArr = [BookDetailModel]()
    
    Alamofire.request(kGetWork_BookByTime,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:DispatchQueue.main, options: .allowFragments) { (response) in
                        print(response.result)
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
                            print(error)
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
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:DispatchQueue.main, options: .allowFragments) { (response) in
                        print(response.result)
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
                            print(error)
                            callBack!(dataArr,false)
                            setToast(str: "获取日期失败")
                        }
    }
    
}


//MARK:(学生端  投诉)接口
public func netWorkForBulidComplaint(params:[String:Any],callBack:((Bool)->())?) ->  Void {
    //    let dataArr = NSMutableArraRy()
    
    Alamofire.request(kBulid_Complaint,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:DispatchQueue.main, options: .allowFragments) { (response) in
                        print(response.result)
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
                                    setToast(str: "投诉成功")
                                }
                            }
                            break
                        case .failure(let error):
                            print(error)
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
            
            for image in data {
                let data1 = UIImageJPEGRepresentation(image, 0.5)
                let temp = Int(arc4random()%1000000000)+Int(arc4random()%1000000000)
                let imageName = "student/New_WorkBook\(temp)_image.png"
                multipartFormData.append(data1!, withName: "name", fileName: imageName, mimeType: "image/png")
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
public func netWorkForMyData(callBack:((Array<Any>,Bool)->())?) ->  Void {

    var dataArr = [PersonalModel]()
    let params = [
        "SESSIONID":SESSIONID,
        "mobileCode":mobileCode
        ]
    Alamofire.request(kMy_Data,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:DispatchQueue.main, options: .allowFragments) { (response) in
                        print(response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let datas =  JSOnDictory["data"].arrayValue
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(dataArr,false)
                                    setToast(str: "获取资料失败")
                                }

                                for index in 0..<datas.count {
                                    
                                    let json = datas[index]
                                    
                                    let model  = PersonalModel.setValueForPersonalModel(json: json)
                                    dataArr.append(model)
                                }
                                
                                callBack!(dataArr,true)
                            }
                                break
                        case .failure(let error):
                            print(error)
                            callBack!(dataArr,false)
                            setToast(str: "获取资料失败")
                        }
    }
    
}


//MARK:(学生端  编辑资料)接口
func upLoadImageRequest(
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
            multipartFormData.append((params["area"]!.data(using: String.Encoding.utf8)!),
                                     withName: "area")
            multipartFormData.append((params["fit_class"]!.data(using: String.Encoding.utf8)!),
                                     withName: "fit_class")
//            for i in 0..<data.count {
//                multipartFormData.append(UIImagePNGRepresentation(data[i])!, withName: "appPhoto", fileName: name[i], mimeType: "image/png")
//            }
            
            for image in data {
                let data1 = UIImageJPEGRepresentation(image, 0.5)
                let temp = Int(arc4random()%1000000000)+Int(arc4random()%1000000000)
                let imageName = "Student/User_Head_Icon\(temp)_image.png"
                multipartFormData.append(data1!, withName: "name", fileName: imageName, mimeType: "image/png")
            }
            
    },
        to: kEdit_Data,
        headers: nil,
        encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    if let value = response.result.value as? [String: AnyObject]{
                        success(value)
                        let json = JSON(value)
                        print(json)
                        if json["code"] == "1" {
                            setToast(str: "编辑资料成功")
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
public func netWorkForMyCoin(callBack:((Array<Any>,Bool)->())?) ->  Void {
    
    var dataArr = [AccountModel]()
    let params = [
        "SESSIONID":SESSIONID,
        "mobileCode":mobileCode
    ]
    
    Alamofire.request(kMy_Coin,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:DispatchQueue.main, options: .allowFragments) { (response) in
                        print(response.result)
                        switch response.result {
                        case .success:
                            
                            setToast(str: "完成")
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let datas =  JSOnDictory["data"].arrayValue
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    callBack!(dataArr,false)
                                    setToast(str: "获取学币失败")
                                }

                                for index in 0..<datas.count {
                                    
                                    let json = datas[index]
                                    
                                    let model  = AccountModel.setValueForAccountModel(json: json)
                                    dataArr.append(model)
                                }
                                
                                callBack!(dataArr,true)
                            }
                            
                            break
                        case .failure(let error):
                            print(error)
                            callBack!(dataArr,false)
                            setToast(str: "获取学币失败")
                        }
    }
    
}


//MARK:(学生端  查询指定)接口
public func netWorkForGetSpecifiedUser(params:[String:String],callBack:((Array<Any>,Bool)->())?) ->  Void {
    
    var dataArr = [FriendsModel]()
    Alamofire.request(kGet_AllPeope,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:DispatchQueue.main, options: .allowFragments) { (response) in
                        print(response.result)
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
                                if dataArr.count == 0 {
                                     setToast(str: "未找到该用户")
                                }
                                callBack!(dataArr,true)
                            }
                            break
                        case .failure(let error):
                            print(error)
                            setToast(str: "查找失败")
                            callBack!(dataArr,false)
                        }
    }
}

//MARK:(学生端  查询所有用户)接口
public func netWorkForGetAllPeope(callBack:((Array<Any>,Bool)->())?) ->  Void {
    
    var dataArr = [FriendsModel]()
    let params = [
        "SESSIONID":SESSIONID,
        "mobileCode":mobileCode
    ]
    Alamofire.request(kGet_AllPeope,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:DispatchQueue.main, options: .allowFragments) { (response) in
                        print(response.result)
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
                            print(error)
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
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:DispatchQueue.main, options: .allowFragments) { (response) in
                        print(response.result)
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
                                    setToast(str: "发送申请成功")
                                    callBack!(true)
                                }
                            }
                            break
                        case .failure(let error):
                            print(error)
                            
                            setToast(str: "发送申请失败")
                            callBack!(false)
                        }
    }

}


//MARK:14(学生端 查看好友申请表)接口
public func netWorkForApplyList(callBack:((Array<Any>,Bool)->())?) {
    
    let params = [
        "SESSIONID":SESSIONID,
        "mobileCode":mobileCode
    ]
    var dataArr = [ApplyModel]()
    Alamofire.request(kApply_List,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:DispatchQueue.main, options: .allowFragments) { (response) in
                        print(response.result)
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
                            print(error)
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
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:DispatchQueue.main, options: .allowFragments) { (response) in
                        print(response.result)
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
                                    setToast(str: "请求成功")
                                    callBack!(true)
                                }

                            }
                            break
                        case .failure(let error):
                            print(error)
                            callBack!(false)
                            setToast(str: "请求失败")
                            callBack!(false)
                        }
    }
}


//MARK:17(学生端 我的好友并按类型区分)接口
public func netWorkForMyFriend(callBack:((Array<Any>,Bool)->())?) ->  Void {
    let params = [
        "SESSIONID":SESSIONID,
        "mobileCode":mobileCode
    ]
    var dataArr = [ApplyModel]()
    Alamofire.request(kMy_Friend,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:DispatchQueue.main, options: .allowFragments) { (response) in
                        print(response.result)
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
                            print(error)
                            callBack!(dataArr,false)
                            setToast(str: "请求失败")
                        }
    }
}


//MARK:18(学生端 删除我的好友)接口
public func netWorkForDelMyFriend(params:[String:Any],callBack:((Bool)->())?) ->  Void {
    //    let dataArr = NSMutableArraRy()
    
    Alamofire.request(kdel_MyFriend,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:DispatchQueue.main, options: .allowFragments) { (response) in
                        print(response.result)
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
                                    setToast(str: "删除成功")
                                }
                            }
                            
                            callBack!(true)
                            break
                        case .failure(let error):
                            print(error)
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
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:DispatchQueue.main, options: .allowFragments) { (response) in
                        print(response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let datas =  JSOnDictory["code"].stringValue
                                if datas == "0" {
                                    setToast(str: "选择好友老师上传成功返回失败")
                                }
                            }
                            callBack!(true)
                            break
                        case .failure(let error):
                            print(error)
                            
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
                multipartFormData.append(UIImagePNGRepresentation(data[i])!, withName: "Student/Not_WorkBook\(temp)_image\(i).png", fileName: name[i], mimeType: "image/png")
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
                        print(json)
                        if json["code"] == "1" {
                            setToast(str: "创建非练习册")
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
                multipartFormData.append(UIImagePNGRepresentation(data[i])!, withName: "Student/Not_WorkBook_Next\(temp)_image\(i).png", fileName: name[i], mimeType: "image/png")
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
                        print(json)
                        if json["code"] == "1" {
                            setToast(str: "创建非练习册成功")
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
public func netWorkForMyClass(params:[String:Any],callBack:((Array<Any>,Bool)->())?) ->  Void {
    
    var dataArr = [ClassModel]()
    Alamofire.request(kMy_Classes,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:DispatchQueue.main, options: .allowFragments) { (response) in
                        print(response.result)
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
                            print(error)
                            callBack!(dataArr,false)
                            setToast(str: "请求失败")
                        }
    }
}


//MARK:25(学生端  退出班级)接口
public func netWorkForQuitClass(params:[String:Any],callBack:((Bool)->())?) ->  Void {
    Alamofire.request(kDelete_Class,
                      method: .put, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:DispatchQueue.main, options: .allowFragments) { (response) in
                        print(response.result)
                        switch response.result {
                        case .success:
                            
                            callBack!(true)
                            break
                        case .failure(let error):
                            print(error)
                            
                            callBack!(false)
                        }
    }
}


//MARK:26(学生端  学生加入班级)接口
public func netWorkForJoinClass(params:[String:Any],callBack:((Bool)->())?) ->  Void {
    Alamofire.request(kAdd_ToStudentClass,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:DispatchQueue.main, options: .allowFragments) { (response) in
                        print(response.result)
                        switch response.result {
                        case .success:
                            
                            callBack!(true)
                            break
                        case .failure(let error):
                            print(error)
                            
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
                multipartFormData.append(UIImagePNGRepresentation(data[i])!, withName: "Student/Class_WorkBook\(temp)_image\(i)", fileName: name[i], mimeType: "image/png")
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
                        print(json)
                        if json["code"] == "1" {
                            setToast(str: "创建成功")
                        }
                    }
                }
            case .failure(let encodingError):
                print(encodingError)
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
                multipartFormData.append(UIImagePNGRepresentation(data[i])!, withName: "Student/Class_WorkBook\(temp)Next_image\(i)", fileName: name[i], mimeType: "image/png")
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
                print(encodingError)
                failture(encodingError)
            }
    })
}



//MARK:29(学生端  根据课时id查询我的课时作业)接口
public func netWorkForGetMyClassBookByPeriods(params:[String:Any],callBack:((Bool)->())?) ->  Void {
    Alamofire.request(kGet_MyClassBookByPeriods,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:DispatchQueue.main, options: .allowFragments) { (response) in
                        print(response.result)
                        switch response.result {
                        case .success:
                            
                            callBack!(true)
                            break
                        case .failure(let error):
                            print(error)
                            
                            callBack!(false)
                        }
    }
}



//MARK: 31  接口说明 ： 非练习册列表展示（每页6条显示）
public func NetWorkTeacherGetExerciseList(params:[String:Any],callBack:((Array<Any>)->())?) ->  Void {
    
    var dataArr = [SNotWorkModel]()
    Alamofire.request(kGet_ExerciseList,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:DispatchQueue.main, options: .allowFragments) { (response) in
                        print(response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let code =  JSOnDictory["code"].stringValue
                                if code == "0" {
                                    setToast(str: "获取非练习册失败")
                                }
                                
                                let datas =  JSOnDictory["data"]
                                
                                for index in 0..<datas.count {
                                    let json = datas[index]
                                    let model  = SNotWorkModel.setValueForSNotWorkModel(json: json)
                                    dataArr.append(model)
                                }
                                callBack!(dataArr)
                            }
                            break
                        case .failure(let error):
                            print(error)
                            setToast(str: "获取非练习册失败")
                        }
    }
}


//MARK:32   接口说明 ： 根据练习册或者非练习册id获取相对应的知识点
public func NetWorkStudentGetKnowledgePoint(params:[String:Any],callBack:((Array<Any>,Bool)->())?) ->  Void {
    
    var dataArr = [UrlModel]()
    Alamofire.request(kGet_KnowledgePoint,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:DispatchQueue.main, options: .allowFragments) { (response) in
                        print(response.result)
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
                            print(error)
                            callBack!(dataArr,false)
                            setToast(str: "获取练习册知识点失败")
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


public func requestData(params:Any,callBack:((String)->())?) ->  Void {
//    let dataArr = NSMutableArray()
    let mainQueue = DispatchQueue.main;
           Alamofire.request("kRegistAccount",
                      method: .get, parameters: nil,
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:mainQueue, options: .allowFragments) { (response) in
                        print(response)
                        switch response.result {
                        case .success:
                            print("数据获取成功!")
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let translation =  JSOnDictory["result"]
                                
                                let product_list = translation["product_list"].arrayValue
                                
                                for index in 0..<product_list.count {
                                    
                                    let json = product_list[index]
                                    print(json)

//                                    let model  = TestModel.getTheModels(json: json)
                                    
//                                    dataArr.add(model)
                                }
//                                callBack!(dataArr as! Array<Any>)
                            }
                        case .failure(let error):
                            print(error)
                        }
    }
}

//MARK:图片上传
public func requestData(params:[String:Any],data:[Data],name:[String],callBack:((String)->())?) ->  Void {

    Alamofire.upload(multipartFormData: { (multipartFormData) in
        //666多张图片上传
        let flag = params["flag"]
        let userId = params["userId"]

        multipartFormData.append(((flag as AnyObject).data(using: String.Encoding.utf8.rawValue)!), withName: "flag")
        multipartFormData.append( ((userId as AnyObject).data(using: String.Encoding.utf8.rawValue)!), withName: "userId")

        for i in 0..<data.count {
            multipartFormData.append(data[i], withName: "appPhoto", fileName: name[i], mimeType: "image/png")
        }

    }, to: kGet_Sms) { (encodingResult) in
        switch encodingResult {
        case .success(let upload, _, _):
            upload.responseJSON { response in
                if let value = response.result.value as? [String: AnyObject]{
                    print(value)
                }
            }
        case .failure(let encodingError):
            print(encodingError)
            break
        }

    }
}

class NetWorkTools: NSObject {

}
