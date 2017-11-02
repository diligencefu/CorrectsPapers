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
                            print(error)
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
                            print(error)

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
                            print(error)

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
                            print(error)

                            setToast(str: "添加好友失败")
                        }
    }
    
}


//MARK: *****************学生端接口**************
//MARK: *****************学生端接口**************
//MARK: *****************学生端接口**************
//MARK: *****************学生端接口**************
//MARK: *****************学生端接口**************


//MARK:(学生端获取所有的练习册)接口
public func netWorkForGetAllWorkBook(callBack:((Array<Any>)->())?) -> Void {
    
    var dataArr = [WorkBookModel]()
    Alamofire.request(kGet_AllWorkBook,
                      method: .get, parameters: nil,
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:DispatchQueue.main, options: .allowFragments) { (response) in
                        print(response.result)
                        switch response.result {
                        case .success:
                            
                            setToast(str: "完成")
                            
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let datas =  JSOnDictory["data"].arrayValue
                                
                                for index in 0..<datas.count {
                                    
                                    let json = datas[index]
                                    let model  = WorkBookModel.setValueForWorkBookModel(json: json)
                                    dataArr.append(model)
                                }
                                callBack!(dataArr)
                            }

                            break
                        case .failure(let error):
                            print(error)

                            callBack!(dataArr)
                            setToast(str: "获取所有的练习册失败")
                        }
    }
    
}

