//
//  TClassInfoCell.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/20.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class TClassInfoCell: UITableViewCell {

    @IBOutlet weak var classIcon: UIImageView!
    
    @IBOutlet weak var className: UILabel!
    @IBOutlet weak var mainTeacher: UILabel!
    @IBOutlet weak var tutorials: UILabel!
    @IBOutlet weak var submitType: UILabel!
    
    @IBOutlet weak var finishDate: UILabel!
    @IBOutlet weak var suvmitCount: UILabel!
    @IBOutlet weak var memCount: UILabel!
    
    @IBOutlet weak var classNum: UILabel!
    
    
    @IBOutlet weak var editBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        editBtn.setBackgroundImage(getNavigationIMG(27, fromColor: kSetRGBColor(r: 0, g: 200, b: 255), toColor: kSetRGBColor(r: 0, g: 162, b: 255)), for: .normal)
        editBtn.clipsToBounds = true
        editBtn.layer.cornerRadius = 10*kSCREEN_SCALE
    }

    
    func TClassInfoCellForStudent() {
        editBtn.isHidden = true
    }
    
    
    func TClassInfoCellForTeacher() {
        editBtn.isHidden = false
    }
    

    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
