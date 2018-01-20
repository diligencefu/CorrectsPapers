//
//  LNBuildPeriodViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2018/1/10.
//  Copyright © 2018年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class LNBuildPeriodViewController: BaseViewController {

    var label = UILabel()
    var textfield = UITextField()

    var label1 = UILabel()
    var textfield1 = UITextField()
    
    
    var period_id = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        rightBarButton()
        
    }

    
    override func configSubViews() {
        
        self.navigationItem.title = "新建课时"
        
        let kWidth = kSCREEN_WIDTH-28*kSCREEN_SCALE*2
        let labelHeight = CGFloat(35)
        let textfieldHeight = 88*kSCREEN_SCALE
        let kSpace = 28*kSCREEN_SCALE
        
        
        label = UILabel.init(frame: CGRect(x: kSpace, y: kSpace, width: kWidth, height: labelHeight))
        
        label.font = kFont32
        label.textColor = kGaryColor(num: 101)
        label.text = "设置课时名称"
        self.view.addSubview(label)
        
        textfield = UITextField.init(frame: CGRect(x: kSpace, y: kSpace+labelHeight, width: kWidth, height: textfieldHeight))
        textfield.backgroundColor = UIColor.white
        textfield.layer.cornerRadius = 10*kSCREEN_SCALE
        textfield.clipsToBounds = true
        
        textfield.leftViewRect(forBounds: CGRect(x: 0, y: 0, width: 10, height: 45))
        textfield.leftViewMode = .always
        
        let leftBG1 = UIView.init(frame: CGRect(x: 0, y: 0, width: 10, height: 45))
        textfield.leftView = leftBG1
        self.view.addSubview(textfield)
        
        
        label1 = UILabel.init(frame: CGRect(x: kSpace, y: kSpace*2+labelHeight+textfieldHeight, width: kWidth, height: labelHeight))
        
        label1.font = kFont32
        label1.textColor = kGaryColor(num: 101)
        label1.text = "设置作业金额"
        self.view.addSubview(label1)
        
        textfield1 = UITextField.init(frame: CGRect(x: kSpace, y: kSpace*3+labelHeight*2+textfieldHeight, width: kWidth, height: textfieldHeight))
        textfield1.backgroundColor = UIColor.white
        textfield1.layer.cornerRadius = 10*kSCREEN_SCALE
        textfield1.clipsToBounds = true
        
        textfield1.leftViewRect(forBounds: CGRect(x: 0, y: 0, width: 10, height: 45))
        textfield1.leftViewMode = .always
        
        let leftBG11 = UIView.init(frame: CGRect(x: 0, y: 0, width: 10, height: 45))
        textfield1.leftView = leftBG11
        self.view.addSubview(textfield1)
    }
    
    func rightBarButton() {
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "确认", style: .plain, target: self, action: #selector(submitAnswer(sender:)))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
    }
    
    
    //    MARK:提交
    @objc func submitAnswer(sender:UIBarButtonItem) {
        
        if textfield.text?.count == 0 {
            setToast(str: "请课填写时名称")
            return
        }
        
        if textfield1.text?.count == 0 {
            setToast(str: "请设置学币")
            return
        }
        
        if Int(textfield1.text!) == nil {
            setToast(str: "请输入有效数字学币")
            return
        }

        let params =
            ["SESSIONID":Defaults[userToken]!,
             "mobileCode":mobileCode,
             "periods_id":period_id,
             "name":textfield.text!,
             "scores_one":textfield1.text!,
             ] as [String : Any]
        NetWorkTeacherTeacherBulidperiods(params: params) { (flag) in
            if flag {
                //        通知中心
                NotificationCenter.default.post(name: Notification.Name(rawValue: SuccessCorrectClassBuildPeriodNoti), object: self, userInfo: ["refresh":"begin"])

                self.navigationController?.popViewController(animated: true)
            }
        }
    }

}
