//
//  TShowBooksCell.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/20.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class TShowBooksCell: UITableViewCell {

    
    @IBOutlet weak var bookImage: UIImageView!
    
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var studentName: UILabel!
    @IBOutlet weak var proName: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var bookState: UILabel!
    
    
    @IBOutlet weak var addbtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        addbtn.layer.cornerRadius = 5
        addbtn.clipsToBounds = true
        addbtn.setBackgroundImage(getNavigationIMG(27, fromColor: kSetRGBColor(r: 0, g: 200, b: 255), toColor: kSetRGBColor(r: 0, g: 162, b: 255)), for: .normal)
    }

    func TShowBooksCellForShowBook() {
        
        
    }
    
    
    func TShowBooksCellForMyCorrect() {
        addbtn.isHidden = true
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
