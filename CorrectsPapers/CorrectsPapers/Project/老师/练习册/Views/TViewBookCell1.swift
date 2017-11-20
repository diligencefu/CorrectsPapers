//
//  TViewBookCell1.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/13.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class TViewBookCell1: UITableViewCell {

    @IBOutlet weak var userIcon: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userNum: UILabel!
    
    @IBOutlet weak var workState: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var bookTitle: UILabel!
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!    
    
    
    var testImages = ["https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1507452668172&di=b56ef9d62498e704c0fa0e0b2c4d8dd5&imgtype=0&src=http%3A%2F%2Fimgphoto.gmw.cn%2Fattachement%2Fjpg%2Fsite2%2F20160714%2Fd02788d8df1018f171ec38.jpg","https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=998893491,2679530940&fm=27&gp=0.jpg"]
    

    override func awakeFromNib() {
        super.awakeFromNib()

        userNum.font = UIFont.boldSystemFont(ofSize: 24*kSCREEN_SCALE)
    }
    
    //    2
    func TViewBookCellSetValuesForUndone(model:TShowStuWorksModel) {
        
        bookTitle.text = model.result

        if model.state == "2" {
            
            workState.text = "未批改"
            workState.textColor = kSetRGBColor(r: 255, g: 153, b: 0)
        }else{
            
            workState.text = "退回-照片模糊"
            workState.textColor = kSetRGBColor(r: 255, g: 78, b: 78)
        }
        
        image2.snp.updateConstraints({ (make) in
            make.bottom.equalToSuperview().offset(-10)
        })
        
        userIcon.kf.setImage(with:  URL(string:model.user_photo)!, placeholder: #imageLiteral(resourceName: "UserHead_128_default"), options: nil, progressBlock: nil, completionHandler: nil)
        userNum.text = "学号 " + model.user_num
        userName.text = model.user_name
        timeLabel.text = model.correcting_time
        
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
    
    
    
    //    2
    func TViewBookCellSetValuesForNotWorkUndone(model:TNotWorkDetailModel) {
        
        
        var images = [String]()
        
        let imageDatas = model.pre_photos?.arrayValue
        
        for index in 0..<imageDatas!.count {
            images.append(imageDatas![index].stringValue)
        }
        
        bookTitle.text = "model."
        
        workState.text = kGetStateFromString(str: model.state)
        workState.textColor = kGetColorFromString(str:model.state)

        image2.snp.updateConstraints({ (make) in
            make.bottom.equalToSuperview().offset(-10)
        })
        
        userIcon.kf.setImage(with:  URL(string:model.user_photo)!, placeholder: #imageLiteral(resourceName: "UserHead_128_default"), options: nil, progressBlock: nil, completionHandler: nil)
        userNum.text = "学号 " + model.user_num
        userName.text = model.student_name
        timeLabel.text = model.create_date
        
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
