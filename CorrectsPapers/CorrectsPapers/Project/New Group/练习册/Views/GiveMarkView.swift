//
//  GiveMarkView.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/14.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class GiveMarkView: UIView,UITextFieldDelegate,UITextViewDelegate {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var certainBtn: UIButton!
    
    @IBOutlet weak var image1: UIButton!
    @IBOutlet weak var image2: UIButton!
    @IBOutlet weak var image3: UIButton!
    @IBOutlet weak var image4: UIButton!
    @IBOutlet weak var image5: UIButton!
    
    @IBOutlet weak var remark: UITextView!
    var score = ""
    
    
    
     var textfield = UITextField()
    
    var selectBlock:((_ content:String,_ isCancel:Bool,_ score:String)->())?  //声明闭包

    override func awakeFromNib() {
        remark.delegate = self
        remark.clipsToBounds = true
        remark.layer.cornerRadius = 8*kSCREEN_SCALE
        remark.layer.borderColor = kGaryColor(num: 179).cgColor
        remark.layer.borderWidth = 0.6
        remark.font = kFont34

        textfield = UITextField.init(frame: CGRect(x: 0, y: 8, width: kSCREEN_WIDTH, height: 21))
        textfield.placeholder = "请输入评价..."
        textfield.borderStyle = .none
        textfield.delegate = self
        remark.addSubview(textfield)
    }
    
//    
//    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
//        
//        kHiddenTextView = 11111
//        return true
//    }
//    
//    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
//        
//        kHiddenTextView = 16515
//        return true
//    }
//    
    
    
    //    MARK:UITextViewDelegate
    func textViewDidChange(_ textView: UITextView) {
        
        if textView.text.count == 0 {
            textfield.isHidden = false
        }else{
            textfield.isHidden = true
        }
        
    }
    
    
    //    MARK:UITextFieldDelegate
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        textfield.isHidden = true
        remark.becomeFirstResponder()
        return true
    }
    
    
//    取消
    @IBAction func cancelActionClick(_ sender: UIButton) {
        
        if selectBlock != nil {
            selectBlock!("",false,"")
        }
    }
    
    
//    确定
    @IBAction func certainActionClick(_ sender: UIButton) {
        
        if selectBlock != nil {
            selectBlock!(remark.text,true,score)
        }
    }
    
    
    @IBAction func yixingAction(_ sender: UIButton) {
        image2.isSelected = false
        image3.isSelected = false
        image4.isSelected = false
        image5.isSelected = false
        score = "1"
    }
    
    
    @IBAction func erxingAction(_ sender: UIButton) {
        image2.isSelected = true
        image3.isSelected = false
        image4.isSelected = false
        image5.isSelected = false
        score = "2"
    }
    
    
    @IBAction func sanxingAction(_ sender: UIButton) {
        image2.isSelected = true
        image3.isSelected = true
        image4.isSelected = false
        image5.isSelected = false
        score = "3"
    }
    
    @IBAction func sixingAction(_ sender: UIButton) {
        
        image2.isSelected = true
        image3.isSelected = true
        image4.isSelected = true
        image5.isSelected = false
        score = "4"
    }
    
    @IBAction func wuxingAction(_ sender: UIButton) {
        image2.isSelected = true
        image3.isSelected = true
        image4.isSelected = true
        image5.isSelected = true
        score = "5"
    }    
    
}
