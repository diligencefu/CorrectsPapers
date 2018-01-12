//
//  ClassCell.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/14.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

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
        
        bookImage.kf.setImage(with:  URL(string:model.class_photo)!, placeholder: #imageLiteral(resourceName: "class_default"), options: nil, progressBlock: nil, completionHandler: nil)
        bookTitle.text = model.class_name
        theTeacher.text = model.user_name
        theCount.text = model.countStudent
        handTime.text = model.work_times
        handedCount.text = model.countWorkBookBy+"/"+model.countStudent
        addClass.isHidden = !isSearch
        
        
        if Defaults[userIdentity] == kTeacher {
            
            if model.isAdd == "yes"{
                addClass.isEnabled = false
                addClass.backgroundColor = kGaryColor(num: 179)
                addClass.setTitle("已申请加入", for: .normal)
            }else{
                addClass.isEnabled = true
                addClass.setBackgroundImage( getNavigationIMG(27, fromColor: kSetRGBColor(r: 0, g: 200, b: 255), toColor: kSetRGBColor(r: 0, g: 162, b: 255))
                    , for: .normal)
                addClass.setTitle("申请加入", for: .normal)
            }

        }else{
            ///（学生段用）  “ByClass”：（“1”：申请中；“2”：已经加入；“3”：拒绝加入；“0”：未申请未加入过）

            if model.ByClass != "0" {
                addClass.isEnabled = false
                addClass.backgroundColor = kGaryColor(num: 179)
                
                if model.ByClass == "1" {
                    addClass.setTitle("等待审核", for: .normal)
                }else  if model.ByClass == "2" {
                    addClass.setTitle("已加入", for: .normal)
                }else  if model.ByClass == "3" {
                    addClass.setTitle("已被拒绝", for: .normal)
                }
            }else{
                addClass.isEnabled = true
                addClass.setBackgroundImage( getNavigationIMG(27, fromColor: kSetRGBColor(r: 0, g: 200, b: 255), toColor: kSetRGBColor(r: 0, g: 162, b: 255))
                    , for: .normal)
                addClass.setTitle("申请加入", for: .normal)
            }
        }
        
        
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
//        UIApplication.shared.keyWindow?.rootViewController?.present(TClassViewController(), animated: true, completion: nil)
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
