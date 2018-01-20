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
    
    @IBOutlet weak var showState: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        headImage.layer.cornerRadius = 5
        headImage.clipsToBounds = true
        
    }
    
    
    func ComplaintRecordCellForRecord() {
    }
    
    
    func changeState(model:TComplaintModel,isOn:Bool) -> Void {
        
        userName.text = model.user_name
        userNum.text = "学号 "+model.user_num
        headImage.kf.setImage(with: OCTools.getEfficientAddress(model.user_photo), placeholder: #imageLiteral(resourceName: "UserHead_64_default"), options: nil, progressBlock: nil, completionHandler: nil)
        complaintCount.text = "\(model.coms.count)"

        if isOn {
            showState.image = #imageLiteral(resourceName: "up-arrow_icon")
        }else{
            showState.image = #imageLiteral(resourceName: "dropdown-arrow_icon")
        }
    } 
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
