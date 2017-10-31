//
//  TheUrls.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/27.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//



let kBaseUrl = "http://192.168.1.122:8080/duties/m/rongxing/"

//注册验证码
let kGet_Sms = kBaseUrl + "user/getSms"
//注册账号
let kLogin_User = kBaseUrl +  "user/loginUser"



let kBaseUrl1 = "http://192.168.1.114:8080/duties/m/rongxing/"

//(学生端4-6、老师端4-7意见和建议)接口
let kInsert_Suggestion = kBaseUrl1 +  "suggest/insertSuggestion"

//(老师端3-3创建班级)接口
let kInsert_Classes = kBaseUrl1 +  "suggest/insertClasses"

//(学生端和老师端4-3-1添加好友)接口
let kInsert_Friend = kBaseUrl1 +  "suggest/insertFriend"



class TheUrls: NSObject {

}
