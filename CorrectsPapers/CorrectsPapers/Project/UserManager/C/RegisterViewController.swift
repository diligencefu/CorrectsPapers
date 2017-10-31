//
//  RegisterViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/10.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SnapKit
import SDAutoLayout
import SwiftyUserDefaults

class RegisterViewController: BaseViewController {
    @IBOutlet weak var phoneNum: UITextField!
    
    @IBOutlet weak var verifyCode: UITextField!
    
    @IBOutlet weak var passWord: UITextField!
    
    @IBOutlet weak var rePassWord: UITextField!
    
    @IBOutlet weak var nextBtn: UIButton!
    
    @IBOutlet weak var student: UIButton!
    @IBOutlet weak var teacher: UIButton!
    
    var selectInfo = false
    
//声明定时器
    var timer = Timer()

    var sendCode = UIButton()
    var timeNow = 59
    var cornerRadius = CGFloat(10)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configSubViews() {
        self.navigationItem.title = "注册"
        
        self.view.backgroundColor = UIColor.white
        
        nextBtn.layer.cornerRadius = 10*kSCREEN_SCALE
        nextBtn.clipsToBounds = true
        
//        MARK:用户名
        phoneNum.rightViewRect(forBounds: CGRect(x: 0, y: 0, width: 40, height: 45))
        //        密码 可见/不可见
        let clearBtn = UIButton.init(frame: CGRect(x: 0, y: 0, width: 40, height: 45))
        clearBtn.setImage(#imageLiteral(resourceName: "close"), for: .normal)
        clearBtn.addTarget(self, action: #selector(clearPhoneText(sender:)), for: .touchUpInside)
        clearBtn.tag = 10
        phoneNum.rightView = clearBtn
        
        //        MARK:验证码
        verifyCode.clipsToBounds = true
        verifyCode.rightViewRect(forBounds: CGRect(x: 0, y: 0, width: 135, height: 25))
        verifyCode.rightViewMode = .always

        //        MARK:密码
        passWord.rightViewRect(forBounds: CGRect(x: 0, y: 0, width: 40, height: 45))
        passWord.rightViewMode = .always
        passWord.isSecureTextEntry = true
        passWord.keyboardType = .namePhonePad
        
        //        MARK:重复密码
        rePassWord.clipsToBounds = true
        rePassWord.rightViewRect(forBounds: CGRect(x: 0, y: 0, width: 40, height: 45))
        rePassWord.rightViewMode = .always
        rePassWord.isSecureTextEntry = true
        rePassWord.keyboardType = .namePhonePad
        
        //        MARK:发送验证码按钮
        sendCode = UIButton.init(frame: CGRect(x: 0, y: 0, width: 160*kSCREEN_SCALE, height: 54*kSCREEN_SCALE))
        sendCode.setTitle("发送验证码", for: .normal)
        sendCode.titleLabel?.font = kFont26
        sendCode.setTitleColor(UIColor.white, for: .normal)
        sendCode.setBackgroundImage(getNavigationIMG(27, fromColor: kSetRGBColor(r: 0, g: 200, b: 255), toColor: kSetRGBColor(r: 0, g: 162, b: 255)), for: .normal)
        sendCode.backgroundColor = UIColor.gray
        sendCode.layer.cornerRadius = 10*kSCREEN_SCALE
        sendCode.clipsToBounds = true
        sendCode.addTarget(self, action: #selector(sendVertifiCode(sender:)), for: .touchUpInside)
        verifyCode.rightView = sendCode
        
        
        //        密码 可见/不可见
        let canViewBtn = UIButton.init(frame: CGRect(x: 0, y: 0, width: 40, height: 45))
        canViewBtn.setImage(#imageLiteral(resourceName: "invisible"), for: .normal)
        canViewBtn.setImage(#imageLiteral(resourceName: "visible"), for: .selected)
        canViewBtn.addTarget(self, action: #selector(VisibleOrInvisible(sender:)), for: .touchUpInside)
        canViewBtn.tag = 10
        passWord.rightView = canViewBtn
        
        
        //        重复密码 可见/不可见
        let canViewBtn1 = UIButton.init(frame: CGRect(x: 0, y: 0, width: 40, height: 45))
        canViewBtn1.setImage(#imageLiteral(resourceName: "invisible"), for: .normal)
        canViewBtn1.setImage(#imageLiteral(resourceName: "visible"), for: .selected)
        canViewBtn1.addTarget(self, action: #selector(VisibleOrInvisible(sender:)), for: .touchUpInside)
        canViewBtn1.tag = 11
        rePassWord.rightView = canViewBtn1
        
        //        MARK:下一步
        nextBtn.setBackgroundImage(getNavigationIMG(27, fromColor: kSetRGBColor(r: 0, g: 200, b: 255), toColor: kSetRGBColor(r: 0, g: 162, b: 255)), for: .normal)

    }

    
    @objc func clearPhoneText(sender:UIButton) {
        phoneNum.text = ""
    }
    
    
    @objc func sendVertifiCode(sender:UIButton) {
     
        netWorkForSendCode(phoneNumber: phoneNum.text!) { (code) in
            
        }
        
        invalidateTimer()
        timeNow = 60
        sender.isEnabled = false
        sendCode.setTitle("\(timeNow)s后重新发送", for: .normal)
        
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: TimeInterval(1), target: self, selector: #selector(self.changeBtnTitle), userInfo: nil, repeats: true)
            RunLoop.main.add(self.timer, forMode: .commonModes)

        }
    }
    
    
    @objc fileprivate func changeBtnTitle(){
        
        timeNow = timeNow-1
        
        if timeNow < 0 {
            sendCode.isEnabled = true
            sendCode.setTitle("发送验证码", for: .normal)
            invalidateTimer()

        }else{
            sendCode.setTitle("\(timeNow)s重新发送", for: .normal)
        }

    }
    
    //    定时器失效
    fileprivate func invalidateTimer() {
        timer.invalidate()
    }
    
    
    @objc func VisibleOrInvisible(sender:UIButton) {
        
        if sender.isSelected {
            sender.isSelected = false
        }else{
            sender.isSelected = true
        }
        
        if sender.tag == 10 {
            passWord.isSecureTextEntry = !sender.isSelected
            passWord.keyboardType = .namePhonePad

        }else{
            rePassWord.isSecureTextEntry = !sender.isSelected
            rePassWord.keyboardType = .namePhonePad
        }
        
    }
    
    
    @IBAction func chooseStudent(_ sender: UIButton) {
        sender.setImage(#imageLiteral(resourceName: "Selected_icon_default"), for: .normal)
        teacher.setImage(#imageLiteral(resourceName: "Unchecked_icon_default"), for: .normal)
        selectInfo = false
                
    }
    
    
    @IBAction func chooseTeacher(_ sender: UIButton) {
        sender.setImage(#imageLiteral(resourceName: "Selected_icon_default"), for: .normal)
        student.setImage(#imageLiteral(resourceName: "Unchecked_icon_default"), for: .normal)
        selectInfo = true

    }
    
    
    @IBAction func nextAction(_ sender: UIButton) {
        
//        if !validateTelNumber(num: phoneNum.text! as NSString) {
//            setToast(str: "请输入正确的账号")
//            return
//        }
//
//        if passWord.text?.characters.count == 0 {
//            setToast(str: "请输入密码")
//            return
//        }
        
        if passWord.text == rePassWord.text {
            let perfecVC = PerfectInfoViewController()
            perfecVC.isTeacher = selectInfo
            perfecVC.phoneNum = phoneNum.text!
            perfecVC.passWord = passWord.text!
            perfecVC.Thecode = verifyCode.text!
//            self.navigationController?.pushViewController(perfecVC, animated: true)
        }else{
            setToast(str: "两次密码输入不一致")
            return
        }
        
        let perfecVC = PerfectInfoViewController()
        perfecVC.isTeacher = selectInfo
        perfecVC.phoneNum = phoneNum.text!
        perfecVC.passWord = passWord.text!
        perfecVC.Thecode = verifyCode.text!
        self.navigationController?.pushViewController(perfecVC, animated: true)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        invalidateTimer()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
