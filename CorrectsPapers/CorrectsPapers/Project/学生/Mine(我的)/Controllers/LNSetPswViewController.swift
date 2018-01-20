//
//  LNSetPswViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2018/1/6.
//  Copyright © 2018年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import SwiftyUserDefaults

class LNSetPswViewController: BaseViewController,HBAlertPasswordViewDelegate {

    @IBOutlet weak var idCardStr: UITextField!
    
    var isFrist = true
    
    var passwordStr = ""
    
    var isChange = false
    
    var idCard_id = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rightBarButton()
        // Do any additional setup after loading the view.
    }

    
    override func configSubViews() {
        if Defaults[HavePayPassword] != "yes"{
            self.navigationItem.title = "创建支付密码"
        }else{
            self.navigationItem.title = "修改支付密码"
        }
    }
    
    func rightBarButton() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "下一步", style: .plain, target: self, action: #selector(pushToSetting(sender:)))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
    }
    
    
    @objc func pushToSetting(sender:UIBarButtonItem) {
        
        if !OCTools.checkIdentityCardNo(idCardStr.text!){
            setToast(str: "请输入正确的身份证号码！")
            return
        }
        
        if isChange {
            let params =
                [
                    "SESSIONID":Defaults[userToken]!,
                    "mobileCode":mobileCode,
                    "num":idCardStr.text!,
                    ] as [String : Any]
            Alamofire.request(kCheck_Number,
                              method: .post, parameters: params,
                              encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                                deBugPrint(item: response.result)
                                switch response.result {
                                case .success:
                                    if let j = response.result.value {
                                        //SwiftyJSON解析数据
                                        let JSOnDictory = JSON(j)
                                        let code =  JSOnDictory["code"].stringValue
                                        let Message =  JSOnDictory["message"].stringValue
                                        let id =  JSOnDictory["data"]["id"].stringValue
                                        if code == "1" {
                                            self.idCard_id = id
                                            
                                            let passwd = HBAlertPasswordView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: kSCREEN_HEIGHT))
                                            passwd.delegate = self
                                            passwd.titleLabel.text = "请输入新密码"
                                            self.view.addSubview(passwd)

                                            
                                        }else{
                                            setToast(str: Message)
                                        }
                                    }
                                    break
                                case .failure(let error):
                                    deBugPrint(item: error)
                                }
            }
        }else{
            
            
            let passwd = HBAlertPasswordView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: kSCREEN_HEIGHT))
            passwd.delegate = self
            passwd.titleLabel.text = "请输入密码"
            self.view.addSubview(passwd)
        }
        
    }

    
    //    HBAlertPasswordViewDelegate 密码弹框代理
    func cancelAction() {
        isFrist = true
    }
    
    
    func sureAction(with alertPasswordView: HBAlertPasswordView!, password: String!) {
        alertPasswordView.removeFromSuperview()
        
        self.view.endEditing(true)
        if isFrist {
            
            passwordStr = password
            
            let passwd = HBAlertPasswordView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: kSCREEN_HEIGHT))
            passwd.delegate = self
            passwd.titleLabel.text = "请再次输入密码"
            isFrist = false
            self.view.addSubview(passwd)
        }else{
            
            if password == passwordStr {
                
                if isChange {
                    let params =
                        [
                            "SESSIONID":Defaults[userToken]!,
                            "mobileCode":mobileCode,
                            "PasswordFrist":passwordStr,
                            "PasswordSecond":password,
                            "id":idCard_id,
                            ] as [String : Any]
                    Alamofire.request(kNew_Password,
                                      method: .post, parameters: params,
                                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                                        deBugPrint(item: response.result)
                                        switch response.result {
                                        case .success:
                                            if let j = response.result.value {
                                                //SwiftyJSON解析数据
                                                let JSOnDictory = JSON(j)
                                                let code =  JSOnDictory["code"].stringValue
                                                let Message =  JSOnDictory["message"].stringValue
                                                setToast(str: Message)

                                                if code == "1" {
                                                    Defaults[HavePayPassword] = "yes"
                                                    self.navigationController?.popToViewController((self.navigationController?.viewControllers[1])!, animated: true)
                                                }else{
                                                }
                                            }
                                            break
                                        case .failure(let error):
                                            deBugPrint(item: error)
                                        }
                    }

                }else{
                    let params =
                        [
                            "SESSIONID":Defaults[userToken]!,
                            "mobileCode":mobileCode,
                            "PasswordFrist":passwordStr,
                            "PasswordSecond":password,
                            "number":idCardStr.text!,
                            ] as [String : Any]
                    Alamofire.request(kcreat_Password,
                                      method: .post, parameters: params,
                                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                                        deBugPrint(item: response.result)
                                        switch response.result {
                                        case .success:
                                            if let j = response.result.value {
                                                //SwiftyJSON解析数据
                                                let JSOnDictory = JSON(j)
                                                let code =  JSOnDictory["code"].stringValue
                                                if code == "1" {
                                                    Defaults[HavePayPassword] = "yes"
                                                    
                                                    self.navigationController?.popToViewController((self.navigationController?.viewControllers[1])!, animated: true)
                                                }else{
                                                    setToast(str: "创建失败")
                                                }
                                            }
                                            break
                                        case .failure(let error):
                                            deBugPrint(item: error)
                                        }
                    }
                }
            }else{
                setToast(str: "两次输入密码不一致")
            }
        }
    }
    
    
}
