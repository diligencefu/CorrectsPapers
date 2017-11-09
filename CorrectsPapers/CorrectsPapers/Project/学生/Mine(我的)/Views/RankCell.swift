//
//  RankCell.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/8.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class RankCell: UITableViewCell {

    
    @IBOutlet weak var rankImage: UIImageView!
    
    
    @IBOutlet weak var rankLabel: UILabel!
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var myRank: UILabel!
    @IBOutlet weak var label2: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    @IBOutlet weak var studentName: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    func showMyRank(ranking:String,score:String) {
        
        label1.isHidden = false
        label2.isHidden = false
        myRank.isHidden = false
        studentName.isHidden = true
        
        rankImage.isHidden = true
        rankLabel.isHidden = true
        rankImage.snp.updateConstraints { (make) in
            make.width.equalTo(0)
        }
        
        myRank.text = ranking
        scoreLabel.text = score
    }
    
    
    func showTopThreeRank(ranking:NSInteger,score:NSInteger,isme:Bool) {
        rankImage.isHidden = false
        rankLabel.isHidden = true
        rankImage.alpha = 1
        studentName.isHidden = false

        rankImage.snp.updateConstraints { (make) in
            make.width.equalTo(37)
        }
        label1.isHidden = true
        label2.isHidden = true
        myRank.isHidden = true

        if ranking == 0 {
            rankImage.image = #imageLiteral(resourceName: "num1_icon")
        }
        if ranking == 1 {
            rankImage.image = #imageLiteral(resourceName: "num2_icon")
        }
        if ranking == 2 {
            rankImage.image = #imageLiteral(resourceName: "num3_icon")
        }
        scoreLabel.text = "\(score) 学分"

        if isme {
            studentName.textColor = kMainColor()
        }else{
            studentName.textColor = kGaryColor(num: 117)
            
        }
    }
    
    
    func showAfterThirdPlaceRank(ranking:NSInteger,score:NSInteger,isme:Bool) {
        
        rankImage.alpha = 0
        rankLabel.isHidden = false
        studentName.isHidden = false

        label1.isHidden = true
        label2.isHidden = true
        myRank.isHidden = true
        
        rankLabel.text = "\(ranking+1)"
        scoreLabel.text = "\(score) 学分"
        
        if isme {
            
            studentName.textColor = kMainColor()
        }else{
            
            studentName.textColor = kGaryColor(num: 117)
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
