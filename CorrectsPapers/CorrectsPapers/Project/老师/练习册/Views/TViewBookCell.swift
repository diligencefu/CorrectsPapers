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
    
    @IBOutlet weak var correctMark: UILabel!
    
    
    @IBOutlet weak var userIcon: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var userNum: UILabel!
    
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var gradeImage: UIImageView!
    
    @IBOutlet weak var bookState: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var bookTitle: UILabel!
    
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    
    
    @IBOutlet weak var theTeacher: UILabel!
    @IBOutlet weak var doThing: UILabel!
    
    @IBOutlet weak var remark: UITextView!
    
    
    var showImages = [String]()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

//        "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1507452668172&di=b56ef9d62498e704c0fa0e0b2c4d8dd5&imgtype=0&src=http%3A%2F%2Fimgphoto.gmw.cn%2Fattachement%2Fjpg%2Fsite2%2F20160714%2Fd02788d8df1018f171ec38.jpg","https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=998893491,2679530940&fm=27&gp=0.jpg","https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1508492977181&di=6e19e784b2f3c99c1cc5bcdf5b80410c&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fwallpaper%2F1%2F55daab78c98c6.jpg","https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1508492977181&di=65be80fcb3d1691e39c33a9bd075ed51&imgtype=0&src=http%3A%2F%2Fwww.pp3.cn%2Fuploads%2F201606%2F20160617016.jpg","https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1508493015032&di=59d8fa812fd03a4721892617c48b431b&imgtype=0&src=http%3A%2F%2Fe.hiphotos.baidu.com%2Fimage%2Fpic%2Fitem%2Fa8ec8a13632762d02bd1d67fa9ec08fa503dc607.jpg","https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1508493015032&di=638344075683b4ffd5faff080b6271af&imgtype=0&src=http%3A%2F%2Fg.hiphotos.baidu.com%2Fimage%2Fpic%2Fitem%2Ffaedab64034f78f0b17d083370310a55b2191cff.jpg","https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1508493043319&di=846fb92cbd69cba852b5052a3ac51bcd&imgtype=0&src=http%3A%2F%2Fimage1.miss-no1.com%2Fuploadfile%2F2015%2F11%2F06%2Fimg20246781918797.jpg","https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1508493075782&di=5b94886ffb411265673e1364788e0ab8&imgtype=0&src=http%3A%2F%2Fwww.pp3.cn%2Fuploads%2F201403%2F1394417566696.jpg"
        
        
        let tapGes1 = UITapGestureRecognizer.init(target: self, action: #selector(moveToEditImage(tap:)))
        tapGes1.numberOfTouchesRequired = 1
        image1.addGestureRecognizer(tapGes1)
        image2.addGestureRecognizer(tapGes1)
        image3.addGestureRecognizer(tapGes1)
    }

    @objc func moveToEditImage(tap:UITapGestureRecognizer) {
        

    }
    
    
    
    func TViewBookCellSetValuesForUndone(images:[String]) {
        
        showImages = images
        
        gradeImage.isHidden = true
        gradeLabel.isHidden = true
        bookState.isHidden = false
        correctMark.isHidden = true
        
        theTeacher.snp.updateConstraints({ (make) in
            make.height.equalTo(0)
        })

        bookState.snp.updateConstraints({ (make) in
            make.width.equalTo(55)
        })

        doThing.snp.updateConstraints({ (make) in
            make.height.equalTo(0)
        })
        remark.snp.updateConstraints({ (make) in
            make.height.equalTo(0)
        })

        theTeacher.isHidden = true
        doThing.isHidden = true
        remark.isHidden = true

        
        if images.count == 1 {

            image1.kf.setImage(with:  URL(string:images[0])!, placeholder: #imageLiteral(resourceName: "photos_image_default"), options: nil, progressBlock: nil, completionHandler: nil)
            image2.isHidden = true
            image3.isHidden = true
            
        }else  {
            image1.isHidden = true
            image2.kf.setImage(with:  URL(string:images[0])!, placeholder: #imageLiteral(resourceName: "photos_image_default"), options: nil, progressBlock: nil, completionHandler: nil)
            image3.kf.setImage(with:  URL(string:images[1])!, placeholder: #imageLiteral(resourceName: "photos_image_default"), options: nil, progressBlock: nil, completionHandler: nil)
            image2.isHidden = false
            image3.isHidden = false
            
        }
    }
    
    func TViewBookCellSetValuesForFirstCorrect(images:[String]) {
        
        showImages = images

        bookState.snp.updateConstraints({ (make) in
            make.width.equalTo(0)
        })
        
        gradeImage.isHidden = false
        gradeLabel.isHidden = false
        bookState.isHidden = true
        correctMark.isHidden = true

        
//        theTeacher.snp.updateConstraints({ (make) in
//            make.height.equalTo(0)
//        })
//
//        doThing.snp.updateConstraints({ (make) in
//            make.height.equalTo(0)
//        })
//        remark.snp.updateConstraints({ (make) in
//            make.height.equalTo(0)
//        })
//
//        theTeacher.isHidden = true
//        doThing.isHidden = true
//        remark.isHidden = true

        if images.count == 1 {
            
            image1.kf.setImage(with:  URL(string:images[0])!, placeholder: #imageLiteral(resourceName: "photos_image_default"), options: nil, progressBlock: nil, completionHandler: nil)
            image2.isHidden = true
            image3.isHidden = true
            
        }else  {
            image1.isHidden = true
            image2.kf.setImage(with:  URL(string:images[0])!, placeholder: #imageLiteral(resourceName: "photos_image_default"), options: nil, progressBlock: nil, completionHandler: nil)
            image3.kf.setImage(with:  URL(string:images[1])!, placeholder: #imageLiteral(resourceName: "photos_image_default"), options: nil, progressBlock: nil, completionHandler: nil)
            image2.isHidden = false
            image3.isHidden = false
            
        }
        
    }
    
    
    func TViewBookCellSetValuesForCorrectedToCorrection(images:[String]){
        showImages = images

        userNum.isHidden = true
        userIcon.isHidden = true
        userName.isHidden = true
        timeLabel.isHidden = true
        correctMark.isHidden = false
        bookState.isHidden = true
        gradeImage.isHidden = true
        gradeLabel.isHidden = true

        
        theTeacher.snp.updateConstraints({ (make) in
            make.height.equalTo(0)
        })
        
        doThing.snp.updateConstraints({ (make) in
            make.height.equalTo(0)
        })
        remark.snp.updateConstraints({ (make) in
            make.height.equalTo(0)
        })
        
        theTeacher.isHidden = true
        doThing.isHidden = true
        remark.isHidden = true

        bookTitle.snp.updateConstraints { (make) in
            make.top.equalTo(correctMark.snp.bottom).offset(5)
        }
        
        
        
        if images.count == 1 {
            
            image1.kf.setImage(with:  URL(string:images[0])!, placeholder: #imageLiteral(resourceName: "photos_image_default"), options: nil, progressBlock: nil, completionHandler: nil)
            image2.isHidden = true
            image3.isHidden = true
            
        }else  {
            image1.isHidden = true
            image2.kf.setImage(with:  URL(string:images[0])!, placeholder: #imageLiteral(resourceName: "photos_image_default"), options: nil, progressBlock: nil, completionHandler: nil)
            image3.kf.setImage(with:  URL(string:images[1])!, placeholder: #imageLiteral(resourceName: "photos_image_default"), options: nil, progressBlock: nil, completionHandler: nil)
            image2.isHidden = false
            image3.isHidden = false
            
        }
        
    }
    
    func TViewBookCellSetValuesCorrectedDone(images:[String]){
        showImages = images

        userNum.isHidden = true
        userIcon.isHidden = true
        userName.isHidden = true
        timeLabel.isHidden = true
        correctMark.isHidden = false
        bookState.isHidden = true

        
        bookTitle.snp.updateConstraints { (make) in
            make.top.equalTo(correctMark.snp.bottom).offset(5)
        }
        
        
        if images.count == 1 {
            
            image1.kf.setImage(with:  URL(string:images[0])!, placeholder: #imageLiteral(resourceName: "photos_image_default"), options: nil, progressBlock: nil, completionHandler: nil)
            image2.isHidden = true
            image3.isHidden = true
            
        }else  {
            image1.isHidden = true
            image2.kf.setImage(with:  URL(string:images[0])!, placeholder: #imageLiteral(resourceName: "photos_image_default"), options: nil, progressBlock: nil, completionHandler: nil)
            image3.kf.setImage(with:  URL(string:images[1])!, placeholder: #imageLiteral(resourceName: "photos_image_default"), options: nil, progressBlock: nil, completionHandler: nil)
            image2.isHidden = false
            image3.isHidden = false
            
        }
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
