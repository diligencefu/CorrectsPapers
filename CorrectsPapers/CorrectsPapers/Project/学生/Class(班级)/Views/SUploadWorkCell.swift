//
//  SUploadWorkCell.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/20.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class SUploadWorkCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout  {

    var collect = UICollectionView(frame: CGRect(x: 25, y: 150, width: 50, height: 40), collectionViewLayout: UICollectionViewFlowLayout())

    var dataArr = NSMutableArray()
    
    let kHeight = kSCREEN_SCALE * 200
    
    var isEditting = false

    
    @IBOutlet weak var imagesCollect: UIView!
    
    @IBOutlet weak var uploadBtn: UIButton!
    
    @IBOutlet weak var bookTitle: UITextField!
    
    let identifierCell = "ShowImageCell"
    
    var addImageAction:((String)->())?  //声明闭包
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        uploadBtn.layer.cornerRadius = 5
        uploadBtn.clipsToBounds = true
        
        uploadBtn.setBackgroundImage(getNavigationIMG(27, fromColor: kSetRGBColor(r: 0, g: 200, b: 255), toColor: kSetRGBColor(r: 0, g: 162, b: 255)), for: .normal)
        
        //        创建collectionView
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 1, height:1)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        //        设置每行之间最小的间距
        layout.minimumLineSpacing = 10
        collect = UICollectionView(frame: CGRect(x: 0, y: 0, width: imagesCollect.width, height: 240 * kSCREEN_SCALE), collectionViewLayout: layout)
        collect.backgroundColor = UIColor.white
        collect.delegate = self
        collect.dataSource = self
        
        collect.register(UINib.init(nibName: "ShowImageCell", bundle: nil), forCellWithReuseIdentifier: identifierCell)
        imagesCollect.addSubview(collect)

        collect.snp.makeConstraints { (make) in
            make.bottom.left.right.top.equalToSuperview()
        }
        
    }
    
    func SUploadWorkCellSetValues(images:[UIImage]) {

        dataArray = images
        
        if images.count > 0 {
            uploadBtn.isEnabled = true
        }
        
        if images.count == 0 || bookTitle.text?.characters.count == 0{
            uploadBtn.isEnabled = false
        }else{
            uploadBtn.isEnabled = true
            uploadBtn.setBackgroundImage(getNavigationIMG(27, fromColor: kSetRGBColor(r: 0, g: 200, b: 255), toColor: kSetRGBColor(r: 0, g: 162, b: 255)), for: .normal)
        }
        
        var rows = CGFloat(images.count/4+1)
        
        
        if rows > 3 {
            rows = 3
        }
        
        imagesCollect.snp.updateConstraints { (make) in
            make.height.equalTo(rows * kHeight)
        }
        
        collect.reloadData()
    }
    
    
    //    collectionViewDelegate and Datasource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if dataArray?.count == nil {
            return 1
        }
        
        return (dataArray?.count)! + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifierCell, for: indexPath) as! ShowImageCell

        if indexPath.row != dataArray?.count {
            cell.setImages(image:dataArray![indexPath.row], isEditting: isEditting)
            cell.deleteAction = {
                print($0)
                self.dataArray?.remove(at: indexPath.row)
                collectionView.reloadData()
            }            
        }else{
            cell.noImage()
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (imagesCollect.width - (kSCREEN_SCALE * 33))/4, height: kHeight)
    }
    
    //    最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return kSCREEN_SCALE * 11
    }
    
    //    每个section的缩进
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: kSCREEN_SCALE * 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
        
        if addImageAction != nil {
            if dataArray?.count != nil {
                
            }
            
            if indexPath.row == (dataArray?.count)!-1 {
                
            }
            
         addImageAction!("add")
        }
    }
    
    public var dataArray : Array<UIImage>?{
        didSet{
            print(dataArray as Any)
            collect.reloadData()
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
