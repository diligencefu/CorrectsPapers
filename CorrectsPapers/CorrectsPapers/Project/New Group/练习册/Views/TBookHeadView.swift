//
//  TBookHeadView.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/23.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class TBookHeadView: UIView {

    @IBOutlet weak var totalNum: UILabel!
    
    @IBOutlet weak var submitNum: UILabel!
    
    @IBOutlet weak var doneNum: UILabel!
    
//    @IBOutlet weak var image: UIImageView!
    
    override func awakeFromNib() {
        
    
    }

    
    func setValues(model:TMyWorkDetailModel) {
        
        totalNum.text = model.count
        submitNum.text = model.state1
        doneNum.text = model.state2
        
        if model.edition_photo.count>0 {
//            image.kf.setImage(with:  URL(string:model.edition_photo)!, placeholder: #imageLiteral(resourceName: "class_default"), options: nil, progressBlock: nil, completionHandler: nil)
        }

    }
    
    
    
}
