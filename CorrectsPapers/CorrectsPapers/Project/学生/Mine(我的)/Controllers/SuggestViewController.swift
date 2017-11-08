//
//  Suggest ViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/16.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class SuggestViewController: BaseViewController ,UITextFieldDelegate,UITextViewDelegate{
    
    var tipTextField = UITextField()
    var content = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rightBarButton()
    }
    
    override func configSubViews() {
        
        self.navigationItem.title="意见和建议"
        
        content = UITextView.init(frame: CGRect(x: 28 * kSCREEN_SCALE, y: 28 * kSCREEN_SCALE, width: kSCREEN_WIDTH - 56 * kSCREEN_SCALE, height: 563 * kSCREEN_SCALE))
        content.layer.cornerRadius = 10 * kSCREEN_SCALE
        content.font = kFont34
        content.layer.borderColor = kGaryColor(num: 216).cgColor
        content.delegate = self
        content.layer.borderWidth = 1
        self.view.addSubview(content)
        
        tipTextField = UITextField.init(frame: CGRect(x: 0, y: 8, width: kSCREEN_WIDTH, height: 21))
        tipTextField.placeholder = " 写出你觉得需要改善的地方"
        tipTextField.borderStyle = .none
        tipTextField.delegate = self
        content.addSubview(tipTextField)
        
    }
    
    
    func rightBarButton() {
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "提交", style: .plain, target: self, action: #selector(submitSuggest(sender:)))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        
    }
    
    
    //    MARK:提交
    @objc func submitSuggest(sender:UIBarButtonItem) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            setToast(str: "已提交")
            
            
            let params = ["SESSIONID":"1",
                          "mobileCode":"on",
                          "substance":self.content.text
                ] as [String : Any]
            
            
            netWorkForSuggestion(params: params, callBack: { (photo) in
                
                
            })
            
            //            self.navigationController?.popViewController(animated: true)
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

