//
//  TheUrls.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/27.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import SwiftyUserDefaults

//MARK:必要参数
//var SESSIONIDT = "8956ssd4785955665ddddfggfg452f"
//var mobileCodeT = "sion"
var SESSIONIDT = Defaults[userToken]!

var mobileCodeT = Defaults[mCode]!
//let SESSIONIDT = "12345689piosid"
//let mobileCodeT = "sam"

//var SESSIONID = "562564455ffg5451vvc5565874512112"
//var mobileCode = "com"

//let SESSIONID = "1"
//let mobileCode = "on"

//let header = [
//    "SESSIONID":SESSIONID,
//    "mobileCode":mobileCode
//]

var SESSIONID = Defaults[userToken]!
var mobileCode = Defaults[mCode]!

//let kBaseUrl = "http://192.168.1.191:8080/duties/m/rongxing/"
let kBaseUrl = "http://101.132.120.174:8080/duties/m/rongxing/"

//MARK:注册验证码
let kGet_Sms = kBaseUrl + "user/getSms"
//MARK:验证验证码
let kcheak_Text = kBaseUrl + "user/cheakText"
//MARK:注册账号
let kUser_Signup = kBaseUrl +  "user/UserSignup"

//MARK:登录
let kLogin_api = kBaseUrl +  "user/login"

let kBaseUrlTest = "http://101.132.120.174:8080/duties/m/rongxing/"
//let kBaseUrlTest = "http://192.168.1.191:8080/duties/m/rongxing/"
//let kBaseUrlTest = kBaseUrl
//MARK: *****************老师端接口**************
//MARK: *****************老师端接口**************
//MARK: *****************老师端接口**************
//MARK: *****************老师端接口**************
//MARK: *****************老师端接口**************


//MARK:(1-0 和 1-2 获取所有的练习册)接口
let kGet_TAllWorkList = kBaseUrl +  "teacherNext/getTAllWorkList"

//MARK: 1-1 我的练习册  - 我来批改
let kAdd_MyWork = kBaseUrl +  "teacherNext/addMyWork"

//MARK:(1-1 我的练习册)接口
let kGet_MyWorkList = kBaseUrl +  "teacherNext/getMyWorkList"

//MARK:(1-1我的练习册  - 删除)接口
let kdel_MyWork = kBaseUrl +  "teacherNext/delMyWork"

//MARK:(1-3 练习册详情 根据练习册id获取详情)接口
let kGet_TWorkDetail = kBaseUrl +  "teacherNext/getTWorkDetail"


//MARK:(1-3 练习册详情 - 学生作业 》根据练习册id获取详情)接口
let kGet_TStudentWork1 = kBaseUrl +  "teacherNext/getTStudentWork1"
//let kGet_TStudentWork1 = kBaseUrl +  "teacher/getBookDetails"

//MARK:(1-3 练习册详情 - 学生作业 》学生作业详情
let kGet_TStudentWorkDetail = kBaseUrl +  "teacherNext/getworkBookList"


//MARK:(1-3 练习册详情 - 已批改 >> 根据练习册id获取详情)接口
let kGet_TStudentWork2 = kBaseUrl +  "teacherNext/getTStudentWork2"

//MARK:(1-3 练习册 - 详情 - 知识点讲解
let kGet_TStudentWork3 = kBaseUrl +  "teacherNext/getTStudentWork3"

//MARK:(1-3 练习册 - 详情 - 参考答案
let kGet_TAllAnswersByWorkId = kBaseUrl +  "teacherNext/getAllAnswersByWorkId"

//MARK:(1-3 练习册详情 - 成绩统计  》根据练习册id获取详情)接口
let kGet_TStudentWork5 = kBaseUrl +  "teacherNext/getTStudentWork5"

//MARK: 1-3-1  练习册 - 上传视频
let kGet_TWorkVideo = kBaseUrl +  "teacherNext/getTWorkVideo"

////MARK:  1-3-2 \ 2-2-2     （练习册 ，非练习册-上传图片）
let kAdd_TPic = kBaseUrl +  "teacherNext/addTPic"

//MARK:1-3-3  练习册  - 手动填写答案
let kAdd_TWorkContent = kBaseUrl +  "teacherNext/addTWorkContent"

//MARK: 1-3-4  练习册 - 上传知识点讲解
let kAdd_TWorkChapter = kBaseUrl +  "teacherNext/addTWorkChapter"

//MARK: 1-3-5 练习册 - 学生往期成绩
let kGet_TScoresByStudentId = kBaseUrl +  "teacherNext/getTScoresByStudentId"

//MARK:(2-0 查询所有非练习册数据 (不属于自己的所有fei练习册))接口
let kGet_TAllNotWork = kBaseUrlTest +  "teacher/getAllNonExercise"

