//
//  LNRechargeView.swift
//  CorrectsPapers
//
//  Created by RongXing on 2018/1/12.
//  Copyright © 2018年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class LNRechargeView: UIView{


    @IBOutlet weak var coinCount: UITextField!
    
    @IBOutlet weak var payCount: UILabel!
    
    @IBOutlet weak var certainBtn: UIButton!
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    
    @IBOutlet weak var tipLabel: UILabel!
    
    var rechargeAction:((Bool,String)->())?  //声明闭包

    
    override func awakeFromNib() {
        certainBtn.setBackgroundImage(getNavigationIMG(27, fromColor: kSetRGBColor(r: 0, g: 200, b: 255), toColor: kSetRGBColor(r: 0, g: 162, b: 255)), for: .normal)
        certainBtn.layer.cornerRadius = 10 * kSCREEN_SCALE
        certainBtn.clipsToBounds = true
        
        certainBtn.snp.updateConstraints { (ls) in
            ls.height.equalTo(78*kSCREEN_SCALE)
        }
        
        coinCount.addTarget(self, action: #selector(textDidChanged(textField:)), for: .editingChanged)

        if Defaults[userIdentity] == kTeacher {
            coinCount.keyboardType = .emailAddress
        }
    }
    
    
    @objc func textDidChanged(textField:UITextField) {
        
        if Float(textField.text!) == nil {
            return
        }
        
        if Float(textField.text!)! > 1000 {
            setToast(str: "单次最高可充值1,000学币")
            textField.text = "1000"
            payCount.text = "需支付 ¥ "+OCTools.init().positiveFormat("1000")+"元"
        }else{
            payCount.text = "需支付 ¥ "+OCTools.init().positiveFormat(textField.text)+"元"
        }
        
    }
    
    
    @IBAction func certainAction(_ sender: Any) {
        
        if coinCount.text == nil {
            setToast(str: "请输入数字")
            return
        }
        
        if Float(coinCount.text!)! < 1 {
            setToast(str: "最低充值1元")
            return
        }
        
        if rechargeAction != nil {
            rechargeAction!(true,coinCount.text!)
        }
    }
    
    
    @IBAction func cancelAction(_ sender: Any) {
        
        if rechargeAction != nil {
            rechargeAction!(false,"")
        }
    }
    
}
