//
//  showGradeCell.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/17.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class showGradeCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var gradeLabel: UILabel!
    
    @IBOutlet weak var gradeImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        //日期样式
        
        
    }

    func showGrade(isTitle:Bool) {
        if isTitle {
            gradeImage.isHidden = true
            gradeLabel.isHidden = false

        }else{
            gradeImage.isHidden = false
            gradeLabel.isHidden = true
            let date = NSDate()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
            timeLabel.text = formatter.string(from: date as Date)
            gradeImage.image = #imageLiteral(resourceName: "sixing_icon_pressed")
        }
    }
    
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
