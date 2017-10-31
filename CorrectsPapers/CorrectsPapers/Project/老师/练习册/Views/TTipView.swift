//
//  TTipView.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/24.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class TTipView: UIView {
    
    
    @IBOutlet weak var videoDescrip: UITextField!
    
    @IBOutlet weak var videoUrl: UITextField!
    
    
    var chooseBlock:((Dictionary<String, String>)->())?  //声明闭包
    var closeBlock:(()->())?  //声明闭包

    override func awakeFromNib() {
        self.layer.cornerRadius = 10 * kSCREEN_SCALE
        self.clipsToBounds = true
    }
    
    
    @IBAction func chooseAction(_ sender: UIButton) {
        let dic = NSDictionary.init(objects: [videoDescrip.text!,videoUrl.text!], forKeys: ["descrip" as NSCopying,"url" as NSCopying])

        
//        let dic = NSDictionary.init(object: videoUrl.text!, forKey: videoDescrip.text! as NSCopying)
        
        
        if sender.tag == 102 {
            if chooseBlock != nil {
                chooseBlock!(dic as! Dictionary<String, String>)
            }

        }else{
            if closeBlock != nil {
                closeBlock!()
            }
        }
        
    }
    
    
}
