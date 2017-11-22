//
//  TNotGoodWorkCell.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/18.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class TNotGoodWorkCell: UITableViewCell {

    @IBOutlet weak var state: UILabel!
    
    @IBOutlet weak var workImages: UIView!
    
    var theCount = 1
    
    var typeArr = NSMutableArray()
    var images = [KSPhotoItem]()
    var editArr = [UIImage]()

    override func awakeFromNib() {
        super.awakeFromNib()
        
        typeArr = ["https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1507451558288&di=2f1438a523984a5c8ee8f9d92714383a&imgtype=0&src=http%3A%2F%2Fimg4q.duitang.com%2Fuploads%2Fitem%2F201502%2F15%2F20150215230510_FCHPA.jpeg","https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1507451558288&di=ae7eb20eb0788a23ebc7dccc16e289c6&imgtype=0&src=http%3A%2F%2Fe.hiphotos.baidu.com%2Fzhidao%2Fpic%2Fitem%2F9f2f070828381f3005e59fceae014c086f06f0dd.jpg","https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1507451558287&di=b6092db93ceb252f048d9fc7101f8a1c&imgtype=0&src=http%3A%2F%2Fres.cngoldres.com%2Fupload%2F2014%2F0820%2F2024648a4bb337806599433ff65b20cd.jpg%3F_%3D1408516467211","https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1507451558287&di=26922f60bea7a869f71402ea127b58da&imgtype=0&src=http%3A%2F%2Fmvimg2.meitudata.com%2F57f21bc484f8e1558.jpg","https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1507451558287&di=4987b88d5f7fdc060eb21fcf8cf0919d&imgtype=0&src=http%3A%2F%2Fimg4q.duitang.com%2Fuploads%2Fitem%2F201504%2F10%2F20150410H5851_YsiBX.thumb.700_0.png","https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1506062520247&di=b6b4ea0f38456852fd94702b7dce345f&imgtype=0&src=http%3A%2F%2F0img.mgtv.com%2Fpreview%2Fsp_images%2F2017%2Fxinwen%2F308953%2F3808641%2F20170206145734419.jpg","https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1507451558286&di=6eda846c7bc9aa9a84c4dea43bf13949&imgtype=0&src=http%3A%2F%2Fimg.tupianzj.com%2Fuploads%2Fallimg%2F160308%2F9-16030P94120.jpg","https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1507452668172&di=b56ef9d62498e704c0fa0e0b2c4d8dd5&imgtype=0&src=http%3A%2F%2Fimgphoto.gmw.cn%2Fattachement%2Fjpg%2Fsite2%2F20160714%2Fd02788d8df1018f171ec38.jpg","https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=998893491,2679530940&fm=27&gp=0.jpg","https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1508492977181&di=6e19e784b2f3c99c1cc5bcdf5b80410c&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fwallpaper%2F1%2F55daab78c98c6.jpg","https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1508492977181&di=65be80fcb3d1691e39c33a9bd075ed51&imgtype=0&src=http%3A%2F%2Fwww.pp3.cn%2Fuploads%2F201606%2F20160617016.jpg","https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1508493015032&di=59d8fa812fd03a4721892617c48b431b&imgtype=0&src=http%3A%2F%2Fe.hiphotos.baidu.com%2Fimage%2Fpic%2Fitem%2Fa8ec8a13632762d02bd1d67fa9ec08fa503dc607.jpg","https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1508493015032&di=638344075683b4ffd5faff080b6271af&imgtype=0&src=http%3A%2F%2Fg.hiphotos.baidu.com%2Fimage%2Fpic%2Fitem%2Ffaedab64034f78f0b17d083370310a55b2191cff.jpg","https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1508493043319&di=846fb92cbd69cba852b5052a3ac51bcd&imgtype=0&src=http%3A%2F%2Fimage1.miss-no1.com%2Fuploadfile%2F2015%2F11%2F06%2Fimg20246781918797.jpg","https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1508493075782&di=5b94886ffb411265673e1364788e0ab8&imgtype=0&src=http%3A%2F%2Fwww.pp3.cn%2Fuploads%2F201403%2F1394417566696.jpg"]
        
    }

    
    func TNotGoodWorkCellSetValuesForCorrectUndone(model:TShowClassWorksModel) {
        
        theCount = 15
        _ = workImages.subviews.map {
            $0.removeFromSuperview()
        }
        editArr.removeAll()
        let kSpace = CGFloat(7)
        var kWidth = CGFloat()
        
        state.text = kGetStateFromString(str: model.type)
        state.textColor = kGetColorFromString(str:state.text!)
        
        kWidth = (kSCREEN_WIDTH-16-15-15-kSpace*3)/4

        let kHeight = CGFloat(176*kSCREEN_SCALE)
        let lines = 4
        
        //MARK: 根据图片的数量进行排列
        for index in 0..<theCount{
            let row =  CGFloat(index%lines)
            
            let imageV = UIImageView.init(frame: CGRect(x:(kWidth + kSpace) * row, y:(kSpace+kHeight)*CGFloat(index/lines), width: kWidth, height: kHeight))
//            imageV.kf.setImage(with: URL(string:typeArr[index] as! String)!, placeholder: #imageLiteral(resourceName: "workBook"), options: nil, progressBlock: nil, completionHandler: { (image, error, type, url) in
//                self.editArr.append(imageV.image!)
//            })
            imageV.kf.setImage(with: URL(string:typeArr[index] as! String)!, placeholder: #imageLiteral(resourceName: "workBook"), options: nil, progressBlock: nil, completionHandler: {(image, error, type, url) in
                self.editArr.append(imageV.image!)
            })
            imageV.contentMode = .scaleAspectFill
            imageV.clipsToBounds = true
            
            imageV.isUserInteractionEnabled = true
            let singleTap = UITapGestureRecognizer.init(target: self, action: #selector(viewTheBigImage(ges:)))
            singleTap.numberOfTapsRequired = 1
            imageV.addGestureRecognizer(singleTap)
//            editArr.append(imageV.image!)
            imageV.tag = 170 + index
            workImages.addSubview(imageV)
//            print(imageV.frame)
        }
        
        var height = 0
        
        let line = CGFloat((theCount)%4)
        
        if line == 0 {
            height = Int(CGFloat((theCount)/4)*kHeight + kSpace*CGFloat(theCount/4)-kSpace)
        }else{
            height = Int(CGFloat((theCount)/4+1)*kHeight + kSpace*CGFloat(theCount/4))
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
