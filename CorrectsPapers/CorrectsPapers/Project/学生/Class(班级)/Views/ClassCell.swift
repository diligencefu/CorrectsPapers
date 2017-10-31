//
//  ClassCell.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/14.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class ClassCell: UITableViewCell {

    
    @IBOutlet weak var addClass: UIButton!
    
    @IBOutlet weak var bookImage: UIImageView!
    
    var addClassBlock:((String)->())?  //声明闭包

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        addClass.setBackgroundImage( getNavigationIMG(27, fromColor: kSetRGBColor(r: 0, g: 200, b: 255), toColor: kSetRGBColor(r: 0, g: 162, b: 255))
, for: .normal)
        
        addClass.layer.cornerRadius = 5
        addClass.clipsToBounds = true
    }

    
    func classCellSetValue(isSearch:Bool) {
        if !isSearch {
            addClass.snp.updateConstraints { (make) in
                make.height.equalTo(0)
            }
        }else{
            addClass.snp.updateConstraints { (make) in
                make.height.equalTo(25)
            }

        }
        addClass.isHidden = !isSearch
        
    }
    
    @IBAction func addClassAction(_ sender: UIButton) {
        
        if addClassBlock != nil {
            addClassBlock!("add")
        }
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
