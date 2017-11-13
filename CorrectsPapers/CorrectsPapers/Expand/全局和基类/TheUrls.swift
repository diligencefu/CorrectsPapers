//
//  TheUrls.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/27.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//


//MARK:必要参数
let SESSIONID = "8956ssd4785955665ddddfggfg452f"
let mobileCode = "sion"
//let SESSIONID = "562564455ffg5451vvc5565874512112"
//let mobileCode = "com"

let SESSIONIDT = "12345689piosid"
let mobileCodeT = "sam"


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
let kBaseUrl11 = "http://192.168.1.230:8080/duties/m/rongxing/"
//MARK: *****************老师端接口**************
//MARK: *****************老师端接口**************
//MARK: *****************老师端接口**************
//MARK: *****************老师端接口**************
//MARK: *****************老师端接口**************

//MARK:(1-0 和 1-2 获取所有的练习册)接口
let kGet_TAllWorkList = kBaseUrl11 +  "teacher/getTAllWorkList"


//MARK:(1-1 我的练习册)接口
let kGet_MyWorkList = kBaseUrl11 +  "teacher/getMyWorkList"

//MARK:(1-1我的练习册  - 删除)接口
let kdel_MyWork = kBaseUrl11 +  "teacher/delMyWork"

//MARK:(1-3 练习册详情 根据练习册id获取详情)接口
let kGet_TWorkDetail = kBaseUrl11 +  "teacher/getTWorkDetail"


//MARK:(1-3 练习册详情 - 学生作业 》根据练习册id获取详情)接口
let kGet_TStudentWork1 = kBaseUrl11 +  "teacher/getTStudentWork1"


//MARK:(1-3 练习册详情 - 已批改 >> 根据练习册id获取详情)接口
let kGet_TStudentWork2 = kBaseUrl11 +  "teacher/getTStudentWork2"

//MARK:(1-3 练习册 - 详情 - 知识点讲解
let kGet_TStudentWork3 = kBaseUrl11 +  "teacher/getTStudentWork3"

//MARK:(1-3 练习册 - 详情 - 参考答案
let kGet_TStudentWork4 = kBaseUrl11 +  "teacher/getTStudentWork4"

//MARK:(1-3 练习册详情 - 成绩统计  》根据练习册id获取详情)接口
let kGet_TStudentWork5 = kBaseUrl11 +  "teacher/getTStudentWork5"


//MARK:(2-0 查询所有非练习册数据 (不属于自己的所有fei练习册))接口
let kGet_TAllNotWork = kBaseUrl11 +  "teacher/getTAllNotWork"


//MARK:(2-1 查询所有非练习册数据 (属于自己的所有fei练习册，所有状态))接口
let kGet_TMyAllNotWork = kBaseUrl11 +  "teacher/getTMyAllNotWork"


//MARK:(1-3 练习册详情 - 成绩统计  》根据练习册id获取详情)接口
//let kGet_TAllWorkList = kBaseUrl1 +  "teacher/getTAllWorkList"


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
//MARK:接口说明 ：    我的好友
let kMy_Friend = kBaseUrl2 +  "workBook/myFriend"

//MARK:接口说明 ：    删除我的好友
let kdel_MyFriend = kBaseUrl2 +  "workBook/delMyFriend"
//MARK:接口说明 ：    创建非练习册的时候需要选择好友老师批改
let kModle_exercise = kBaseUrl2 +  "workBook/modle_exercise"
//MARK:接口说明 ：    创建非练习册
let kBulidnon_exercise = kBaseUrl2 +  "workBook/bulidnon_exercise"
//MARK:接口说明 ：    再次提交非练习册练习
let kAdd_NonExerciseNext = kBaseUrl2 +  "workBook/addNonExerciseNext"
//MARK:接口说明 ：   再次提交练习册作业
let kUpload_WorkBookNext = kBaseUrl2 +  "workBook/uploadWorkBookNext"

class TheUrls: NSObject {

}