//MARK:(2-1 查询所有非练习册数据 (属于自己的所有fei练习册，所有状态))接口
let kGet_TMyAllNotWork = kBaseUrlTest +  "teacher/getMyNonExercise"

//MARK:2-2 非练习册-详情 - 作业
let kGet_TMyNotWorkDatail = kBaseUrlTest +  "teacher/getNonExerciseList"

//MARK: 2-2    非练习册-详情-知识点讲解
let kGet_TMyNotWorkDatail2 = kBaseUrl +  "teacherNext/getTMyNotWorkDatail2"

//MARK:2-2    (非)练习册-详情-参考答案
let kGet_anwersByteacher = kBaseUrl +  "teacher/getanwersByteacher"

//MARK: 2-2 非练习册-详情 - 成绩统计
let kGet_TMyNotWorkDatail4 = kBaseUrl +  "teacherNext/getTMyNotWorkDatail4"

//MARK:2-2-1    非练习册-上传视频
let kAdd_TNotWorkVideo = kBaseUrl +  "teacherNext/addTNotWorkVideo"

//MARK:2-2-2    非练习册-上传文件
let kAdd_TNotWorkFile = kBaseUrl +  "teacherNext/addTNotWorkFile"

//MARK: 2-2-3    非练习册-手动填写
let kAdd_TNotWorkContent = kBaseUrl +  "teacherNext/addTNotWorkContent"

//MARK:  2-2-4    非练习册-上传知识点
let kAdd_TNotWorkChapter = kBaseUrl +  "teacherNext/addTNotWorkChapter"

//MARK: 22   我来批改
let kBulid_NonByTeacher = kBaseUrlTest +  "teacher/bulidNonByTeacher"

////MARK: 3-0 班级
//let kMy_Classes = kBaseUrl11 +  "teacher/myClasses"


//MARK:接口说明 ：4  老师第一次批改练习册
let kCorrect_WrokBook = kBaseUrlTest +  "teacher/correctWrokBook"

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
let kMy_Classes = kBaseUrlTest +  "teacher/Myclasses"

//MARK:13  接口说明 ：  解散班级
let kDelete_Myclasses = kBaseUrlTest +  "teacher/deleteMyclasses"

//MARK: 14  接口说明 ：  老师申请加入班级
let kTeacher_AddToClasses = kBaseUrlTest +  "teacher/teacherAddToClasses"

//MARK: 15 接口说明 ：   创建班级
let kBulidClasses = kBaseUrlTest +  "teacher/bulidClasses"

//MARK: 16 接口说明 ：  查询每个班级的课时目录
let kSelect_AllPeriods = kBaseUrlTest +  "teacher/selectAllPeriods"

//MARK: 17 接口说明 ：  兴建课时名称
let kBulid_periods = kBaseUrlTest +  "teacher/bulidperiods"

//MARK: 18 接口说明 ：  查查询班级作业
let kSelect_ClassBook = kBaseUrlTest +  "teacher/selectClassBook"

//MARK: 19 接口说明 ：  首次批改班级作业
let kCorrec_ClassBook = kBaseUrlTest +  "teacher/correcClassBook"

//MARK: 20 接口说明 ：  再次批改班级作业
let kCorrec_ClassBookNext = kBaseUrlTest +  "teacher/correcClassBookNext"

//MARK: 21 接口说明 ：  获取班级成员
let kGet_ClassMember = kBaseUrlTest +  "teacher/getClassMember"

//MARK: 23 接口说明 ：    老师获取练习册学生成绩，班级学生成绩（最近大课时），班级学生往期成绩列表，通用接口
let kGet_StudentScroes = kBaseUrlTest +  "teacher/getStudentScroes"

//MARK: 25 接口说明 ：  接口说明 ：  老师退出班级
let kGet_OutOfClass = kBaseUrlTest +  "teacher/outOfClass"


//MARK:(学生端4-6、老师端4-7意见和建议)接口
let kInsert_Suggestion = kBaseUrl +  "mine/insertSuggestion"

//MARK:(老师端4-3-2好友申请添加)接口
let kInsert_Friend = kBaseUrl +  "mine/insertFriend"

//MARK:照片模糊退回状态
let kGo_backWrokBookfei = kBaseUrlTest +  "teacher/gobackWrokBook"

//MARK:(老师端4-4消息中心)接口
let kGet_MsgbyTeacher = kBaseUrl +  "teacher/getMsgbyTeacher"

//MARK:(老师端4-2 我的收入)接口
let kGet_Coins = kBaseUrl +  "mine/getCoins"

//MARK:(老师端4-0我的))接口
let kGet_Users = kBaseUrl +  "mine/getUsers"

//MARK:(老师端 编辑资料)接))接口
let kUpdate_Users = kBaseUrl +  "mine/updateUsers"

