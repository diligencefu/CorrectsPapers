//
//  SystemMsgViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/23.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class SystemMsgViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func configSubViews() {
        self.navigationItem.title = "系统消息"
        let aboutLabel = UITextView.init(frame: CGRect(x: 10, y: CGFloat(15), width: kSCREEN_WIDTH-20, height: kSCREEN_HEIGHT-30))
        aboutLabel.text = "吴某某老师退回了您的作业，原因是字迹不清晰，请重新上传。"
        aboutLabel.backgroundColor = UIColor.clear
        aboutLabel.textColor = kTextColor()
        aboutLabel.font = kFont30
        aboutLabel.isEditable = false
        self.view.addSubview(aboutLabel)

    }

}
