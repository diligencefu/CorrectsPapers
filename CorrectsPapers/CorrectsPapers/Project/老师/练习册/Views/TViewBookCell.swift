//
//  TViewBookCell.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/23.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import Kingfisher

class TViewBookCell:  UITableViewCell {
    
    var dataArr = NSMutableArray()
    
    let kHeight = kSCREEN_SCALE * 200
    
    
    @IBOutlet weak var userIcon: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var userNum: UILabel!
    
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var gradeImage: UIImageView!
        
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var bookTitle: UILabel!
    
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    
    
    @IBOutlet weak var theTeacher: UILabel!
    @IBOutlet weak var doThing: UILabel!
    
    @IBOutlet weak var remark: UITextView!
    
    
    var showImages = [String]()
    
    var testImages = ["https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1507452668172&di=b56ef9d62498e704c0fa0e0b2c4d8dd5&imgtype=0&src=http%3A%2F%2Fimgphoto.gmw.cn%2Fattachement%2Fjpg%2Fsite2%2F20160714%2Fd02788d8df1018f171ec38.jpg","https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=998893491,2679530940&fm=27&gp=0.jpg"]

    override func awakeFromNib() {
        super.awakeFromNib()
        
//        let tapGes1 = UITapGestureRecognizer.init(target: self, action: #selector(moveToEditImage(tap:)))
//        tapGes1.numberOfTouchesRequired = 1
//        image1.addGestureRecognizer(tapGes1)
//        image2.addGestureRecognizer(tapGes1)
//        image3.addGestureRecognizer(tapGes1)
        userNum.font = UIFont.boldSystemFont(ofSize: 24*kSCREEN_SCALE)

    }

    @objc func moveToEditImage(tap:UITapGestureRecognizer) {
        

    }    
    
//    4
    func TViewBookCellSetValuesForFirstCorrectDone(model:TShowStuWorksModel) {
        bookTitle.text = model.result

        showImages = testImages
        gradeImage.isHidden = false
        gradeLabel.isHidden = false
        doThing.isHidden = false
        theTeacher.isHidden = false
        remark.isHidden = false
        
        userIcon.kf.setImage(with:  URL(string:model.user_photo)!, placeholder: #imageLiteral(resourceName: "UserHead_128_default"), options: nil, progressBlock: nil, completionHandler: nil)
        userNum.text =  model.user_num
        userName.text = model.user_name
        timeLabel.text = model.correcting_time
        //        bookTitle.text = model.
        theTeacher.text = model.teacher_name
        remark.text = "老师评语：" + model.comment
        
        if model.scores == "1" {
            gradeImage.image = #imageLiteral(resourceName: "yixing_icon_pressed")
        }else if model.scores == "2" {
            gradeImage.image = #imageLiteral(resourceName: "erxing_icon_pressed")
        }else if model.scores == "3" {
            gradeImage.image = #imageLiteral(resourceName: "sanxing_icon_pressed")
        }else if model.scores == "4" {
            gradeImage.image = #imageLiteral(resourceName: "sixing_icon_pressed")
        }else if model.scores == "4"{
            gradeImage.image = #imageLiteral(resourceName: "wuxing_icon_pressed")
        }
        
        image2.snp.updateConstraints({ (make) in
            make.bottom.equalTo(theTeacher.snp.top).offset(-5)
        })

        if testImages.count == 1 {
            
            image1.kf.setImage(with:  URL(string:testImages[0])!, placeholder: #imageLiteral(resourceName: "photos_image_default"), options: nil, progressBlock: nil, completionHandler: nil)
            image2.isHidden = true
            image3.isHidden = true
        }else  {
            
            image1.isHidden = true
            image2.kf.setImage(with:  URL(string:testImages[0])!, placeholder: #imageLiteral(resourceName: "photos_image_default"), options: nil, progressBlock: nil, completionHandler: nil)
            image3.kf.setImage(with:  URL(string:testImages[1])!, placeholder: #imageLiteral(resourceName: "photos_image_default"), options: nil, progressBlock: nil, completionHandler: nil)
            image2.isHidden = false
            image3.isHidden = false
        }
    }
    
    
    func TViewBookCellSetValues123456() {
        
        showImages = testImages
        
        gradeImage.isHidden = true
        gradeLabel.isHidden = true
        
        theTeacher.snp.updateConstraints({ (make) in
            make.height.equalTo(0)
        })
        
        doThing.snp.updateConstraints({ (make) in
            make.height.equalTo(0)
        })
        remark.text = ""
        
        theTeacher.isHidden = true
        doThing.isHidden = true
        remark.isHidden = true
        
        if testImages.count == 1 {
            
            image1.kf.setImage(with:  URL(string:testImages[0])!, placeholder: #imageLiteral(resourceName: "photos_image_default"), options: nil, progressBlock: nil, completionHandler: nil)
            image2.isHidden = true
            image3.isHidden = true
            
        }else  {
            image1.isHidden = true
            image2.kf.setImage(with:  URL(string:testImages[0])!, placeholder: #imageLiteral(resourceName: "photos_image_default"), options: nil, progressBlock: nil, completionHandler: nil)
            image3.kf.setImage(with:  URL(string:testImages[1])!, placeholder: #imageLiteral(resourceName: "photos_image_default"), options: nil, progressBlock: nil, completionHandler: nil)
            image2.isHidden = false
            image3.isHidden = false
            
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