//MARK:31 获取消息详情（学生）
let kGet_MsgDetailsS = kBaseUrl +  "teacher/getMsgDetails"

//MARK:31 获取消息详情（老师）
let kGet_getMsgByTeacher = kBaseUrl +  "teacher/getMsgByTeacher"

//MARK:29     接口说明 ：     删除个别消息(通用接口)，传msgId则单删除，不传msgId,删除全部
let kDel_Msg = kBaseUrl +  "teacher/delMsg"

//MARK:34     接口说明 ：    创建班级通知
let kAdd_Notify = kBaseUrl +  "teacher/addNotify"

//MARK:35     接口说明 ：    获取班级通知
let kGet_Notify = kBaseUrl +  "teacher/getNotify"

//MARK:36     接口说明 ：    同意申请加入班级通用接口
let kApply_Ok = kBaseUrl +  "teacher/applyOk"

//MARK:37     接口说明 ：    查询班级外的好友老师或者好友学生，type区分
let kInvitation_Api = kBaseUrl +  "teacher/Invitation"

//MARK:38     接口说明 ：    分别把老师和学生添加到班级
let kAdd_ToClass = kBaseUrl +  "teacher/addToClass"

//MARK:39    接口说明 ：    课时内已批改的学生成绩,可以按名字或者学号搜索
let kCheck_Ago = kBaseUrl +  "teacher/checkAgo"

//MARK:40     接口说明 ：   查询单个学生班级作业
let kGet_ClassBookList = kBaseUrl +  "teacher/getClassBookList"

//MARK:41     接口说明 ：    课时内上传课程视频
let kLoad_InClass = kBaseUrl +  "teacher/loadInClass"

//MARK:48     接口说明 ：    除班级成员
let kDel_classPel = kBaseUrl +  "teacher/delclassPel"



//MARK: *****************学生端接口**************
//MARK: *****************学生端接口**************
//MARK: *****************学生端接口**************
//MARK: *****************学生端接口**************
//MARK: *****************学生端接口**************
//let kBaseUrl = "http://192.168.1.191:8080/duties/m/rongxing/"



//MARK:1  接口说明 ：    创建支付和提现密码
let kcreat_Password = kBaseUrl +  "user/creatPassword"

//MARK:1  接口说明 ：    校验支付和提现密码的正确性
let kCheck_Password = kBaseUrl +  "user/checkPassword"

//MARK:1  接口说明 ：   修改支付和提现密码
let kCorrectPassword = kBaseUrl +  "user/correctPassword"





//MARK:1  接口说明 ：    获取所有的练习册
let kGet_AllWorkBook = kBaseUrl +  "workBook/getAllWorkBook"


//MARK:2  接口说明 ：    添加练习册
let kAdd_WorkBookToMe = kBaseUrl +  "workBook/addWorkBookToMe"


//MARK:3  接口说明 ：    我的练习册
let kMy_WorkBook = kBaseUrl +  "workBook/myWorkBook"


//MARK:4  接口说明 ：     删除我的练习册
let kDelete_MyWorkBook = kBaseUrl +  "workBook/deleteMyWorkBook"


//MARK: 5 接口说明 ：    上传图片到练习册
let kUpload_WorkBook = kBaseUrl +  "workBook/uploadWorkBook"


//MARK: 6 接口说明 ：    用户根据时间查询该练习册详情
let kGetWork_BookByTime = kBaseUrl +  "workBook/getWorkBookByTime"


//MARK:  接口说明 ：    获取用户练习册里面的所有联系日期
let kGetWork_BookTime = kBaseUrl +  "workBook/getWorkBookTime"


//MARK: 7 接口说明 ：    投诉
let kBulid_Complaint = kBaseUrl +  "workBook/bulidComplaint"


//MARK: 8 接口说明 ：    新建练习册
let kBulid_WrokBook = kBaseUrl +  "workBook/bulidWrokBook"


//MARK: 9 接口说明 ：    我的资料
let kMy_Data = kBaseUrl +  "workBook/myData"


//MARK: 10 接口说明 ：    编辑资料
let kEditor_Teacher = kBaseUrl +  "teacher/editorTeacher"

//MARK: 10 接口说明 ：    编辑资料辅助接口
let kEditor_TeacherHelp = kBaseUrl +  "teacher/potoHelp"


//MARK: 11 接口说明 ：    查询我的学币使用
let kMy_Coin = kBaseUrl +  "workBook/myCoin"


//MARK: 12 接口说明 ：    查询所有用户
let kGet_AllPeope = kBaseUrl +  "workBook/getAllPeope"


//MARK: 13  接口说明 ：    申请成为好友
let kApply_Friend = kBaseUrl +  "workBook/applyFriend"


//MARK:14  接口说明 ：    查看好友申请表
let kApply_List = kBaseUrl +  "workBook/applyList"


