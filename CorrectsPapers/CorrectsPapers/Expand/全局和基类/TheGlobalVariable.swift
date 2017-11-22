//
//  TheGlobalVariable.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/10.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

let username = DefaultsKey<String?>("userName")
let userToken = DefaultsKey<String?>("userToken")
let userIdentity = DefaultsKey<String?>("userIdentity")

let userGrade = DefaultsKey<String?>("userGrade")
let userArea = DefaultsKey<String?>("userArea")
let userId = DefaultsKey<String?>("userId")
let userIcon = DefaultsKey<String?>("userIcon")
let userAccount = DefaultsKey<String?>("userAccount")
let userFriendCount = DefaultsKey<String?>("userFriendCount")
let messageNum = DefaultsKey<String?>("messageNum")



let kTeacher = "kTeacherIdentify"
let kStudent = "kStudentIdentify"



let kSCREEN_WIDTH = UIScreen.main.bounds.size.width
let kSCREEN_HEIGHT = UIScreen.main.bounds.size.height
let kSCREEN_SIZE = UIScreen.main.bounds.size
let kSCREEN_SCALE = kSCREEN_WIDTH/720



let kFont20 = UIFont.systemFont(ofSize: kSCREEN_SCALE * 20)
let kFont22 = UIFont.systemFont(ofSize: kSCREEN_SCALE * 22)
let kFont24 = UIFont.systemFont(ofSize: kSCREEN_SCALE * 24)
let kFont26 = UIFont.systemFont(ofSize: kSCREEN_SCALE * 26)
let kFont28 = UIFont.systemFont(ofSize: kSCREEN_SCALE * 28)
let kFont30 = UIFont.systemFont(ofSize: kSCREEN_SCALE * 30)
let kFont32 = UIFont.systemFont(ofSize: kSCREEN_SCALE * 32)
let kFont34 = UIFont.systemFont(ofSize: kSCREEN_SCALE * 34)
let kFont36 = UIFont.systemFont(ofSize: kSCREEN_SCALE * 36)
let kFont38 = UIFont.systemFont(ofSize: kSCREEN_SCALE * 38)
let kFont40 = UIFont.systemFont(ofSize: kSCREEN_SCALE * 40)
let kFont42 = UIFont.systemFont(ofSize: kSCREEN_SCALE * 42)
let kFont44 = UIFont.systemFont(ofSize: kSCREEN_SCALE * 44)
let kFont46 = UIFont.systemFont(ofSize: kSCREEN_SCALE * 46)




var timeInterval = 3600

//MARK:全局定时器（练习册）
var kTimer = Timer()

var timeInterval2 = 3600
//MARK:全局定时器（班级）
var kTimer2 = Timer()

//选择器的高度
let DateHeight = 788 * kSCREEN_SCALE


//MARK:是否需要
var kHiddenTextView = 123135





func getColorWithNotAlphe(_ seting : CLongLong) -> UIColor {
    
    let red = CGFloat(((seting & 0xFF0000) >> 16)) / 255.0;
    let green = CGFloat(((seting & 0x00FF00) >> 8)) / 255.0;
    let blue = CGFloat(seting & 0x0000FF) / 255.0;
    
    return UIColor.init(red: red, green: green, blue: blue, alpha: 1.0)
}


func kSetRGBColor (r:CGFloat, g:CGFloat, b:CGFloat) -> UIColor {
    return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1)
    
}

func kSetRGBAColor (r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    
}

func kMainColor() -> UIColor {
    return kSetRGBColor(r: 0, g: 180, b: 255)
}



func kTextColor() -> UIColor {
    return kSetRGBColor(r: 69, g: 69, b: 69)
}

func kBGColor() -> UIColor {
    return kSetRGBColor(r: 239, g: 239, b: 244)
}

func kGaryColor(num : NSInteger) -> UIColor {
    return kSetRGBColor(r: CGFloat(num), g: CGFloat(num), b: CGFloat(num))
}

//MARK: 获得渐变背景颜色
func getNavigationIMG(_ height: NSInteger,fromColor:UIColor,toColor:UIColor) -> UIImage {
    
    let view = UIView(frame: CGRect(x:0, y:0, width:Int(kSCREEN_WIDTH), height:height))
    view.layer.insertSublayer(getNavigationView(height, fromColor: fromColor, toColor: toColor), at: 0)
    UIGraphicsBeginImageContext(view.bounds.size)
    view.layer.render(in: UIGraphicsGetCurrentContext()!)
    
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return image!
}

