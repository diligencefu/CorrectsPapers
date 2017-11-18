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
    
    @IBOutlet weak var bookTitle: UILabel!
    
    @IBOutlet weak var theTeacher: UILabel!
    
    @IBOutlet weak var theCount: UILabel!
    
    @IBOutlet weak var handTime: UILabel!
    
    @IBOutlet weak var handedCount: UILabel!
    
    var addClassBlock:((String)->())?  //声明闭包

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        addClass.setBackgroundImage( getNavigationIMG(27, fromColor: kSetRGBColor(r: 0, g: 200, b: 255), toColor: kSetRGBColor(r: 0, g: 162, b: 255))
, for: .normal)
        
        addClass.layer.cornerRadius = 5
        addClass.clipsToBounds = true
    }

    
    func classCellSetValue(model:ClassModel,isSearch:Bool) {
        if !isSearch {
            addClass.snp.updateConstraints { (make) in
                make.height.equalTo(0)
            }
        }else{
            addClass.snp.updateConstraints { (make) in
                make.height.equalTo(25)
            }
        }
        
        bookImage.kf.setImage(with:  URL(string:model.class_photo)!, placeholder: #imageLiteral(resourceName: "photos_image_default"), options: nil, progressBlock: nil, completionHandler: nil)
        bookTitle.text = model.class_name
        theTeacher.text = model.user_name
        theCount.text = model.countStudent
        handTime.text = model.work_times
        handedCount.text = model.countWorkBookBy+"/"+model.countStudent
        addClass.isHidden = !isSearch
    }
    
    
    
//    func classCellSetValueTeacher(model:TClassModel,isSearch:Bool) {
//        if !isSearch {
//            addClass.snp.updateConstraints { (make) in
//                make.height.equalTo(0)
//            }
//        }else{
//            addClass.snp.updateConstraints { (make) in
//                make.height.equalTo(25)
//            }
//        }
//        
//        bookImage.kf.setImage(with:  URL(string:model.class_photo)!, placeholder: #imageLiteral(resourceName: "photos_image_default"), options: nil, progressBlock: nil, completionHandler: nil)
//        bookTitle.text = model.class_name
//        theTeacher.text = model.user_name
//        theCount.text = model.countStudent
//        handTime.text = model.work_times
//        handedCount.text = model.countWorkBookBy+"/"+model.countStudent
//        addClass.isHidden = !isSearch
//    }
//    

    
    
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
