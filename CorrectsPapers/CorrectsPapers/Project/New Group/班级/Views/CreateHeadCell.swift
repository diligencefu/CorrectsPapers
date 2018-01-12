//
//  CreateHeadCell.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/21.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class CreateHeadCell: UITableViewCell {

    
    @IBOutlet weak var classImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    func setImageForHeadView(headImage:UIImage) {
        classImage.image = headImage
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
