//
//  ApplyListViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/17.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class ApplyListViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addImageWhenEmpty()
    }
    
    override func requestData() {
        netWorkForApplyList { (datas, flag) in
             self.mainTableArr.removeAllObjects()
            if flag {
                self.mainTableArr.addObjects(from: datas)
                self.mainTableView.reloadData()
            }else{
                self.mainTableArr.addObjects(from: datas)
                self.mainTableView.reloadData()
            }
        }
    }
    
    
    override func configSubViews() {
        
        self.navigationItem.title = "好友申请列表"
        
        mainTableView = UITableView.init(frame: CGRect(x: 0,
                                                       y: 0,
                                                       width: kSCREEN_WIDTH,
                                                       height: kSCREEN_HEIGHT - 64 ),
                                         style: .grouped)
        mainTableView.dataSource = self;
        mainTableView.delegate = self;
        mainTableView.estimatedRowHeight = 44
        mainTableView.register(UINib(nibName: "ApplyCell", bundle: nil), forCellReuseIdentifier: identyfierTable)
        self.view.addSubview(mainTableView)
        mainTableView.backgroundColor = kSetRGBColor(r: 239, g: 239, b: 244)
        
    }
    
    //    当数据为空的时候，显示提示
    var emptyView = UIView()
    
    func addImageWhenEmpty() {
        emptyView = UIView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: kSCREEN_HEIGHT - 46))
        emptyView.backgroundColor = kBGColor()
        let imageView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: 200 * kSCREEN_SCALE, height: 200 * kSCREEN_SCALE))
        imageView.image = #imageLiteral(resourceName: "404_icon_default")
        imageView.center = CGPoint(x: emptyView.centerX, y: emptyView.centerY - 130 * kSCREEN_SCALE)
        emptyView.addSubview(imageView)
        
        let label = UILabel.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 18))
        label.textAlignment = .center
        label.textColor = kGaryColor(num: 163)
        label.center = CGPoint(x: emptyView.centerX, y: emptyView.centerY-40+70*kSCREEN_SCALE)
        label.font = kFont34
        label.numberOfLines = 2
        label.text = "暂无好友申请"
        emptyView.addSubview(label)
    }
    
    
    //    ******************代理 ： UITableViewDataSource,UITableViewDelegate  ************
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  1
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if mainTableArr.count == 0 {
            self.mainTableView.addSubview(emptyView)
        }else{
            emptyView.removeFromSuperview()
        }
        
        return mainTableArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = mainTableArr[indexPath.section] as! ApplyModel
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identyfierTable, for: indexPath) as! ApplyCell
        cell.setValuesForApplyCell(model: model)
        cell.checkApplyBlock = {
            var params = ["":""]
            
            if $0 {
                params = [
                    "SESSIONID":SESSIONID,
                    "mobileCode":mobileCode,
                    "type":"1",
                    "userId":model.userId,
                    ]
            }else{
                params = [
                    "SESSIONID":SESSIONID,
                    "mobileCode":mobileCode,
                    "type":"2",
                    "userId":model.userId,
                ]
            }
            netWorkForDoAllow(params: params, callBack: { (success) in
                
            })
            self.requestData()
        }
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 12))
        view.backgroundColor = kGaryColor(num: 244)
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
//        if section == 2 {
//            return 20 * kSCREEN_SCALE
//        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20 * kSCREEN_SCALE
    }
    
}
