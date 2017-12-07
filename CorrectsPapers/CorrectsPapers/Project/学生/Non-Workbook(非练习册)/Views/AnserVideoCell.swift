//
//  AnserVideoCell.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/17.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class AnserVideoCell: UITableViewCell {

    @IBOutlet weak var videoTitle: UILabel!
    
    @IBOutlet weak var videoDesc: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func AnserVideoCellSetValues(model:UrlModel) {
        
        videoTitle.text = model.counts
        videoDesc.text = model.point_title
    }
    
    
    func AnserVideoCellSetValuesForAnswer(title:String) {
        
//        videoTitle.text = model.counts
        videoDesc.text = title
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
