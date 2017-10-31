//
//  PersonHeadCell.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/16.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class PersonHeadCell: UITableViewCell {

    
    @IBOutlet weak var headIcon: UIImageView!
    
    @IBOutlet weak var backImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        headIcon.layer.cornerRadius = 5
        headIcon.clipsToBounds = true
        
        backImage.image = getNavigationIMG(27, fromColor: kSetRGBColor(r: 0, g: 200, b: 255), toColor: kSetRGBColor(r: 0, g: 162, b: 255))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
