//
//  MyCorrectViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/20.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class TMyCorrectViewController: BaseViewController {
    var emptyView = UIView()    
    var pageNum = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addImageWhenEmpty()
//        addFooterRefresh()
    }
    
    
    override func requestData() {
        self.view.beginLoading()
        let params =
            ["SESSIONID":Defaults[userToken]!,
             "mobileCode":mobileCode,
//             "pageNo":String(pageNum)
                ] as [String : Any]

        NetWorkTeacherGetTMyAllNotWork(params: params) { (datas,flag) in
            if flag {
                self.mainTableArr.removeAllObjects()
                self.mainTableArr.addObjects(from: datas)
                self.mainTableView.reloadData()
            }
            self.view.endLoading()
        }
    }
    
    
    override func refreshHeaderAction() {

        pageNum = 0
        let params =
            ["SESSIONID":Defaults[userToken]!,
             "mobileCode":mobileCode,
//             "pageNo":String(pageNum)
                ] as [String : Any]
        
        NetWorkTeacherGetTMyAllNotWork(params: params) { (datas,flag) in
            if flag {
                self.mainTableArr.removeAllObjects()
                self.mainTableArr.addObjects(from: datas)
                self.mainTableView.reloadData()
                self.mainTableView.mj_header.endRefreshing()
            }
        }
    }

    override func refreshFooterAction() {
        pageNum = pageNum+1
        let param =
            [
                "SESSIONID":Defaults[userToken]!,
                "mobileCode":mobileCode,
//                "pageNo":String(pageNum),
                ]
        NetWorkTeacherGetTMyAllNotWork(params: param) { (datas,flag) in
            if flag {
                self.mainTableArr.addObjects(from: datas)
                self.mainTableView.reloadData()
            }
            
            self.mainTableView.mj_footer.endRefreshing()
        }
        
    }

    
    override func configSubViews() {
        
        self.navigationItem.title = "我的批改"
        mainTableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: kSCREEN_HEIGHT - 64 ), style: .plain)
        mainTableView.dataSource = self;
        mainTableView.delegate = self;
        mainTableView.estimatedRowHeight = 143 * kSCREEN_SCALE;
        mainTableView.tableFooterView = UIView()
        mainTableView.register(UINib(nibName: "TShowBooksCell", bundle: nil), forCellReuseIdentifier: identyfierTable)
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
        label.text = "暂时没有非练习册"
        emptyView.addSubview(label)
    }
    
    
    //MARK:  ******代理 ：UITableViewDataSource,UITableViewDelegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if mainTableArr.count == 0 {
            mainTableView.addSubview(emptyView)
        }else{
            emptyView.removeFromSuperview()
        }
        return mainTableArr.count
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let model = mainTableArr[indexPath.row] as! TNotWorkModel
        
        let cell : TShowBooksCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable, for: indexPath) as! TShowBooksCell
        cell.selectionStyle = .default
        cell.TShowBooksCellForMyCorrect(model: model)
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let model = mainTableArr[indexPath.row] as! TNotWorkModel

        
        let BookDetailVC = TDetailBookViewController()
//        BookDetailVC.model.comment = "fsdghjkl;:lkjhgnfbdsdfghjkl;/k.jh,gfdsfghjkl.,n时实打实大所大所撒发放阿萨法阿萨法阿斯达按时啊"
//        BookDetailVC.model.comment_next = "dfghjk"
//        BookDetailVC.model.corrected_error_photo = "dfghjk"
//        BookDetailVC.model.correcting_time = "2017-12-12"
//        BookDetailVC.model.photo = "dfghjk"
//        BookDetailVC.model.result = "werghtjykuli"
//        BookDetailVC.model.scores = "3"
//        BookDetailVC.model.scores_next = "5"
//        BookDetailVC.model.state = "\(indexPath.row%6+2)"
//        BookDetailVC.model.teacher_name = "搜索到"
//        BookDetailVC.model.user_name = "Michigan"
//        BookDetailVC.model.user_num = "008"
//        BookDetailVC.model.user_photo = "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1511315485&di=721c22ab84cb171b4f5c8293c99c2ca8&imgtype=jpg&er=1&src=http%3A%2F%2Fwww.feizl.com%2Fupload2007%2F2015_07%2F1507241542922222.jpg"
        BookDetailVC.model1 = model
        BookDetailVC.sendBackBlock = {
            self.refreshHeaderAction()
        }
        self.navigationController?.pushViewController(BookDetailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return false
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            mainTableArr.removeObject(at: indexPath.row)
            tableView.reloadData()
            deBugPrint(item: "删除了---\(indexPath.section)分区-\(indexPath.row)行")
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        
        return "删除此作业"
    }
    
    
    //MARK:  UISearchBarDelegate
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        
        let searchVC = SearchBooksViewController()
        
        self.navigationController?.pushViewController(searchVC, animated: true)
        
        return true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
}


