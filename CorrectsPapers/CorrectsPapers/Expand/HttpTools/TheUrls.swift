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

//MARK: 1-1 我的练习册  - 我来批改
let kAdd_MyWork = kBaseUrl11 +  "teacher/addMyWork"

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
let kGet_TAllAnswersByWorkId = kBaseUrl11 +  "teacher/getAllAnswersByWorkId"

//MARK:(1-3 练习册详情 - 成绩统计  》根据练习册id获取详情)接口
let kGet_TStudentWork5 = kBaseUrl11 +  "teacher/getTStudentWork5"

//MARK: 1-3-1  练习册 - 上传视频
let kGet_TWorkVideo = kBaseUrl11 +  "teacher/getTWorkVideo"

////MARK:  1-3-2 \ 2-2-2     （练习册 ，非练习册-上传图片）
let kAdd_TPic = kBaseUrl11 +  "teacher/addTPic"

//MARK:1-3-3  练习册  - 手动填写答案
let kAdd_TWorkContent = kBaseUrl11 +  "teacher/addTWorkContent"

//MARK: 1-3-4  练习册 - 上传知识点讲解
let kAdd_TWorkChapter = kBaseUrl11 +  "teacher/addTWorkChapter"

//MARK: 1-3-5 练习册 - 学生往期成绩
let kGet_TScoresByStudentId = kBaseUrl11 +  "teacher/getTScoresByStudentId"

//MARK:(2-0 查询所有非练习册数据 (不属于自己的所有fei练习册))接口
let kGet_TAllNotWork = kBaseUrl11 +  "teacher/getTAllNotWork"

//MARK:(2-1 查询所有非练习册数据 (属于自己的所有fei练习册，所有状态))接口
let kGet_TMyAllNotWork = kBaseUrl11 +  "teacher/getTMyAllNotWork"

//MARK:2-2 非练习册-详情 - 作业
let kGet_TMyNotWorkDatail = kBaseUrl11 +  "teacher/getTMyNotWorkDatail"

//MARK: 2-2    非练习册-详情-知识点讲解
let kGet_TMyNotWorkDatail2 = kBaseUrl11 +  "teacher/getTMyNotWorkDatail2"

//MARK:2-2    非练习册-详情-参考答案
let kGet_TMyNotWorkDatail3 = kBaseUrl11 +  "teacher/getTMyNotWorkDatail3"

//MARK: 2-2 非练习册-详情 - 成绩统计
let kGet_TMyNotWorkDatail4 = kBaseUrl11 +  "teacher/getTMyNotWorkDatail4"

//MARK:2-2-1    非练习册-上传视频
let kAdd_TNotWorkVideo = kBaseUrl11 +  "teacher/addTNotWorkVideo"

//MARK:2-2-2    非练习册-上传文件
let kAdd_TNotWorkFile = kBaseUrl11 +  "teacher/addTNotWorkFile"

//MARK: 2-2-3    非练习册-手动填写
let kAdd_TNotWorkContent = kBaseUrl11 +  "teacher/addTNotWorkContent"

//MARK:  2-2-4    非练习册-上传知识点
let kAdd_TNotWorkChapter = kBaseUrl11 +  "teacher/addTNotWorkChapter"


////MARK: 3-0 班级
//let kMy_Classes = kBaseUrl11 +  "teacher/myClasses"


//MARK:接口说明 ：4  老师第一次批改练习册
let kCorrect_WrokBook = kBaseUrl +  "teacher/correctWrokBook"

//MARK:接口说明 ： 5  照片模糊退回状态
let kgoback_WrokBook = kBaseUrl +  "teacher/gobackWrokBook"

//MARK:接口说明 ：6  再次批改练习册
let kCorrect_NextWrokBook = kBaseUrl +  "teacher/correctNextWrokBook"

//MARK:接口说明 ：10  老师第一次批改非练习册
let kCorrect_NonExercise = kBaseUrl +  "teacher/correctNonExercise"

////MARK:接口说明 ： 5  照片模糊退回状态
//let kgoback_WrokBook = kBaseUrl +  "teacher/gobackWrokBook"
//
//MARK:接口说明 ：11  老师再次批改非练习册
let kCorrect_NonExerciseNext = kBaseUrl +  "teacher/correctNonExerciseNext"

//MARK:12  接口说明 ：    我的班级
let kMy_Classes = kBaseUrl2 +  "teacher/Myclasses"

//MARK:13  接口说明 ：  解散班级
let kDelete_Myclasses = kBaseUrl +  "teacher/deleteMyclasses"

//MARK: 14  接口说明 ：  老师申请加入班级
let kTeacher_AddToClasses = kBaseUrl +  "teacher/teacherAddToClasses"

//MARK: 15 接口说明 ：   创建班级
let kBulidClasses = kBaseUrl +  "teacher/bulidClasses"

//MARK: 16 接口说明 ：  查询每个班级的课时目录
let kSelect_AllPeriods = kBaseUrl +  "teacher/selectAllPeriods"

//MARK: 17 接口说明 ：  兴建课时名称
let kBulid_periods = kBaseUrl +  "teacher/bulidperiods"

//MARK: 18 接口说明 ：  查查询班级作业
let kSelect_ClassBook = kBaseUrl +  "teacher/selectClassBook"

//MARK: 19 接口说明 ：  首次批改班级作业
let kCorrec_ClassBook = kBaseUrl +  "teacher/correcClassBook"

