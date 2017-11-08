//
//  ClassGradeCell.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/6.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class ClassGradeCell: UITableViewCell {

    
    @IBOutlet weak var periodsLabel: UILabel!
    
    @IBOutlet weak var fristGrade: UIImageView!
    @IBOutlet weak var doneGrade: UIImageView!
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func is1thCell() {
        fristGrade.alpha = 0
        doneGrade.alpha = 0
        periodsLabel.text = "课时"
    }
    
    func  setValueForClassGradeCell(index:NSInteger) {
        
        label1.isHidden = true
        label2.isHidden = true
        
        periodsLabel.text = "\(index)课时"
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
