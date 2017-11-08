//
//  TheUrls.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/27.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//


//MARK:必要参数
//let SESSIONID = "8956ssd4785955665ddddfggfg452f"
//let mobileCode = "sion"
let SESSIONID = "562564455ffg5451vvc5565874512112"
let mobileCode = "com"
//let header = [
//    "SESSIONID":SESSIONID,
//    "mobileCode":mobileCode
//]


let kBaseUrl = "http://192.168.1.191:8080/duties/m/rongxing/"

//MARK:注册验证码
let kGet_Sms = kBaseUrl + "user/getSms"
//MARK:注册账号
let kLogin_User = kBaseUrl +  "user/loginUser"



let kBaseUrl1 = "http://192.168.1.181:8080/duties/m/rongxing/"
//MARK: *****************老师端接口**************
//MARK: *****************老师端接口**************
//MARK: *****************老师端接口**************
//MARK: *****************老师端接口**************
//MARK: *****************老师端接口**************


//MARK:(学生端4-6、老师端4-7意见和建议)接口
let kInsert_Suggestion = kBaseUrl1 +  "mine/insertSuggestion"

//MARK:(老师端4-3-2好友申请添加)接口
let kInsert_Friend = kBaseUrl1 +  "mine/insertFriend"

//MARK:(老师端4-4消息中心)接口
let kGet_Messages = kBaseUrl1 +  "mine/getMessages"

//MARK:(老师端4-2 我的收入)接口
let kGet_Coins = kBaseUrl1 +  "mine/getCoins"

//MARK:(老师端4-0我的))接口
let kGet_Users = kBaseUrl1 +  "mine/getUsers"

//MARK: *****************学生端接口**************
//MARK: *****************学生端接口**************
//MARK: *****************学生端接口**************
//MARK: *****************学生端接口**************
//MARK: *****************学生端接口**************
let kBaseUrl2 = "http://192.168.1.191:8080/duties/m/rongxing/"

//MARK:接口说明 ：    获取所有的练习册
let kGet_AllWorkBook = kBaseUrl2 +  "workBook/getAllWorkBook"


//MARK:接口说明 ：    添加练习册
let kAdd_WorkBookToMe = kBaseUrl2 +  "workBook/addWorkBookToMe"


//MARK:接口说明 ：    我的练习册
let kMy_WorkBook = kBaseUrl2 +  "workBook/myWorkBook"


//MARK:接口说明 ：     删除我的练习册
let kDelete_MyWorkBook = kBaseUrl2 +  "workBook/deleteMyWorkBook"


//MARK:接口说明 ：    上传图片到练习册
let kUpload_WorkBook = kBaseUrl2 +  "workBook/uploadWorkBook"


//MARK:接口说明 ：    用户根据时间查询该练习册详情
let kGetWork_BookByTime = kBaseUrl2 +  "workBook/getWorkBookByTime"

//MARK:接口说明 ：    获取用户练习册里面的所有联系日期
let kGetWork_BookTime = kBaseUrl2 +  "workBook/getWorkBookTime"


//MARK:接口说明 ：    投诉
let kBulid_Complaint = kBaseUrl2 +  "workBook/bulidComplaint"


//MARK:接口说明 ：    新建练习册
let kBulid_WrokBook = kBaseUrl2 +  "workBook/bulidWrokBook"


//MARK:接口说明 ：    我的资料
let kMy_Data = kBaseUrl2 +  "workBook/myData"


//MARK:接口说明 ：    编辑资料
let kEdit_Data = kBaseUrl2 +  "workBook/editoData"


//MARK:接口说明 ：    查询我的学币使用
let kMy_Coin = kBaseUrl2 +  "workBook/myCoin"


//MARK:接口说明 ：    查询所有用户
let kGet_AllPeope = kBaseUrl2 +  "workBook/getAllPeope"


//MARK:接口说明 ：    申请成为好友
let kApply_Friend = kBaseUrl2 +  "workBook/applyFriend"


//MARK:接口说明 ：    查看好友申请表
let kApply_List = kBaseUrl2 +  "workBook/applyList"


//MARK:接口说明 ：    对请求进行操作
let kDo_Allow = kBaseUrl2 +  "workBook/doAllow"


//MARK:接口说明 ：    获取用户练习册里面的所有联系日期
let kGet_WorkBookTime = kBaseUrl2 +  "workBook/getWorkBookTime"

//MARK:接口说明 ：    我的好友并按类型区分
let kMy_Friend = kBaseUrl2 +  "workBook/myFriend"

class TheUrls: NSObject {

}
