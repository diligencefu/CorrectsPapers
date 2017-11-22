//
//  TShowTheTipView.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/14.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class TShowTheTipView: UIView {

    var chooseBlock:((Bool)->())?  //声明闭包

    
    @IBAction func cancelAntion(_ sender: UIButton) {
        
        if chooseBlock != nil {
            chooseBlock!(true)
        }
    }
    
    
    @IBAction func certainAction(_ sender: UIButton) {
        
        if chooseBlock != nil {
            chooseBlock!(false)
        }
    }
    
}
