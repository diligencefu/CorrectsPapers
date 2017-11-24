//
//  ShareView.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/24.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

enum ShareType: NSInteger{
    case ShareTypeQQ
    case ShareTypeWechat
    case ShareTypeQQZone
    case ShareTypeCancel
}

class ShareView: UIView {

    var chooseShareTypeAction:((ShareType)->())?  //声明闭包

    
    @IBAction func WeChatAction(_ sender: UIButton) {
        
        if chooseShareTypeAction != nil {
            chooseShareTypeAction!(.ShareTypeWechat)
        }
        
    }
    
    
    @IBAction func QQFriendsAction(_ sender: UIButton) {
        
        if chooseShareTypeAction != nil {
            chooseShareTypeAction!(.ShareTypeQQ)
        }
    }
    
    @IBAction func QQZoneAction(_ sender: UIButton) {
        if chooseShareTypeAction != nil {
            chooseShareTypeAction!(.ShareTypeQQZone)
        }
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        if chooseShareTypeAction != nil {
            chooseShareTypeAction!(.ShareTypeCancel)
        }
    }
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