//MARK:15  接口说明 ：    对请求进行操作
let kDo_Allow = kBaseUrl +  "workBook/doAllow"


//MARK:16  接口说明 ：    获取用户练习册里面的所有联系日期
let kGet_WorkBookTime = kBaseUrl +  "workBook/getWorkBookTime"
//MARK:17  接口说明 ：    我的好友
let kMy_Friend = kBaseUrl +  "workBook/myFriend"

//MARK:18  接口说明 ：    删除我的好友
let kdel_MyFriend = kBaseUrl +  "workBook/delMyFriend"

//MARK: 20 接口说明 ：    创建非练习册的时候需要选择好友老师批改
let kModle_exercise = kBaseUrl +  "workBook/modle_exercise"

//MARK: 21 接口说明 ：    创建非练习册
let kBulidnon_exercise = kBaseUrlTest +  "workBook/bulidnon_exercise"

//MARK:22  接口说明 ：    再次提交非练习册练习
let kAdd_NonExerciseNext = kBaseUrl +  "workBook/addNonExerciseNext"

//MARK:23  接口说明 ：   再次提交练习册作业
let kUpload_WorkBookNext = kBaseUrl +  "workBook/uploadWorkBookNext"

//MARK:24  接口说明 ：    我的班级
let kGet_MyClass = kBaseUrl +  "workBook/getMyClass"

//MARK: 25 接口说明 ：  退出班级
let kDelete_Class = kBaseUrl +  "workBook/deleteClass"

//MARK: 26 接口说明 ：   学生加入班级
let kAdd_ToStudentClass = kBaseUrl +  "workBook/addToStudentClass"

//MARK:27  接口说明 ：   学生创建班级作业
let kBulid_ClassBook = kBaseUrl +  "workBook/bulidClassBook"

//MARK:28  接口说明 ：   学生二次提交班级作业
let kBulid_ClassBookNext = kBaseUrl +  "workBook/bulidClassBookNext"

//MARK: 29  接口说明 ：   根据课时id查询我的课时作业
let kGet_MyClassBookByPeriods = kBaseUrl +  "workBook/getMyClassBookByPeriods"

//MARK: 30  接口说明 ：   计算每个学生的学分，降序排列
let kGet_StudentScores = kBaseUrl +  "workBook/getStudentScores"

//MARK: 31接口说明 ： 非练习册列表展示（每页6条显示）
let kGet_ExerciseList = kBaseUrl +  "workBook/exerciseList"

//MARK: 32接口说明 ： 根据练习册或者非练习册id获取相对应的知识点
let kGet_KnowledgePoint = kBaseUrl +  "workBook/getKnowledgePoint"

//MARK: 33接口说明 ：参考答案下载的学币事物处理通用方法，或者学币充值
let kUp_DownAnswrs = kBaseUrl +  "workBook/updownAnswrs"

//MARK: 35接口说明 ：  非练习册，班级作业，答案表信息通用接口
let kGet_OtherAnswrs = kBaseUrl +  "workBook/getOtherAnswrs"

//MARK: 34接口说明 ： 练习册答案表信息接口
let kGet_Answrs = kBaseUrl +  "workBook/getAnswrs"

//MARK: 36接口说明 ： 判断该答案是否已经付过款，用于33接口前调用
let kCheck_Pay = kBaseUrl +  "workBook/checkPay"

//MARK: 37接口说明 ：  非练习册详情接口
let kGet_Allnon_exercise = kBaseUrl +  "workBook/getAllnon_exercise"

//MARK: 37接口说明 ：  非练习册详情接口
let kEditor_Student = kBaseUrl +  "workBook/editorStudent"



//MARK:38  接口说明 ：  练习册和非练习册，班级作业退回后重新上传通用接口
let kSecond_BulidBook = kBaseUrl +  "workBook/secondBulidBook"

//MARK:39  接口说明 ：  学生端练习册成绩统计，班级5星作业，通用接口
let kGet_Scroes = kBaseUrl +  "workBook/getScroes"


//MARK: 41接口说明 ：  个人信息（学生端）
let kGet_MsgBystudent = kBaseUrl +  "workBook/getMsgBystudent"


//MARK: 42接口说明 ：课程目录接口（学生端）
let kGet_ClassContents = kBaseUrl +  "workBook/getClassContents"

//MARK: 43接口说明 ： 判断课时课程等内容是否已经付过款
let kCheck_PayDoc = kBaseUrl +  "workBook/checkPayDoc"

//MARK: 44接口说明 ： 应获取班级课时内课时内容
let kGet_PeriodsList = kBaseUrl +  "workBook/getPeriodsList"

//MARK: 45接口说明 ： 判断课时是否已开通单次作业
let kCheck_BuyClassBook = kBaseUrl +  "workBook/checkBuyClassBook"

class TheUrls: NSObject {

}
