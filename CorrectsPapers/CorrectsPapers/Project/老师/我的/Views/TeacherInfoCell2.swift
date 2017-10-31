//
//  TeacherInfoCell2.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/26.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class TeacherInfoCell2: UITableViewCell {

    
    @IBOutlet weak var infoTitle: UILabel!
    
    
    @IBOutlet weak var infoContent: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    func TeacherInfoCell2ForNormal(title:String,content:String) {
        
        infoTitle.text = title
        infoContent.text = content
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
