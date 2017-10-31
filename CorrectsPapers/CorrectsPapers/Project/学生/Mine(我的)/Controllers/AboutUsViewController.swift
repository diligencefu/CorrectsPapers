//
//  AboutUsViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/16.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class AboutUsViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func configSubViews() {
//        setupTitleViewSectionStyle(titleStr: "关于我们")
        self.navigationItem.title = "关于我们"
        let aboutLabel = UITextView.init(frame: CGRect(x: 10, y: CGFloat(15), width: kSCREEN_WIDTH-20, height: kSCREEN_HEIGHT-30))
        aboutLabel.text = "医生服务着力于打造“线上+线下”的全流程就医服务，通过线上咨询+线下就医的方式为会员提供持续的健康管理，包括专属家庭医生，三甲专家预约、完善健康档案等服务，整体形成了“线上家庭医生+线下专科医生”的医疗服务资源布局。"
        aboutLabel.backgroundColor = UIColor.clear
        aboutLabel.textColor = kTextColor()
        aboutLabel.font = kFont30
        aboutLabel.isEditable = false
        self.view.addSubview(aboutLabel)
        
    }
    
}
