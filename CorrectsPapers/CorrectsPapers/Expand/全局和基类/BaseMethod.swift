//
//  BaseMethod.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/30.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

//  验证身份证号
func validateIdentityCardNumber(identityCard:String) -> Bool {
    
    if identityCard.characters.count > 0 {
        let regex2 = "^(\\d{14}|\\d{17})(\\d|[xX])$"
        let identityCardPredicate = NSPredicate.init(format: "SELF MATCHES"+regex2, CVarArg.self as! CVarArg)
        return identityCardPredicate.evaluate(with: identityCard)
    }
    return false
}


//*  分割字符串，并且取第一个字符串
func compareDateWithChar(date:String,char:String) -> String {
    
    let arr = date.components(separatedBy: char)
    return arr[0]
    
}


//判断手机号
func validateTelNumber(num:NSString)->Bool
 {
  
    let mobile = "^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$"
  
    let  CM = "^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$"
 
    let  CU = "^1(3[0-2]|5[256]|8[56])\\d{8}$"
  
    let  CT = "^1((33|53|8[09])[0-9]|349)\\d{7}$"
  
    let regextestmobile = NSPredicate(format: "SELF MATCHES %@",mobile)
  
    let regextestcm = NSPredicate(format: "SELF MATCHES %@",CM )
  
    let regextestcu = NSPredicate(format: "SELF MATCHES %@" ,CU)
   
    let regextestct = NSPredicate(format: "SELF MATCHES %@" ,CT)
  
    if (regextestmobile.evaluate(with: num) == true)
        || (regextestcm.evaluate(with: num) == true)
        || (regextestct.evaluate(with: num) == true)
        || (regextestcu.evaluate(with: num) == true)
    {
        
        return true
    }else{
        
        return false
    }
 }


//  验证邮箱
func validateEmail(identityCard:String) -> Bool {
    
    if identityCard.characters.count > 0 {
        let regex2 = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
        let identityCardPredicate = NSPredicate.init(format: "SELF MATCHES"+regex2, CVarArg.self as! CVarArg)
        return identityCardPredicate.evaluate(with: identityCard)
    }
    return false
}


class BaseMethod: NSObject {

}
