//
//  ChooseImageCell.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/14.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class ChooseImageCell: UITableViewCell {

    
    @IBOutlet weak var upLoadImage1: UIImageView!
    
    @IBOutlet weak var upLoadImage2: UIImageView!
    
    var images = NSMutableArray()

    var chooseImagesAction:((String)->())?  //声明闭包

    override func awakeFromNib() {
        super.awakeFromNib()
        
        let singleTap1 = UITapGestureRecognizer.init(target: self, action: #selector(viewTheBigImage(ges:)))
        singleTap1.numberOfTapsRequired = 1
        upLoadImage1.addGestureRecognizer(singleTap1)
        
        
        let singleTap2 = UITapGestureRecognizer.init(target: self, action: #selector(viewTheBigImage(ges:)))
        singleTap2.numberOfTapsRequired = 1
        upLoadImage2.addGestureRecognizer(singleTap2)
        
    }
    
    @objc func viewTheBigImage(ges:UITapGestureRecognizer) {
        
//        if chooseImagesAction != nil {
//            chooseImagesAction!(String((ges.view?.tag)!-230))
//        }
        
        setupPhoto1(count: 2)
    }
    
    // 异步原图
    private func setupPhoto1(count:NSInteger) {
        let imagePickTool = CLImagePickersTool()
        
        imagePickTool.isHiddenVideo = true
        
        imagePickTool.setupImagePickerWith(MaxImagesCount: count, superVC: viewController()!) { (assetArr,cutImage) in
            print("返回的asset数组是\(assetArr)")
            
            PopViewUtil.share.showLoading()
            
            var imageArr = [UIImage]()
            var index = assetArr.count // 标记失败的次数
            
            // 获取原图，异步
            // scale 指定压缩比
            // 内部提供的方法可以异步获取图片，同步获取的话时间比较长，不建议！，如果是iCloud中的照片就直接从icloud中下载，下载完成后返回图片,同时也提供了下载失败的方法
            CLImagePickersTool.convertAssetArrToOriginImage(assetArr: assetArr, scale: 0.1, successClouse: {[weak self] (image,assetItem) in
                imageArr.append(image)
                
                self?.images.add(image)
                
                if self?.images.count == 2 {
                    
                    self?.upLoadImage1.image = self?.images[0] as? UIImage
                    self?.upLoadImage2.image = self?.images[0] as? UIImage

                }else{
                    self?.upLoadImage1.image = self?.images[0] as? UIImage

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

    }
    
    
    
    
}
