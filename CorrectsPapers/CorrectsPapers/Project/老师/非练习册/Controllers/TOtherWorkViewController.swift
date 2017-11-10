//
//  TOtherWorkViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/20.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class TOtherWorkViewController: BaseViewController {
    var emptyView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rightBarButton()
    }
    
    override func leftBarButton() {
        
    }
    
    
    override func requestData() {
        
        NetWorkTeacherGetTMyAllNotWork { (datas) in
            self.mainTableArr.addObjects(from: datas)
            self.mainTableView.reloadData()
        }
    }
    
    override func refreshHeaderAction() {
        NetWorkTeacherGetTMyAllNotWork { (datas) in
            self.mainTableArr.removeAllObjects()
            self.mainTableArr.addObjects(from: datas)
            self.mainTableView.reloadData()
            self.mainTableView.mj_header.endRefreshing()
        }
    }

    
    override func configSubViews() {
        
        self.navigationItem.title = "非练习册"

        mainTableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: kSCREEN_HEIGHT - 64 ), style: .plain)
        mainTableView.dataSource = self;
        mainTableView.delegate = self;
        mainTableView.estimatedRowHeight = 143 * kSCREEN_SCALE;
        mainTableView.register(UINib(nibName: "TShowBooksCell", bundle: nil), forCellReuseIdentifier: identyfierTable)
        mainTableView.tableFooterView = UIView()
        self.view.addSubview(mainTableView)
        
    }
    
    
    @objc func pushToSearchBook(sender:UIBarButtonItem) {
        let searchVC = SearchBooksViewController()
        //        searchVC.style
        self.navigationController?.pushViewController(searchVC, animated: true)
        
        
    }
    //    右键
    func rightBarButton() {
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: #imageLiteral(resourceName: "book_icon_default"), style: .plain, target: self, action: #selector(pushToMyBook(sender:)))
    }
    
    @objc func pushToMyBook(sender:UIBarButtonItem) {
        
        let myBook = TMyBookViewController()
        
        self.navigationController?.pushViewController(myBook, animated: true)
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
            addImageWhenEmpty()
        }else{
            emptyView.removeFromSuperview()
        }
        
//        return mainTableArr.count
        return 1
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : TShowBooksCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable, for: indexPath) as! TShowBooksCell
        cell.selectionStyle = .default
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let BookDetailVC = TDetailBookViewController()
        BookDetailVC.workState = indexPath.row % 6
        self.navigationController?.pushViewController(BookDetailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            mainTableArr.removeObject(at: indexPath.row)
            tableView.reloadData()
            print("删除了---\(indexPath.section)分区-\(indexPath.row)行")
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

