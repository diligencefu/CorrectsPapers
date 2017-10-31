//
//  ApplyCell.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/17.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class ApplyCell: UITableViewCell {

    @IBOutlet weak var userIcon: UIImageView!
    
    @IBOutlet weak var userInfo: UILabel!
    
    @IBOutlet weak var userLabel: UILabel!
    
    @IBOutlet weak var refuse: UIButton!
    @IBOutlet weak var agree: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        refuse.layer.cornerRadius = 10*kSCREEN_SCALE
        refuse.clipsToBounds = true
        refuse.layer.borderColor = kSetRGBColor(r: 255, g: 55, b: 55).cgColor
        refuse.layer.borderWidth = 1
        
        
        agree.layer.cornerRadius = 10*kSCREEN_SCALE
        agree.clipsToBounds = true
        agree.setBackgroundImage(getNavigationIMG(27, fromColor: kSetRGBColor(r: 0, g: 200, b: 255), toColor: kSetRGBColor(r: 0, g: 162, b: 255)), for: .normal)
    }
    
    
    
    @IBAction func certainAction(_ sender: UIButton) {
        
    }
    
    @IBAction func refuseAction(_ sender: UIButton) {
        
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
