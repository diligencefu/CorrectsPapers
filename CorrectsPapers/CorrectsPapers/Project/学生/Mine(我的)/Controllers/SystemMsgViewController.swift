//
//  SystemMsgViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/23.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class SystemMsgViewController: BaseViewController {

    var model = SMessageModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func configSubViews() {
        self.navigationItem.title = "系统消息"
        let aboutLabel = UITextView.init(frame: CGRect(x: 10, y: CGFloat(15), width: kSCREEN_WIDTH-20, height: 200))
        aboutLabel.backgroundColor = kGaryColor(num: 230)
        aboutLabel.textColor = kTextColor()
        aboutLabel.font = kFont30
        aboutLabel.isEditable = false
        
        aboutLabel.layer.cornerRadius = 5
        aboutLabel.clipsToBounds = true
        
        aboutLabel.font = kFont34
        
        self.view.addSubview(aboutLabel)
        
        
        if Defaults[userIdentity] == kTeacher {

            let params =
                [
                    "SESSIONID":Defaults[userToken]!,
                    "mobileCode":mobileCode,
                    "msgId":model.msgId,
                    "type":model.type
                    ] as [String : Any]
            NetWorkTeachersGetMsgDetailsTeacher(params: params) { (flag,str) in
                if flag {
                    let height =  kGetSizeOnString(str, Int(34*kSCREEN_SCALE)).height+15
                    
//                    if height > 200 {
//                        aboutLabel.height = height
//                    }else{
                        aboutLabel.height = height
//                    }
                    aboutLabel.text = str
                }
            }
        }else{
            
            let params =
                [
                    "SESSIONID":Defaults[userToken]!,
                    "mobileCode":mobileCode,
                    "msgId":model.msgId,
                    ] as [String : Any]
            NetWorkTeachersGetMsgDetailsStudent(params: params) { (flag,str) in
                if flag {
                    let height =  kGetSizeOnString(str, Int(38*kSCREEN_SCALE)).height+15
                    
//                    if height > 200 {
                        aboutLabel.height = height
//                    }else{
//                        aboutLabel.height = 200
//                    }
                    aboutLabel.text = str
                }
            }
        }
    }
}
