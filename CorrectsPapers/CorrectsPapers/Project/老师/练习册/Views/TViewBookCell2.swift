//
//  TViewBookCell2.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/11.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class TViewBookCell2: UITableViewCell {

    
    @IBOutlet weak var doneMark: UILabel!
    
    
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var gradeImage: UIImageView!
        
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    
    
    @IBOutlet weak var remark: UITextView!
    
    var testImages = ["https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1507452668172&di=b56ef9d62498e704c0fa0e0b2c4d8dd5&imgtype=0&src=http%3A%2F%2Fimgphoto.gmw.cn%2Fattachement%2Fjpg%2Fsite2%2F20160714%2Fd02788d8df1018f171ec38.jpg","https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=998893491,2679530940&fm=27&gp=0.jpg"]

    override func awakeFromNib() {
      super.awakeFromNib()
   
    }
    
    func TViewBookCellSetValuesForDone(model:TShowStuWorksModel) {
        
        gradeImage.isHidden = false
        gradeLabel.isHidden = false
        doneMark.isHidden = false

        remark.isHidden = false
        remark.text = "老师评语：" + model.comment

        if model.scores == "1" {
            gradeImage.image = #imageLiteral(resourceName: "yixing_icon_pressed")
        }else if model.scores == "2" {
            gradeImage.image = #imageLiteral(resourceName: "erxing_icon_pressed")
        }else if model.scores == "3" {
            gradeImage.image = #imageLiteral(resourceName: "sanxing_icon_pressed")
        }else if model.scores == "4" {
            gradeImage.image = #imageLiteral(resourceName: "sixing_icon_pressed")
        }else if model.scores == "5"{
            gradeImage.image = #imageLiteral(resourceName: "wuxing_icon_pressed")
        }
        
        if testImages.count == 1 {
            
            image1.kf.setImage(with:  URL(string:testImages[0])!, placeholder: #imageLiteral(resourceName: "photos_image_default"), options: nil, progressBlock: nil, completionHandler: nil)
            image2.isHidden = true
            image3.isHidden = true
            
        }else {
            image1.isHidden = true
            image2.kf.setImage(with:  URL(string:testImages[0])!, placeholder: #imageLiteral(resourceName: "photos_image_default"), options: nil, progressBlock: nil, completionHandler: nil)
            image3.kf.setImage(with:  URL(string:testImages[1])!, placeholder: #imageLiteral(resourceName: "photos_image_default"), options: nil, progressBlock: nil, completionHandler: nil)
            image2.isHidden = false
            image3.isHidden = false
      
        }
    }
}
