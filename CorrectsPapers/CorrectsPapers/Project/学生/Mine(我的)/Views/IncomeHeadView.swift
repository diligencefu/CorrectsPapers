//
//  IncomeHeadView.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/17.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class IncomeHeadView: UIView {


    @IBOutlet weak var incomeCount: UILabel!
    
    @IBOutlet weak var incomeType: UILabel!
    
    @IBOutlet weak var topUp: UIButton!
    
    @IBOutlet weak var descrip: UILabel!
    
    @IBOutlet weak var backImage: UIImageView!
    
    var chooseImagesAction:(()->())?  //声明闭包

    override func awakeFromNib() {
        backImage.image = getNavigationIMG(27, fromColor: kSetRGBColor(r: 0, g: 200, b: 255), toColor: kSetRGBColor(r: 0, g: 162, b: 255))
        
        topUp.setBackgroundImage( getNavigationIMG(27, fromColor: kSetRGBColor(r: 255, g: 219, b: 21), toColor: kSetRGBColor(r: 255, g: 168, b: 0)), for: .normal)
        topUp.layer.cornerRadius = 11 * kSCREEN_SCALE
        topUp.clipsToBounds = true
        
        incomeCount.text = OCTools.init().positiveFormat("2000")
        
        
        if Defaults[userIdentity] == kTeacher {
            topUp.setTitle("学币提现", for: .normal)
        }else{
            topUp.setTitle("充值学币", for: .normal)
        }
        
    }
    
    
    func setAccount(num:String) {
        incomeCount.text = OCTools.init().positiveFormat(num)
    }
    
    
    @IBAction func rechargeAction(_ sender: UIButton) {
        
        if chooseImagesAction != nil {
            chooseImagesAction!()
        }
        
    }
    
    
}
