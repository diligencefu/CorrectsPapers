//
//  MyBookViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/13.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class MyBookViewController: BaseViewController{
    
    var emptyView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addImageWhenEmpty()
        //        接收上传练习册作业成功的通知
        NotificationCenter.default.addObserver(self, selector: #selector(receiveNitification(nitofication:)), name: NSNotification.Name(rawValue: SuccessUploadWorkNotiS), object: nil)
    }
    
    @objc func receiveNitification(nitofication:Notification) {
        self.mainTableView.mj_header.beginRefreshing()
    }

    override func requestData() {
        
        self.view.beginLoading()
        netWorkForMyWorkBook { (dataArr,flag) in
            deBugPrint(item: dataArr)
            if dataArr.count > 0 {
                
                self.mainTableArr.addObjects(from: dataArr)
                self.mainTableView.reloadData()
            }
            self.view.endLoading()
        }
    }
    
    
    override func refreshHeaderAction() {
        self.view.beginLoading()
        netWorkForMyWorkBook { (dataArr,flag) in
            deBugPrint(item: dataArr)
            
            if dataArr.count > 0 {
                self.mainTableArr.removeAllObjects()
                self.mainTableArr.addObjects(from: dataArr)
                self.mainTableView.reloadData()
            }
            self.view.endLoading()
            self.mainTableView.mj_header.endRefreshing()
        }
    }
    
    
    override func configSubViews() {
        
        self.navigationItem.title = "我的练习册"
        
        mainTableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: kSCREEN_HEIGHT - 64 ), style: .plain)
        mainTableView.dataSource = self;
        mainTableView.delegate = self;
        mainTableView.estimatedRowHeight = 143 * kSCREEN_SCALE;
        mainTableView.register(UINib(nibName: "MyBookCell", bundle: nil), forCellReuseIdentifier: identyfierTable)
        mainTableView.tableFooterView = UIView.init()
        self.view.addSubview(mainTableView)
    }
    
    
    //    当数据为空的时候，显示提示
    func addImageWhenEmpty() {
        
            emptyView = UIView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: kSCREEN_HEIGHT - 46))
            emptyView.backgroundColor = kBGColor()
            let imageView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: 200 * kSCREEN_SCALE, height: 200 * kSCREEN_SCALE))
            imageView.image = #imageLiteral(resourceName: "404_icon_default")
            imageView.center = CGPoint(x: emptyView.centerX, y: emptyView.centerY - 200 * kSCREEN_SCALE)
            emptyView.addSubview(imageView)
            
            let label = UILabel.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 18))
            label.textAlignment = .center
            label.textColor = kGaryColor(num: 163)
            label.center = CGPoint(x: emptyView.centerX, y: emptyView.centerY-40)
            label.font = kFont34
            label.numberOfLines = 2
            label.text = "暂时没有练习册"
            emptyView.addSubview(label)
        }
    
    
    //MARK:  ******代理 ：UITableViewDataSource,UITableViewDelegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if mainTableArr.count == 0 {
            self.mainTableView.addSubview(emptyView)

        }else{
            emptyView.removeFromSuperview()
        }
        
        return mainTableArr.count
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = mainTableArr[indexPath.row] as! WorkBookModel
        let cell : MyBookCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable, for: indexPath) as! MyBookCell
        cell.selectionStyle = .default
        cell.MyBookCellSetValue(model: model)
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = mainTableArr[indexPath.row] as! WorkBookModel
        let BookDetailVC = MyBookDetailViewController()
        BookDetailVC.model = model
        BookDetailVC.workState = model.correcting_states!
        let date = NSDate.init()
        let formatter = DateFormatter()
        //日期样式
        formatter.dateFormat = "yyyy-MM-dd"
        BookDetailVC.selectDate = formatter.string(from: date as Date)
        self.navigationController?.pushViewController(BookDetailVC, animated: true)

    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let model = mainTableArr[indexPath.row] as! WorkBookModel

        if editingStyle == .delete {
            
            let params =
                [
                    "userWorkBookId":model.userWorkBookId!,
                    "SESSIONID":Defaults[userToken]!,
                    "mobileCode":mobileCode
            ] as [String:Any]
            
            netWorkForDeleteMyWorkBook(params: params, callBack: { (done) in
                
                if done {
                    self.mainTableArr.remove(model)
                    tableView.reloadData()
                   deBugPrint(item: "删除了---\(indexPath.section)分区-\(indexPath.row)行")
                }else{
                    deBugPrint(item: "删除失败")
                }
            })
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        
        return "删除此作业"
    }
}

