//
//  ShowWorkNotDone.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/20.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class ShowWorkNotDone: UITableViewCell {

    @IBOutlet weak var workState: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var conplainBtn: UIButton!
    @IBOutlet weak var reSubmit: UIButton!

    @IBOutlet weak var workDescription: UILabel!
    
    @IBOutlet weak var workImages: UIView!
    
    var images = [KSPhotoItem]()
    var theCount = 1
    
    var conplainOrreSubmit:((String)->())?  //声明闭包

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        conplainBtn.layer.cornerRadius = 5
        conplainBtn.clipsToBounds = true
        conplainBtn.layer.borderColor = kMainColor().cgColor
        conplainBtn.layer.borderWidth = 1
        
        reSubmit.layer.cornerRadius = 5
        reSubmit.clipsToBounds = true
        
        workImages.layer.cornerRadius = 2
        workImages.clipsToBounds = true

        
        reSubmit.setBackgroundImage(getNavigationIMG(64, fromColor: kSetRGBColor(r: 0, g: 200, b: 255), toColor: kSetRGBColor(r: 0, g: 160, b: 255)), for: .normal)
    }
    
    
    @IBAction func resubmitAction(_ sender: UIButton) {
        
        if conplainOrreSubmit != nil {
            conplainOrreSubmit!("resubmit")
        }
    }
    
    
    @IBAction func conplainAction(_ sender: UIButton) {
        
        if conplainOrreSubmit != nil {
            conplainOrreSubmit!("conplain")
        }
    }
    
    
    func ShowWorkNotDoneForState(model:TClassWorkModel) {
        
        workState.text = kGetStateFromString(str: model.type!)
        workState.textColor = kGetColorFromString(str: workState.text!)
        
        timeLabel.text = model.create_date
        workDescription.text = model.title
        
        if model.type! == "2" || model.type! == "5"{
            conplainBtn.isHidden = true
            reSubmit.isHidden = true
        }else{
            conplainBtn.isHidden = false
            reSubmit.isHidden = false
        }
        
        var count = 0
        if Int(model.type)! < 5 {
            count = model.photo.count
            theCount = model.photo.count
        }else{
            count = model.photo_next.count
            theCount = model.photo_next.count
        }
        
        _ = workImages.subviews.map {
            $0.removeFromSuperview()
        }
        
        let kSpace = CGFloat(7)
        var kWidth = CGFloat()
        
        kWidth = (kSCREEN_WIDTH-30-kSpace*3)/4
        
        let kHeight = CGFloat(176*kSCREEN_SCALE)
        let lines = 4
        
        //MARK: 根据图片的数量进行排列
        for index in 0..<count{
            let row =  CGFloat(index%lines)
            
            let imageV = UIImageView.init(frame: CGRect(x:(kWidth + kSpace) * row, y:(kSpace+kHeight)*CGFloat(index/lines), width: kWidth, height: kHeight))
            
            if Int(model.type)! < 5 {
                imageV.kf.setImage(with: OCTools.getEfficientAddress(model.photo[index]), placeholder: #imageLiteral(resourceName: "class_default"), options: nil, progressBlock: nil, completionHandler: nil)
            }else{
                imageV.kf.setImage(with: OCTools.getEfficientAddress(model.photo_next[index]), placeholder: #imageLiteral(resourceName: "class_default"), options: nil, progressBlock: nil, completionHandler: nil)
            }
            imageV.contentMode = .scaleAspectFill
            imageV.clipsToBounds = true
            imageV.isUserInteractionEnabled = true
            let singleTap = UITapGestureRecognizer.init(target: self, action: #selector(viewTheBigImage(ges:)))
            singleTap.numberOfTapsRequired = 1
            imageV.addGestureRecognizer(singleTap)
            
            imageV.tag = 170 + index
            workImages.addSubview(imageV)
            deBugPrint(item: imageV.frame)
        }
        
        var height = 0
        
        let line = CGFloat((count)%4)
        
        if line == 0 {
            height = Int(CGFloat((count)/4)*kHeight + kSpace*CGFloat(count/4)-kSpace)
        }else{
            height = Int(CGFloat((count)/4+1)*kHeight + kSpace*CGFloat(count/4))
        }
        
        workImages.snp.updateConstraints { (ls) in
            ls.height.equalTo(height)
        }
    }
    
        
        
    @objc  func viewTheBigImage(ges:UITapGestureRecognizer) {
        
        var images = [KSPhotoItem]()
        
        for index in 0..<theCount {
            let theView = workImages.viewWithTag(index+170) as! UIImageView
            let watchIMGItem = KSPhotoItem.init(sourceView: theView, image: theView.image)
            images.append(watchIMGItem!)
        }
        
        let watchIMGView = KSPhotoBrowser.init(photoItems: images,
                                               selectedIndex:UInt((ges.view?.tag)!-170))
        watchIMGView?.dismissalStyle = .scale
        watchIMGView?.backgroundStyle = .blurPhoto
        watchIMGView?.loadingStyle = .indeterminate
        watchIMGView?.pageindicatorStyle = .text
        watchIMGView?.bounces = false
        watchIMGView?.show(from: viewController()!)
            
        }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
