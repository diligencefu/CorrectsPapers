//
//  WriteAnswerViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/10.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class WriteAnswerViewController: BaseViewController ,UITextFieldDelegate,UITextViewDelegate{

    var tipTextField = UITextField()
    var content = UITextView()
    
//    判断是哪里的答案
    var currentType = 0
    
    var addTextBlock:((String)->())?  //声明闭包

    var bookId = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        rightBarButton()
    }
    
    override func configSubViews() {
        
        self.navigationItem.title="书写答案"
        
        content = UITextView.init(frame: CGRect(x: 28 * kSCREEN_SCALE, y: 28 * kSCREEN_SCALE, width: kSCREEN_WIDTH - 56 * kSCREEN_SCALE, height: 563 * kSCREEN_SCALE))
        content.layer.cornerRadius = 10 * kSCREEN_SCALE
        content.font = kFont34
        content.layer.borderColor = kGaryColor(num: 216).cgColor
        content.delegate = self
        content.layer.borderWidth = 1
        self.view.addSubview(content)
        
        tipTextField = UITextField.init(frame: CGRect(x: 0, y: 8, width: kSCREEN_WIDTH, height: 21))
        tipTextField.placeholder = " submitAnswer"
        tipTextField.borderStyle = .none
        tipTextField.delegate = self
        content.addSubview(tipTextField)
        
    }
    
    
    func rightBarButton() {
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "确认", style: .plain, target: self, action: #selector(submitAnswer(sender:)))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        
    }
    
    
    //    MARK:提交
    @objc func submitAnswer(sender:UIBarButtonItem) {
//
//        if addTextBlock != nil {
//            addTextBlock!(content.text)
//        }
//
//        setToast(str: "已提交")
//        self.navigationController?.popViewController(animated: true)
        
        
        let params1 =
            ["SESSIONID":SESSIONIDT,
             "mobileCode":mobileCodeT,
             "bookId":bookId,
             "answardRes":content.text,
             "money":"2",
             ] as [String : Any]
        
        
        if currentType == 1 {
            
            NetWorkTeacherAddTWorkUploadContent(params: params1, callBack: { (flag) in
                if flag {
                    setToast(str: "已提交")
                    self.navigationController?.popViewController(animated: true)
                }
            })
        }else if currentType == 2 {
            
            
            
        }else if currentType == 3 {
            
            
            
        }

        
        
    }
    

    
    //    MARK:UITextViewDelegate
    func textViewDidChange(_ textView: UITextView) {
        
        if textView.text.count == 0 {
            tipTextField.isHidden = false
        }else{
            tipTextField.isHidden = true
        }
        
    }
    
    
    //    MARK:UITextFieldDelegate
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        tipTextField.isHidden = true
        content.becomeFirstResponder()
        return true
    }
    
}
