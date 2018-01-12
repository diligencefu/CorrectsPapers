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

class LNSetPswViewController: BaseViewController,HBAlertPasswordViewDelegate {

    
    @IBOutlet weak var idCardStr: UITextField!
    
    
    var isFrist = true
    
    var passwordStr = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rightBarButton()
        // Do any additional setup after loading the view.
    }

    
     func rightBarButton() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "下一步", style: .plain, target: self, action: #selector(pushToSetting(sender:)))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        
    }
    
    @objc func pushToSetting(sender:UIBarButtonItem) {
        let passwd = HBAlertPasswordView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 400))
        passwd.delegate = self
        passwd.titleLabel.text = "请输入密码"
        self.view.addSubview(passwd)
    }

    //    HBAlertPasswordViewDelegate 密码弹框代理
    func sureAction(with alertPasswordView: HBAlertPasswordView!, password: String!) {
        alertPasswordView.removeFromSuperview()
        
        self.view.endEditing(true)
        if isFrist {
            
            passwordStr = password
            
            let passwd = HBAlertPasswordView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 400))
            passwd.delegate = self
            passwd.titleLabel.text = "请再次输入密码"
            isFrist = false
            self.view.addSubview(passwd)
        }else{
            
            if password == passwordStr {
                
                let params =
                    [
                        "SESSIONID":SESSIONID,
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
                                                self.navigationController?.popViewController(animated: true)
                                            }else{
                                                
                                            }
                                        }
                                        break
                                    case .failure(let error):
                                        deBugPrint(item: error)
                                    }
                }
                
            }else{
                setToast(str: "两次输入密码不一致")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
