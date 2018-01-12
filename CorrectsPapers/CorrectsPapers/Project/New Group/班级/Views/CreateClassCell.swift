//
//  CreateClassCell.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/21.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class CreateClassCell: UITableViewCell {

    
    @IBOutlet weak var classTitle: UILabel!
    
    @IBOutlet weak var className: UILabel!
    
//    var userInfo = ["姓名":"张迅","年龄":"38"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        直接这样写就行
//        如果字典里面有这个键名，那他就会把对应键名的值改为你刚赋的值
//        如果没有的话，就会直接添加一个键值对。
//        userInfo["身高"] = "180mm"
//        userInfo["年龄"] = "21"
//       deBugPrint(item: userInfo)
        
    }

    
    func CreateClassCellNormal(title:String,name:String) {
        className.text = name
        classTitle.text = title
    }    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
