//
//  AnswerImageCell.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/10.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class AnswerImageCell: UITableViewCell {

    
    @IBOutlet weak var showImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        showImage.contentMode = .scaleAspectFit
    }

    
    func showWithImage(image:UIImage) {
        showImage.image = image
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
