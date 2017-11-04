//
//  EditHeadCell.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/21.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class EditHeadCell: UITableViewCell {

    @IBOutlet weak var userIcon: UIImageView!
    
    var setUserIconBlock:((String)->())?  //声明闭包

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let singleTap2 = UITapGestureRecognizer.init(target: self, action: #selector(chooseHeadIcon(ges:)))
        singleTap2.numberOfTapsRequired = 1
        self.addGestureRecognizer(singleTap2)
        self.isUserInteractionEnabled = true

        userIcon.layer.cornerRadius = 8*kSCREEN_SCALE
        userIcon.clipsToBounds = true
    }
    
    func setUserIcon(model:PersonalModel) {
        
        if model.user_phone != nil {
            userIcon.kf.setImage(with:  URL(string:model.user_photo)!, placeholder: #imageLiteral(resourceName: "UserHead_128_default"), options: nil, progressBlock: nil, completionHandler: nil)
        }else{
            userIcon.image = #imageLiteral(resourceName: "UserHead_128_default")
        }
        
    }
    
    
    
    @objc func chooseHeadIcon(ges:UITapGestureRecognizer) {
        setupPhoto(count: 1)
    }
    
    // 异步原图
    private func setupPhoto(count:NSInteger) {
        let imagePickTool = CLImagePickersTool()
        
        imagePickTool.isHiddenVideo = true
        
        imagePickTool.setupImagePickerWith(MaxImagesCount: 1, superVC: viewController()!) { (assetArr,cutImage) in
            print("返回的asset数组是\(assetArr)")
            
            PopViewUtil.share.showLoading()
            
            var imageArr = [UIImage]()
            var index = assetArr.count // 标记失败的次数
            
            
            // 获取原图，异步
            // scale 指定压缩比
            // 内部提供的方法可以异步获取图片，同步获取的话时间比较长，不建议！，如果是iCloud中的照片就直接从icloud中下载，下载完成后返回图片,同时也提供了下载失败的方法
            CLImagePickersTool.convertAssetArrToOriginImage(assetArr: assetArr, scale: 0.1, successClouse: {[weak self] (image,assetItem) in
                imageArr.append(image)
                
                self?.userIcon.image = image
                
                if self?.setUserIconBlock != nil {
                    self?.setUserIconBlock!("")
                }
                
                self?.dealImage(imageArr: imageArr, index: index)
                
                }, failedClouse: { () in
                    index = index - 1
                    self.dealImage(imageArr: imageArr, index: index)
            })
        }
    }
    
    @objc func dealImage(imageArr:[UIImage],index:Int) {
        // 图片下载完成后再去掉我们的转转转控件，这里没有考虑assetArr中含有视频文件的情况
        if imageArr.count == index {
            PopViewUtil.share.stopLoading()
        }
        // 图片显示出来以后可能还要上传到云端的服务器获取图片的url，这里不再细说了。
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
