//
//  LNChangePassWordVC.swift
//  CorrectsPapers
//
//  Created by RongXing on 2018/1/16.
//  Copyright © 2018年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import SwiftyUserDefaults

class LNChangePassWordVC: BaseViewController ,HBAlertPasswordViewDelegate{
    
    var isFrist = true
    var isOld   = true

    var passwordStr = ""
    
    var password_id = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    override func addHeaderRefresh() {
        
    }
    
    
    override func configSubViews() {
        
        self.navigationItem.title = "更改密码"
        
        let passwd = HBAlertPasswordView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 400))
        passwd.delegate = self
        passwd.titleLabel.text = "请输入密码"
        self.view.addSubview(passwd)
    }
    
    
    //    HBAlertPasswordViewDelegate 密码弹框代理
    func cancelAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func sureAction(with alertPasswordView: HBAlertPasswordView!, password: String!) {
        alertPasswordView.removeFromSuperview()
        
        self.view.endEditing(true)
        
        if isOld {
            let params =
                [
                    "SESSIONID":Defaults[userToken]!,
                    "mobileCode":mobileCode,
                    "PasswordAgo":password,
                    ] as [String : Any]
            Alamofire.request(kCheck_Password,
                              method: .post, parameters: params,
                              encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                                deBugPrint(item: response.result)
                                switch response.result {
                                case .success:
                                    if let j = response.result.value {
                                        //SwiftyJSON解析数据
                                        let JSOnDictory = JSON(j)
                                        let code =  JSOnDictory["code"].stringValue
                                        let paswid =  JSOnDictory["data"]["id"].stringValue
                                        if code == "1" {
                                            self.password_id = paswid
                                            self.isOld = false
                                            
                                            let passwd = HBAlertPasswordView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 400))
                                            passwd.delegate = self
                                            passwd.titleLabel.text = "请输入新密码"
                                            self.view.addSubview(passwd)
                                        }else{
                                            
                                            setToast(str: JSOnDictory["message"].stringValue)

                                            self.isOld = true
                                            let passwd = HBAlertPasswordView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 400))
                                            passwd.delegate = self
                                            passwd.titleLabel.text = "请输入旧密码"
                                            self.view.addSubview(passwd)
                                        }
                                    }
                                    break
                                case .failure(let error):
                                    deBugPrint(item: error)
                                }
            }
        }else{
            
            if isFrist {
                self.passwordStr = password
                isFrist = false
                
                let passwd = HBAlertPasswordView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 400))
                passwd.delegate = self
                passwd.titleLabel.text = "请再次输入新密码"
                self.view.addSubview(passwd)

            }else{
                if password == self.passwordStr {
                    
                    let params1 =
                        [
                            "SESSIONID":Defaults[userToken]!,
                            "mobileCode":Defaults[mCode]!,
                            "id":self.password_id,
                            "PasswordNew":password,
                            ] as [String : Any]
                    Alamofire.request(kCorrectPassword,
                                      method: .post, parameters: params1,
                                      encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                                        deBugPrint(item: response.result)
                                        switch response.result {
                                        case .success:
                                            if let j = response.result.value {
                                                //SwiftyJSON解析数据
                                                let JSOnDictory1 = JSON(j)
                                                let code =  JSOnDictory1["code"].stringValue
                                                setToast(str: JSOnDictory1["message"].stringValue)
                                                
                                                if code == "1" {
                                                    Defaults[HavePayPassword] = "yes"
                                                    self.navigationController?.popToViewController((self.navigationController?.viewControllers[1])!, animated: true)
                                                }
                                            }
                                            break
                                        case .failure(let error):
                                            deBugPrint(item: error)
                                        }
                    }
                }else{
                    setToast(str: "两次输入密码不一致")
                    isFrist = true
                    let passwd = HBAlertPasswordView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 400))
                    passwd.delegate = self
                    passwd.titleLabel.text = "请输入新密码"
                    self.view.addSubview(passwd)
                }
            }
        }
    }
}