//MARK: 获得渐变背景颜色
func getNavigationView(_ height: NSInteger,fromColor:UIColor,toColor:UIColor) -> CAGradientLayer {
    let gradient = CAGradientLayer()
    gradient.frame = CGRect(x:0, y:0, width:Int(kSCREEN_WIDTH), height:height)
    gradient.colors = [fromColor.cgColor,toColor.cgColor]
    gradient.startPoint = CGPoint.init(x: 0, y: 0.5)
    gradient.endPoint = CGPoint.init(x: 1, y: 0.5)
    return gradient
    
}


//MARK: 设置一个提醒

func setToast(str:String) {
    
    let window = UIApplication.shared.keyWindow
    let width = getLabWidth(labelStr: str, font: UIFont.systemFont(ofSize: 15), height: 20)
    let label = UILabel.init(frame: CGRect (x: 0, y: 0, width: width + 12, height: 30))
    label.backgroundColor = kMainColor()
    label.layer.cornerRadius = 6
    label.clipsToBounds = true
    label.center = CGPoint(x: kSCREEN_WIDTH/2, y: kSCREEN_HEIGHT/2)
    label.textColor = UIColor.white
    label.text = str
    label.textAlignment = .center
    label.font = UIFont.systemFont(ofSize: 15)
    label.alpha = 0
    window?.addSubview(label)
    
    UIView.animate(withDuration: 0.15) {
        label.alpha = 1
    }
    
    let time: TimeInterval = 1.7
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
        
        UIView.animate(withDuration: 0.18, delay: 0, options: .layoutSubviews, animations: {
            label.alpha = 0
        }, completion: { (s) in
            label.removeFromSuperview()
            print("移除提醒")
        })
    }
}

//MARK:获取字符串的宽度的封装
func getLabWidth(labelStr:String,font:UIFont,height:CGFloat) -> CGFloat {
    
    let statusLabelText: NSString = labelStr as NSString
    
    let size = CGSize(width: 900, height: height)
    
    let dic = NSDictionary(object: font, forKey: NSAttributedStringKey.font as NSCopying)
    
    let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [NSAttributedStringKey : Any], context:nil).size
    
    return strSize.width
}


//MARK:获取字符串的宽度的封装
func KGetLabWidth(labelStr:String,font:UIFont,height:CGFloat) -> CGFloat {
    
    let statusLabelText: NSString = labelStr as NSString
    
    let size = CGSize(width: 900, height: height)
    
    let dic = NSDictionary(object: font, forKey: NSAttributedStringKey.font as NSCopying)
    
    let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [NSAttributedStringKey : Any], context:nil).size
    
    return strSize.width + 10
}

//MARK:转Utf-8
func StringToUTF_8InUrl(str:String) -> (URL){
    
    let OCString = str as NSString
    
    let urlString = OCString.addingPercentEscapes(using: String.Encoding.utf8.rawValue)
    
    return URL(string: urlString!)!
}



//MARK:获取状态
func kGetStateFromString(str:String) -> (String){
    
    if str == "1" {
        return "未上传"
    }
    
    if str == "2" {
        return "未批改"
    }
    
    if str == "3" {
        return "退回"
    }

    if str == "4" {
        return "已批改"
    }

    if str == "5" {
        return "错题未批改"
    }

    if str == "6" {
        return "错题已退回"
    }

    if str == "7" {
        return "批改已完成"
    }

    return ""
}

//MARK:获取颜色
func kGetColorFromString(str:String) -> (UIColor){
    
    if str == "未上传" {
        return kSetRGBColor(r: 95, g: 95, b: 95)
    }
    
    if str == "未批改" {
        return kSetRGBColor(r: 255, g: 153, b: 0)
    }
    
    if str == "退回" {
        return kSetRGBColor(r: 255, g: 78, b: 78)
    }
    
    if str == "已批改" {
        return kSetRGBColor(r: 102, g: 204, b: 0)
    }
    
    if str == "错题未批改" {
        return kSetRGBColor(r: 255, g: 153, b: 0)
    }
    
    if str == "错题已退回"{
    return kSetRGBColor(r: 255, g: 65, b: 65)
    }
    
    if str == "批改已完成" {
        return kSetRGBColor(r: 102, g: 204, b: 0)
    }
    
    return kSetRGBColor(r: 255, g: 78, b: 78)
}



class TheGlobalVariable: NSObject {

}
