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
                            
                            setToast(str: "完成")
                            callBack!("haha")
                            break
                        case .failure(let error):
                            
                            setToast(str: "注册失败")
                        }
    }
   
}


//MARK:意见和建议
public func netWorkForSuggestion(params:[String:Any],callBack:((String)->())?) ->  Void {
    //    let dataArr = NSMutableArraRy()
    let mainQueue = DispatchQueue.main;
    
    Alamofire.request(kInsert_Suggestion,
                      method: .post, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:mainQueue, options: .allowFragments) { (response) in
                        print(response.result)
                        switch response.result {
                        case .success:
                            
                            setToast(str: "完成")
                            break
                        case .failure(let error):
                            
                            setToast(str: "反馈意见和建议失败")
                        }
    }
    
}


//MARK:(老师端3-3创建班级)接口
public func netWorkForInsertClasses(params:[String:Any],callBack:((String)->())?) ->  Void {
    //    let dataArr = NSMutableArraRy()

    Alamofire.request(kInsert_Classes,
                      method: .post,
                      parameters: params,
                      encoding: URLEncoding.default,
                      headers: nil).responseJSON(queue:DispatchQueue.main,
                                                 options: .allowFragments)
                      { (response) in
                        
                        print(response.result)
                        switch response.result {
                        case .success:
                            setToast(str: "完成")
                            break
                        case .failure(let error):
                            
                            setToast(str: "创建班级失败")
                        }
    }
    
}


//MARK:(学生端和老师端4-3-1添加好友)接口
public func netWorkForInsertFriends(params:[String:Any],callBack:((String)->())?) ->  Void {
    //    let dataArr = NSMutableArraRy()
    
    Alamofire.request(kInsert_Friend,
                      method: .post, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:DispatchQueue.main, options: .allowFragments) { (response) in
                        print(response.result)
                        switch response.result {
                        case .success:
                            
                            setToast(str: "完成")
                            break
                        case .failure(let error):
                            
                            setToast(str: "添加好友失败")
                        }
    }
    
}


public func requestData(params:Any,callBack:((String)->())?) ->  Void {
    let dataArr = NSMutableArray()
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
                                
                                for index in 0...product_list.count-1 {
                                    
                                    let json = product_list[index]

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

//    Alamofire.upload(multipartFormData: { (multipartFormData) in
//        //666多张图片上传
//        let flag = params["flag"]
//        let userId = params["userId"]
//
//        multipartFormData.append(((flag as AnyObject).data(using: String.Encoding.utf8.rawValue)!), withName: "flag")
//        multipartFormData.append( ((userId as AnyObject).data(using: String.Encoding.utf8.rawValue)!), withName: "userId")
//
//        for i in 0..<data.count {
//            multipartFormData.append(data[i], withName: "appPhoto", fileName: name[i], mimeType: "image/png")
//        }
//
//    }, to: kRegistAccount) { (encodingResult) in
//        switch encodingResult {
//        case .success(let upload, _, _):
//            upload.responseJSON { response in
//                if let value = response.result.value as? [String: AnyObject]{
//
//                }
//            }
//        case .failure(let encodingError):
//
//            break
//        }
//
//    }
}

class NetWorkTools: NSObject {

}
