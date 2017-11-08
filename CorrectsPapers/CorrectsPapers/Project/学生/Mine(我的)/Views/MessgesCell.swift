//
//  MessgesCell.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/17.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class MessgesCell: UITableViewCell {

    @IBOutlet weak var messageImage: UIImageView!
    
    @IBOutlet weak var messageTitle: UILabel!
    
    @IBOutlet weak var messageContent: UILabel!
    
    @IBOutlet weak var isUnread: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        isUnread.layer.cornerRadius = 2.5
        isUnread.clipsToBounds = true
        
        messageImage.layer.cornerRadius = 5
        messageImage.clipsToBounds = true
    }
    
    
    func setValueMessgesCell(model:MessageModel) {
        
        messageContent.text = model.reason
        
        if model.isNewRecord == "0" {
            isUnread.isHidden = false
        }else{
            isUnread.isHidden = true
        }
        
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
