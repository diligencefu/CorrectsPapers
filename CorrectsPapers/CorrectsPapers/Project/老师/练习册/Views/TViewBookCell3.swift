//
//  TViewBookCell3.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/13.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class TViewBookCell3: UITableViewCell {

    @IBOutlet weak var bookState: UILabel!
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    
    var testImages = ["https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1507452668172&di=b56ef9d62498e704c0fa0e0b2c4d8dd5&imgtype=0&src=http%3A%2F%2Fimgphoto.gmw.cn%2Fattachement%2Fjpg%2Fsite2%2F20160714%2Fd02788d8df1018f171ec38.jpg","https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=998893491,2679530940&fm=27&gp=0.jpg"]

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func TViewBookCellSetValuesForUndone(model:TShowStuWorksModel) {
        bookState.isHidden = false
        
        bookState.textColor = kSetRGBColor(r: 255, g: 153, b: 0)

        if model.state == "2" {
            
            bookState.text = "未批改"
        }else{
            
            bookState.text = "错题未批改"
//            bookState.textColor = kSetRGBColor(r: 255, g: 78, b: 78)
        }
        
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
    
    
    
    func TViewBookCellSetValuesForNorWorkUndone(model:TNotWorkDetailModel) {
        bookState.isHidden = false
        var images = [String]()
        
        let imageDatas = model.pre_photos?.arrayValue
        
        for index in 0..<imageDatas!.count {
            images.append(imageDatas![index].stringValue)
        }

        bookState.text = kGetStateFromString(str: model.state)
        
        bookState.textColor = kGetColorFromString(str:bookState.text!)

        if images.count == 1 {
            
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

        // Configure the view for the selected state
    }
    
}