//MARK: 20 接口说明 ：  再次批改班级作业
let kCorrec_ClassBookNext = kBaseUrl +  "teacher/correcClassBookNext"

//MARK: 21 接口说明 ：  获取班级成员
let kGet_ClassMember = kBaseUrl +  "teacher/getClassMember"

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


//MARK:(老师端 编辑资料)接))接口
let kUpdate_Users = kBaseUrl1 +  "mine/updateUsers"




//MARK: *****************学生端接口**************
//MARK: *****************学生端接口**************
//MARK: *****************学生端接口**************
//MARK: *****************学生端接口**************
//MARK: *****************学生端接口**************
let kBaseUrl2 = "http://192.168.1.191:8080/duties/m/rongxing/"

//MARK:1  接口说明 ：    获取所有的练习册
let kGet_AllWorkBook = kBaseUrl2 +  "workBook/getAllWorkBook"


//MARK:2  接口说明 ：    添加练习册
let kAdd_WorkBookToMe = kBaseUrl2 +  "workBook/addWorkBookToMe"


//MARK:3  接口说明 ：    我的练习册
let kMy_WorkBook = kBaseUrl2 +  "workBook/myWorkBook"


//MARK:4  接口说明 ：     删除我的练习册
let kDelete_MyWorkBook = kBaseUrl2 +  "workBook/deleteMyWorkBook"


//MARK: 5 接口说明 ：    上传图片到练习册
let kUpload_WorkBook = kBaseUrl2 +  "workBook/uploadWorkBook"


//MARK: 6 接口说明 ：    用户根据时间查询该练习册详情
let kGetWork_BookByTime = kBaseUrl2 +  "workBook/getWorkBookByTime"

//MARK:  接口说明 ：    获取用户练习册里面的所有联系日期
let kGetWork_BookTime = kBaseUrl2 +  "workBook/getWorkBookTime"


//MARK: 7 接口说明 ：    投诉
let kBulid_Complaint = kBaseUrl2 +  "workBook/bulidComplaint"


//MARK: 8 接口说明 ：    新建练习册
let kBulid_WrokBook = kBaseUrl2 +  "workBook/bulidWrokBook"


//MARK: 9 接口说明 ：    我的资料
let kMy_Data = kBaseUrl2 +  "workBook/myData"


//MARK: 10 接口说明 ：    编辑资料
let kEdit_Data = kBaseUrl2 +  "workBook/editoData"


//MARK: 11 接口说明 ：    查询我的学币使用
let kMy_Coin = kBaseUrl2 +  "workBook/myCoin"


//MARK: 12 接口说明 ：    查询所有用户
let kGet_AllPeope = kBaseUrl2 +  "workBook/getAllPeope"


//MARK: 13  接口说明 ：    申请成为好友
let kApply_Friend = kBaseUrl2 +  "workBook/applyFriend"


//MARK:14  接口说明 ：    查看好友申请表
let kApply_List = kBaseUrl2 +  "workBook/applyList"


//MARK:15  接口说明 ：    对请求进行操作
let kDo_Allow = kBaseUrl2 +  "workBook/doAllow"


//MARK:16  接口说明 ：    获取用户练习册里面的所有联系日期
let kGet_WorkBookTime = kBaseUrl2 +  "workBook/getWorkBookTime"
//MARK:17  接口说明 ：    我的好友
let kMy_Friend = kBaseUrl2 +  "workBook/myFriend"

//MARK:18  接口说明 ：    删除我的好友
let kdel_MyFriend = kBaseUrl2 +  "workBook/delMyFriend"

//MARK: 20 接口说明 ：    创建非练习册的时候需要选择好友老师批改
let kModle_exercise = kBaseUrl2 +  "workBook/modle_exercise"

//MARK: 21 接口说明 ：    创建非练习册
let kBulidnon_exercise = kBaseUrl2 +  "workBook/bulidnon_exercise"

//MARK:22  接口说明 ：    再次提交非练习册练习
let kAdd_NonExerciseNext = kBaseUrl2 +  "workBook/addNonExerciseNext"

//MARK:23  接口说明 ：   再次提交练习册作业
let kUpload_WorkBookNext = kBaseUrl2 +  "workBook/uploadWorkBookNext"

//MARK:24  接口说明 ：    我的班级
let kGet_MyClass = kBaseUrl2 +  "workBook/getMyClass"

//MARK: 25 接口说明 ：  退出班级
let kDelete_Class = kBaseUrl2 +  "workBook/deleteClass"

//MARK: 26 接口说明 ：   学生加入班级
let kAdd_ToStudentClass = kBaseUrl2 +  "workBook/addToStudentClass"

//MARK:27  接口说明 ：   学生创建班级作业
let kBulid_ClassBook = kBaseUrl2 +  "workBook/bulidClassBook"

//MARK:28  接口说明 ：   学生二次提交班级作业
let kBulid_ClassBookNext = kBaseUrl2 +  "workBook/bulidClassBookNext"

//MARK: 29  接口说明 ：   根据课时id查询我的课时作业
let kGet_MyClassBookByPeriods = kBaseUrl2 +  "workBook/getMyClassBookByPeriods"

//MARK: 30  接口说明 ：   计算每个学生的学分，降序排列
let kGet_StudentScores = kBaseUrl2 +  "workBook/getStudentScores"




class TheUrls: NSObject {

}