//MARK:(学生端搜索练习册)接口
public func netWorkForSearchWorkBook(params:[String:Any],callBack:((String)->())?) ->  Void {
    //    let dataArr = NSMutableArraRy()
    
    Alamofire.request(kGet_AllWorkBook,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:DispatchQueue.main, options: .allowFragments) { (response) in
                        print(response.result)
                        switch response.result {
                        case .success:
                            
                            setToast(str: "完成")
                            break
                        case .failure(let error):
                            print(error)

                            setToast(str: "获取所有的练习册失败")
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
                            
                            setToast(str: "完成")
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
public func netWorkForMyWorkBook(callBack:((Array<Any>)->())?) ->  Void {
    
    var dataArr = [WorkBookModel]()
    let dic = ["SESSIONID":"562564455ffg5451vvc5565874512112","mobileCode":"com"]    
    
    Alamofire.request(kMy_WorkBook,
                      method: .get, parameters: nil,
                      encoding: URLEncoding.default, headers: dic).responseJSON(queue:DispatchQueue.main, options: .allowFragments) { (response) in
                        print(response.result)
                        switch response.result {
                        case .success:
                            
                            setToast(str: "完成")
                            
                            
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let datas =  JSOnDictory["data"].arrayValue
                                
                                for index in 0..<datas.count {
                                    
                                    let json = datas[index]

                                    let model  = WorkBookModel.setValueForWorkBookModel(json: json)
                                    dataArr.append(model)
                                }
                                
                                callBack!(dataArr)
                            }

                            
                            break
                        case .failure(let error):
                            print(error)

                            setToast(str: "我的练习册失败")
                        }
    }
    
}


//MARK:(学生端  删除我的练习册)接口
public func netWorkForDeleteMyWorkBook(params:[String:Any],callBack:((String)->())?) ->  Void {
    //    let dataArr = NSMutableArraRy()
    
    Alamofire.request(kDelete_MyWorkBook,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:DispatchQueue.main, options: .allowFragments) { (response) in
                        print(response.result)
                        switch response.result {
                        case .success:
                            setToast(str: "完成")
                            callBack!("done")
                            break
                        case .failure(let error):
                            print(error)

                            setToast(str: "删除我的练习册失败")
                        }
    }
    
}


//MARK:(学生端  上传图片到练习册)接口
public func netWorkForUploadWorkBook(params:[String:Any],callBack:((String)->())?) ->  Void {
    //    let dataArr = NSMutableArraRy()
    
    Alamofire.request(kUpload_WorkBook,
                      method: .post, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:DispatchQueue.main, options: .allowFragments) { (response) in
                        print(response.result)
                        switch response.result {
                        case .success:
                            
                            setToast(str: "完成")
                            break
                        case .failure(let error):
                            print(error)

                            setToast(str: "上传图片到练习册失败")
                        }
    }
    
}


//MARK:(学生端  用户根据时间查询该练习册详情)接口
public func netWorkForGetWorkBookByTime(params:[String:Any],callBack:((Array<Any>)->())?) ->  Void {
    
    var dataArr = [BookDetailModel]()
    Alamofire.request(kGetWork_BookByTime,
                      method: .post, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:DispatchQueue.main, options: .allowFragments) { (response) in
                        print(response.result)
                        switch response.result {
                        case .success:
                            
                            setToast(str: "完成")
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let datas =  JSOnDictory["data"].arrayValue
                                
                                for index in 0..<datas.count {
                                    
                                    let json = datas[index]
                                    
                                    let model  = BookDetailModel.setValueForBookDetailModel(json: json)
                                    dataArr.append(model)
                                }
                                
                                callBack!(dataArr)
                            }

                            break
                        case .failure(let error):
                            print(error)

                            setToast(str: "用户根据时间查询失败")
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
                            
                            setToast(str: "完成")
                            callBack!(true)
                            break
                        case .failure(let error):
                            print(error)

                            setToast(str: " 投诉失败")
                            callBack!(false)
                        }
    }
    
}


//MARK:(学生端  新建练习册)接口
public func netWorkForBulidWrokBook(params:[String:Any],callBack:((Bool)->())?) ->  Void {
    //    let dataArr = NSMutableArraRy()
    
    Alamofire.request(kBulid_WrokBook,
                      method: .post, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:DispatchQueue.main, options: .allowFragments) { (response) in
                        print(response.result)
                        switch response.result {
                        case .success:
                            
//                            setToast(str: "创建成功")
                            callBack!(true)
                            break
                        case .failure(let error):
                            print(error)

                            setToast(str: "新建练习册失败")
                            callBack!(false)
                        }
    }
    
}


//MARK:(学生端  我的资料)接口
public func netWorkForMyData(callBack:((Array<Any>)->())?) ->  Void {

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
                                
                                for index in 0..<datas.count {
                                    
                                    let json = datas[index]
                                    
                                    let model  = PersonalModel.setValueForPersonalModel(json: json)
                                    dataArr.append(model)
                                }
                                
                                callBack!(dataArr)
                            }
                                break
                        case .failure(let error):
                            print(error)

                            setToast(str: "我的资料失败")
                        }
    }
    
}



//MARK:(学生端  编辑资料)接口
public func netWorkForEditoData(params:[String:Any],callBack:((String)->())?) ->  Void {
    //    let dataArr = NSMutableArraRy()
    
    Alamofire.request(kEdit_Data,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:DispatchQueue.main, options: .allowFragments) { (response) in
                        print(response.result)
                        switch response.result {
                        case .success:
                            
                            setToast(str: "完成")
                            callBack!("")
                            break
                        case .failure(let error):
                            print(error)

                            setToast(str: "编辑资料失败")
                        }
    }
    
}

//MARK:(学生端 查询我的学币使用)接口
public func netWorkForMyCoin(callBack:((String)->())?) ->  Void {
    //    let dataArr = NSMutableArraRy()
    
    let params = [
        "SESSIONID":SESSIONID,
        "mobileCode":mobileCode
    ]
    
    Alamofire.request(kMy_Coin,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON(queue:DispatchQueue.main, options: .allowFragments) { (response) in
                        print(response.result.value!)
                        switch response.result {
                        case .success:
                            
                            setToast(str: "完成")
                            break
                        case .failure(let error):
                            print(error)

                            setToast(str: "查询我的学币使用失败")
                        }
    }
    
}


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
                                
                                for index in 0...product_list.count-1 {
                                    
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
