//
//  ComplaintRecordCell.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/17.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class ComplaintRecordCell: UITableViewCell {

    
    @IBOutlet weak var headImage: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userNum: UILabel!
    
    @IBOutlet weak var complaintCount: UILabel!
    
    
    @IBOutlet weak var reasonView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        headImage.layer.cornerRadius = 5
        headImage.clipsToBounds = true
        
        reasonView.height = 0
    }
    
    
    
    func ComplaintRecordCellForRecord() {
        reasonView.snp.updateConstraints { (make) in
            make.height.equalTo(0)
        }
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
