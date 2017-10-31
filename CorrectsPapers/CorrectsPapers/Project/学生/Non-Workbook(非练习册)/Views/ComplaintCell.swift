//
//  ComplaintCell.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/14.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class ComplaintCell: UITableViewCell {

    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var selectMark: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        selectMark.layer.cornerRadius = 12
        selectMark.clipsToBounds = true
        selectMark.layer.borderColor = kGaryColor(num: 221).cgColor
        selectMark.layer.borderWidth = 1
        
    }
    
    
    func complaintValues(flag:Bool,title1:String) {
        title.text = title1
        if flag {
            selectMark.image = #imageLiteral(resourceName: "photo_sel_photoPicker")
        }else{
            selectMark.image = nil
        }
        
    }
    
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
