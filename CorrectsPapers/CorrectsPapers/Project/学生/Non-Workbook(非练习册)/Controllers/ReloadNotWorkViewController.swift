//
//  ReloadNotWorkViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/20.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyJSON

class ReloadNotWorkViewController: BaseViewController {
    
    var non_exercise_Id = ""
    var images = NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func requestData() {
        
        let cell2 = mainTableView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as! UpLoadWorkCell
        
        let params =
            [
                "SESSIONID":SESSIONID,
                "mobileCode":mobileCode,
                "non_exercise_Id":non_exercise_Id
        ]
        
        print(params)
        var imgArr = [UIImage]()
        var nameArr = [String]()
        
        imgArr.append(cell2.image2.image!)
        imgArr.append(cell2.image3.image!)
        
        nameArr.append("pre_photos1")
        nameArr.append("pre_photos2")
        
        netWorkForAddNonExerciseNext(params: params, data: imgArr, name: nameArr, success: { (success) in
            
        }) { (erorr) in
            
        }
        
    }
    
    
    override func configSubViews() {
        
        self.navigationItem.title = "选择老师"
        mainTableArr =  ["","","","","","",""]
        mainTableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: kSCREEN_HEIGHT - 64 ), style: .plain)
        mainTableView.dataSource = self;
        mainTableView.delegate = self;
        mainTableView.estimatedRowHeight = 143 * kSCREEN_SCALE;
        mainTableView.register(UINib(nibName: "UpLoadWorkCell", bundle: nil), forCellReuseIdentifier: identyfierTable)
        self.view.addSubview(mainTableView)
        
    }
    
    
    //MARK:  ******代理 ：UITableViewDataSource,UITableViewDelegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return mainTableArr.count
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : UpLoadWorkCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable, for: indexPath) as! UpLoadWorkCell
        cell.upLoadImagesForResubmit(images: images as! Array<UIImage>)
        
        cell.chooseImagesAction = {
            if $0 == "uploadAction" {
                let params =
                    [
                        "non_exercise_Id":self.non_exercise_Id,
                        "SESSIONID":SESSIONID,
                        "mobileCode":mobileCode
                ]
                
                var nameArr = [String]()
                
                for index in 0..<self.images.count {
                    nameArr.append("image\(index)")
                }
                
                netWorkForUploadWorkBookNext(params: params, data: self.images as! [UIImage], name: nameArr, success: { (datas) in
                    print(datas)
                    let json = JSON(datas)
                    print(json)
                    
                    if json["code"] == "1" {
                        
                        setToast(str: "上传成功")
                    }

                }, failture: { (error) in
                    print(error)
                })
                
            }else{
                self.setupPhoto1(count: 2)
            }
            
        }
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
        
    }

    
    // 异步原图
    private func setupPhoto1(count:NSInteger) {
        let imagePickTool = CLImagePickersTool()
        
        imagePickTool.isHiddenVideo = true
        
        imagePickTool.setupImagePickerWith(MaxImagesCount: count, superVC: self) { (assetArr,cutImage) in
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
                self?.dealImage(imageArr: imageArr, index: index)
                self?.mainTableView.reloadData()
                
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

    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
}
