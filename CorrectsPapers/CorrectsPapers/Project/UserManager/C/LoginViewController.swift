//
//  LoginViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/10.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class LoginViewController: BaseViewController {

    var canBack = false
    
    let userName = UITextField()
    let passWord = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.title = "登录"
        self.view.backgroundColor = kBGColor()
        
        configSubViews()
    }

    override func leftBarButton() {
        
    }
    
    override func configSubViews() {
//        账号
        userName.frame = CGRect(x: 30, y: 30, width: kSCREEN_WIDTH - 30 * 2, height: 45)
        userName.borderStyle = .none
        userName.textColor = kGaryColor(num: 117)
        userName.font = kFont32
        userName.placeholder = "请输入手机号"
        userName.leftViewRect(forBounds: CGRect(x: 0, y: 0, width: 80, height: 45))
        userName.rightViewRect(forBounds: CGRect(x: 0, y: 0, width: 40, height: 45))
        userName.rightViewMode = .always
        userName.leftViewMode = .always
        userName.keyboardType = .numberPad
        
        userName.text = "13260646603"
        self.view.addSubview(userName)
        
        let leftBG1 = UIView.init(frame: CGRect(x: 0, y: 0, width: 35, height: 45))
        
        let image1 = UIImageView.init(frame: CGRect(x: 0, y: 0, width: 32*kSCREEN_SCALE, height: 32*kSCREEN_SCALE))
        image1.centerY = leftBG1.centerY
        image1.image = #imageLiteral(resourceName: "people")
        leftBG1.addSubview(image1)
        userName.leftView = leftBG1
        
        let line1 = UIView.init(frame: CGRect(x: 30, y: 75, width: kSCREEN_WIDTH - 60, height: 1))
        line1.backgroundColor = kGaryColor(num: 227)
        self.view.addSubview(line1)
        
        //       清除按钮
        let clearBtn = UIButton.init(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        clearBtn.setImage(#imageLiteral(resourceName: "close"), for: .normal)
        clearBtn.addTarget(self, action: #selector(clearUserNameText(sender:)), for: .touchUpInside)
        userName.rightView = clearBtn
        
//        密码
        passWord.frame = CGRect(x: 30, y: 90, width: kSCREEN_WIDTH - 30 * 2, height: 45)
        passWord.borderStyle = .none
        passWord.leftViewRect(forBounds: CGRect(x: 0, y: 0, width: 80, height: 45))
        passWord.leftViewMode = .always
        passWord.rightViewRect(forBounds: CGRect(x: 0, y: 0, width: 40, height: 45))
        passWord.rightViewMode = .always
        passWord.placeholder = "请输入密码"
        passWord.font = kFont32
        passWord.textColor = kGaryColor(num: 117)
        passWord.isSecureTextEntry = true
//        passWord.keyboardType = .namePhonePad
        passWord.text = "qwerty"
        self.view.addSubview(passWord)
        
        let leftBG2 = UIView.init(frame: CGRect(x: 0, y: 0, width: 35, height: 45))
        
        let image2 = UIImageView.init(frame: CGRect(x: 0, y: 0, width: 32*kSCREEN_SCALE, height: 32*kSCREEN_SCALE))
        image2.centerY = leftBG1.centerY
        image2.image = #imageLiteral(resourceName: "password")
        leftBG2.addSubview(image2)
        passWord.leftView = leftBG2

//        密码 可见/不可见
        let canViewBtn = UIButton.init(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        canViewBtn.setImage(#imageLiteral(resourceName: "invisible"), for: .normal)
        canViewBtn.setImage(#imageLiteral(resourceName: "visible"), for: .selected)
        canViewBtn.addTarget(self, action: #selector(VisibleOrInvisible(sender:)), for: .touchUpInside)
        passWord.rightView = canViewBtn
        
        let line2 = UIView.init(frame: CGRect(x: 30, y: 135, width: kSCREEN_WIDTH - 60, height: 1))
        line2.backgroundColor = kGaryColor(num: 227)
        self.view.addSubview(line2)
        
        let login = UIButton.init(frame: CGRect(x: 30, y: 170, width: kSCREEN_WIDTH - 30 * 2, height: 40))
        login.setBackgroundImage(getNavigationIMG(27, fromColor: kSetRGBColor(r: 0, g: 200, b: 255), toColor: kSetRGBColor(r: 0, g: 162, b: 255)), for: .normal)
        login.layer.cornerRadius = 10*kSCREEN_SCALE
        login.clipsToBounds = true
        login.setTitle("登录", for: .normal)
        passWord.isSecureTextEntry = true
        login.addTarget(self, action: #selector(loginAction(sender:)), for: .touchUpInside)
        self.view.addSubview(login)
        
        let regist = UIButton.init(frame: CGRect(x: 374/2 - 100, y: 300, width: 40, height: 35))
        regist.setTitle("注册账号", for: .normal)
        regist.setTitleColor(kGaryColor(num: 117), for: .normal)
        regist.addTarget(self, action: #selector(registAction(sender:)), for: .touchUpInside)
        self.view.addSubview(regist)
        
        let centerView = UIView.init(frame: CGRect(x: 374/2, y: 300, width: 1, height: 35))
        centerView.backgroundColor = kGaryColor(num: 117)
        self.view.addSubview(centerView)
        
        let lookPW = UIButton.init(frame: CGRect(x: 374/2 + 20, y: 300, width: 80, height: 35))
        lookPW.setTitle("找回密码", for: .normal)
        lookPW.setTitleColor(kGaryColor(num: 117), for: .normal)
        lookPW.addTarget(self, action: #selector(lookForPWAction(sender:)), for: .touchUpInside)
        self.view.addSubview(lookPW)        
        
        centerView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.height.equalTo(24*kSCREEN_SCALE)
            make.width.equalTo(1)
            make.bottom.equalToSuperview().offset(-72*kSCREEN_SCALE)
        }
        
        regist.snp.makeConstraints { (make) in
            make.centerY.equalTo(centerView)
            make.height.equalTo(30)
            make.width.equalTo(100)
            make.right.equalTo(centerView.snp.left)
        }
        
        lookPW.snp.makeConstraints { (make) in
            make.centerY.equalTo(centerView)
            make.height.equalTo(30)
            make.width.equalTo(100)
            make.left.equalTo(centerView.snp.right)
        }
    }
    
    
    @objc func clearUserNameText(sender:UIButton) {
        
        
        if userName.text == "13260646603" {
            userName.text = "13297079546"
            passWord.text = "123456"
        }
        
    }

    
    @objc func VisibleOrInvisible(sender:UIButton) {
        
        if sender.isSelected {
            sender.isSelected = false
        }else{
            sender.isSelected = true
        }
        passWord.isSecureTextEntry = !sender.isSelected
        passWord.keyboardType = .namePhonePad

    }
    
 
    @objc func loginAction(sender:UIButton) {
        
        self.view.endEditing(true)
        
//        if !validateTelNumber(num: userName.text! as NSString) {
//            setToast(str: "请输入正确的账号")
//            return
//        }
//        
//        if (passWord.text?.characters.count)! == 0 {
//            setToast(str: "请输入密码")
//            return
//        }
        let dic = ["phone":userName.text!,
                   "password":passWord.text!,
                   ] as [String : Any]

        netWorkForLogin(params: dic) { (flag) in
            
            if flag {
//                Defaults[username]  = self.userName.text
//                Defaults[userToken] = self.passWord.text
                self.view.window?.rootViewController = MainTabBarController()
            }
        }
        
    }
    
    @objc func registAction(sender:UIButton) {
        
        self.navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
    
    @objc func lookForPWAction(sender:UIButton) {
        
        self.navigationController?.pushViewController(LookPsWViewController(), animated: true)
//        self.navigationController?.pushViewController(MyShopViewController(), animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    
}
