//
//  UploadVideoViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/10.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class UploadVideoViewController: BaseViewController ,UIAlertViewDelegate{

    var titleArr = ["添加视频描述","添加视频链接"]
//    是不是参考答案的视频地址
    var isAnswer = false
    var currentType = 0
    var bookId = ""
    var bookDate = ""
    
    
    var addUrlBlock:(()->())?  //声明闭包

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "上传视频"
        
        rightBarButton()
    }
    
    func rightBarButton() {
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "确认", style: .plain, target: self, action: #selector(submitAnswer(sender:)))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
    }
        
    
    //    MARK:提交
    @objc func submitAnswer(sender:UIBarButtonItem) {
        
        
        if isAnswer {
            addAlertTip()
        }else{
            let textfield1 = self.view.viewWithTag(100) as! UITextField
            let textfield2 = self.view.viewWithTag(101) as! UITextField
            let textfield3 = self.view.viewWithTag(102) as! UITextField
            
            let flag = UIApplication.shared.canOpenURL(StringToUTF_8InUrl(str: textfield3.text!))
            
            if !flag {
                setToast(str: "网址无效")
                return
            }
            
            if textfield1.text?.count == 0 {
                setToast(str: "请填写练习册章节")
                return
            }
            
            if textfield2.text?.count == 0 {
                setToast(str: "请填写知识点简介")
                return
            }
            
            if priceTextfield.text?.count == 0 {
                setToast(str: "请设置学币")
                return
            }
            
            self.view.beginLoading()
            var params1 = [String : Any]()
            
            if currentType == 1 {
                params1 =
                    ["SESSIONID":Defaults[userToken]!,
                     "mobileCode":mobileCode,
                     "bookId":bookId,
                     "counts":textfield1.text!,
                     "title":textfield2.text!,
                     "money":"1",
                     "date":bookDate,
                     "address":StringToUTF_8InUrl(str: textfield3.text!)
                    ] as [String : Any]
            }else{
                params1 =
                    ["SESSIONID":Defaults[userToken]!,
                     "mobileCode":mobileCode,
                     "bookId":bookId,
                     "counts":textfield1.text!,
                     "title":textfield2.text!,
                     "money":"1",
                     "address":StringToUTF_8InUrl(str: textfield3.text!)
                    ] as [String : Any]
            }
            NetWorkTeacherAddTWorkUploadUploadPoints(params: params1, callBack: { (flag) in
                if flag {
                    
                    setToast(str: "已提交")
                    if self.addUrlBlock != nil {
                        self.addUrlBlock!()
                    }
                    self.navigationController?.popViewController(animated: true)
                }
                self.view.endLoading()
            })

        }
        
    }
    
    
    var priceTextfield = UITextField()
    func addAlertTip() {
        
        let alert = UIAlertView.init(title: "设置支付学币", message: "单位：（学币）", delegate: self, cancelButtonTitle: "确定", otherButtonTitles: "取消")
        alert.alertViewStyle = .plainTextInput
        
        priceTextfield = alert.textField(at: 0)!
        priceTextfield.keyboardType = .numberPad
        
        let text = priceTextfield.text
        deBugPrint(item: text!)
        alert.show()
    }
    
    
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        let buttonTitle = alertView.buttonTitle(at: buttonIndex)
        if buttonTitle == "确定" {
            
            let textfield1 = self.view.viewWithTag(100) as! UITextField
            let textfield2 = self.view.viewWithTag(101) as! UITextField
            if !isAnswer {
                let textfield3 = self.view.viewWithTag(102) as! UITextField
                
                let flag = UIApplication.shared.canOpenURL(StringToUTF_8InUrl(str: textfield3.text!))
                
                if !flag {
                    setToast(str: "网址无效")
                    return
                }
                
                if textfield1.text?.count == 0 {
                    setToast(str: "请填写练习册章节")
                    return
                }
                
                if textfield2.text?.count == 0 {
                    setToast(str: "请填写知识点简介")
                    return
                }

                if priceTextfield.text?.count == 0 {
                    setToast(str: "请设置学币")
                    return
                }
                
                self.view.beginLoading()
                var params1 = [String : Any]()
                
                if currentType == 1 {
                    params1 =
                        ["SESSIONID":Defaults[userToken]!,
                         "mobileCode":mobileCode,
                         "bookId":bookId,
                         "counts":textfield1.text!,
                         "title":textfield2.text!,
                         "money":priceTextfield.text!,
                         "date":bookDate,
                         "address":StringToUTF_8InUrl(str: textfield3.text!)
                        ] as [String : Any]
                }else{
                    params1 =
                        ["SESSIONID":Defaults[userToken]!,
                         "mobileCode":mobileCode,
                         "bookId":bookId,
                         "counts":textfield1.text!,
                         "title":textfield2.text!,
                         "money":priceTextfield.text!,
                         "address":StringToUTF_8InUrl(str: textfield3.text!)
                        ] as [String : Any]
                }
                NetWorkTeacherAddTWorkUploadUploadPoints(params: params1, callBack: { (flag) in
                    if flag {
                        
                        setToast(str: "已提交")
                        if self.addUrlBlock != nil {
                            self.addUrlBlock!()
                        }
                        self.navigationController?.popViewController(animated: true)
                    }
                    self.view.endLoading()
                })
               
            }else{

                if !UIApplication.shared.canOpenURL(StringToUTF_8InUrl(str: textfield2.text!)) {
                    setToast(str: "网址无效")
                    return
                }
                
                if textfield1.text?.count == 0 {
                    setToast(str: "请填写视频描述")
                    return
                }
                self.view.beginLoading()
                
                if currentType == 4 {
                    let params =
                        ["SESSIONID":Defaults[userToken]!,
                         "mobileCode":mobileCode,
                         "periods_id":bookId,
                         "title":textfield1.text!,
                         "address":textfield2.text!,
                         "money":priceTextfield.text!
                        ] as [String : Any]
                    NetWorkTeacherUpLoadInClass(params: params, callBack: { (flag) in
                        if flag {
                            setToast(str: "已提交")
                            if self.addUrlBlock != nil {
                                self.addUrlBlock!()
                            }
                            self.navigationController?.popViewController(animated: true)
                        }
                    })
                    
                }else{
                    
                    var params1 = [String : Any]()

                    if currentType == 1 {
                        params1 =
                            ["SESSIONID":Defaults[userToken]!,
                             "mobileCode":mobileCode,
                             "bookId":bookId,
                             "title":textfield1.text!,
                             "answardRes":textfield2.text!,
                             "date":bookDate,
                             "money":priceTextfield.text!
                            ] as [String : Any]
                    }else{
                        params1 =
                            ["SESSIONID":Defaults[userToken]!,
                             "mobileCode":mobileCode,
                             "bookId":bookId,
                             "title":textfield1.text!,
                             "answardRes":textfield2.text!,
                             "money":priceTextfield.text!
                            ] as [String : Any]
                    }
                    
                    NetWorkTeacherGetTWorkUploadVideo(params: params1, callBack: { (flag) in
                        
                        if flag {
                            setToast(str: "已提交")
                            if self.addUrlBlock != nil {
                                self.addUrlBlock!()
                            }
                            self.navigationController?.popViewController(animated: true)
                        }
                        self.view.endLoading()
                    })
                }
            }
        }else{
            setToast(str: "取消了")
        }
    }
    
    
    override func configSubViews() {
        
        if isAnswer {
            titleArr = ["添加视频描述","添加视频链接"]
        }else{
            titleArr = ["练习册章节","知识点简介","添加视频链接"]
        }
        
        let kWidth = kSCREEN_WIDTH-28*kSCREEN_SCALE*2
        let labelHeight = CGFloat(35)
        let textfieldHeight = 88*kSCREEN_SCALE
        let kSpace = 28*kSCREEN_SCALE
        
        for index in 0..<titleArr.count {
            
            let label = UILabel.init(frame: CGRect(x: kSpace, y: kSpace+(labelHeight+textfieldHeight+kSpace)*CGFloat(index), width: kWidth, height: labelHeight))
            
            label.font = kFont32
            label.textColor = kGaryColor(num: 101)
            label.text = titleArr[index]
            self.view.addSubview(label)
            
            let textfield = UITextField.init(frame: CGRect(x: kSpace, y: kSpace+labelHeight+(labelHeight+textfieldHeight+kSpace)*CGFloat(index), width: kWidth, height: textfieldHeight))
            textfield.backgroundColor = UIColor.white
            textfield.layer.cornerRadius = 10*kSCREEN_SCALE
            textfield.clipsToBounds = true
            textfield.tag = index+100
            
            textfield.leftViewRect(forBounds: CGRect(x: 0, y: 0, width: 10, height: 45))
            textfield.leftViewMode = .always
            let leftBG1 = UIView.init(frame: CGRect(x: 0, y: 0, width: 10, height: 45))
            textfield.leftView = leftBG1
            
            if isAnswer {
                
                if index == 1 {
                    
                    textfield.placeholder = "http://"
                    textfield.keyboardType = .URL
                }
            }else{
                if index == 2 {
                    
                    textfield.placeholder = "http://"
                    textfield.keyboardType = .URL
                }
            }
            self.view.addSubview(textfield)
        }        
    }

}
