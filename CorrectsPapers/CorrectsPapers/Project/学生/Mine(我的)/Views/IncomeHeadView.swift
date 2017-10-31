//
//  IncomeHeadView.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/17.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class IncomeHeadView: UIView {


    @IBOutlet weak var incomeCount: UILabel!
    
    @IBOutlet weak var incomeType: UILabel!
    
    @IBOutlet weak var topUp: UIButton!
    
    @IBOutlet weak var descrip: UILabel!
    
    @IBOutlet weak var backImage: UIImageView!
    
    
    override func awakeFromNib() {
        backImage.image = getNavigationIMG(27, fromColor: kSetRGBColor(r: 0, g: 200, b: 255), toColor: kSetRGBColor(r: 0, g: 162, b: 255))
        
        topUp.setBackgroundImage( getNavigationIMG(27, fromColor: kSetRGBColor(r: 255, g: 219, b: 21), toColor: kSetRGBColor(r: 255, g: 168, b: 0)), for: .normal)
        topUp.layer.cornerRadius = 11 * kSCREEN_SCALE
        topUp.clipsToBounds = true
    }
    
}
