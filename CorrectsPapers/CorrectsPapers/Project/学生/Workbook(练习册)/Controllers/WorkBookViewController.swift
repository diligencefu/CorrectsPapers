//
//  WorkBookViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/10.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import MJRefresh

class WorkBookViewController: BaseViewController ,UISearchBarDelegate{

    var emptyView = UIView()
    var searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addImageWhenEmpty()
        rightBarButton()
    }
    
    override func leftBarButton() {
        
    }
    
    override func requestData() {
        
        netWorkForGetAllWorkBook { (dataArr) in

            print(dataArr)
            if dataArr.count > 0 {
                
                self.mainTableArr.addObjects(from: dataArr)
                self.mainTableView.reloadData()

            }else{
                setToast(str: "返回数据为空")
            }
        }
    }
    
    override func refreshHeaderAction() {
    
        netWorkForGetAllWorkBook { (dataArr) in
            self.mainTableArr.removeAllObjects()
            self.mainTableView.mj_header.endRefreshing()
            print(dataArr)
            
            if dataArr.count > 0 {
                
                self.mainTableArr.addObjects(from: dataArr)
                self.mainTableView.reloadData()
            }else{
                setToast(str: "返回数据为空")
            }
        }
    }
    
    
    override func configSubViews() {
        
        self.navigationItem.title = "练习册作业"
        
        
        //        顶部搜索栏
        searchBar = UISearchBar.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 50 ))
        searchBar.placeholder="搜索"
        searchBar.barStyle = .default
        searchBar.showsCancelButton=false
        searchBar.showsSearchResultsButton=false
        searchBar.delegate=self
        searchBar.backgroundColor = UIColor.white
        searchBar.placeholder = "创优100分/黄冈密卷"
        searchBar.subviews[0].subviews[0].removeFromSuperview()
        searchBar.barTintColor = UIColor.red
        searchBar.tintColor = UIColor.black
        
//        for view:UIView in searchBar.subviews[0].subviews {
//
//            print(view.superclass ?? "nimabi")
//
////            if view.superclass = searchbarb {
////                view.removeFromSuperview()
////            }
//
//        }
        
//        let searchView = UITextField.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 50))
//        searchView.backgroundColor = kGaryColor(num: 239)
//        searchView.placeholder = "创优100分/黄冈密卷"
        
        let searchBtn = UIButton.init(frame: CGRect(x: 10, y: 10, width: kSCREEN_WIDTH - 20, height: 30))
        searchBtn.center = searchBar.center
        searchBtn.layer.cornerRadius = 3
        searchBtn.clipsToBounds = true
        searchBtn.setTitle("创优100分/黄冈密卷", for: .normal)
        searchBtn.titleLabel?.font = kFont26
        searchBtn.setImage(#imageLiteral(resourceName: "search_icon_default"), for: .normal)
        searchBtn.setTitleColor(kGaryColor(num: 188), for: .normal)
        searchBtn.backgroundColor = kGaryColor(num: 239)
        searchBtn.addTarget(self, action: #selector(pushToSearchBook(sender:)), for: .touchUpInside)
        searchBar.addSubview(searchBtn)
        
//        self.navigationController?.navigationItem.titleView = searchBar
        
        mainTableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: kSCREEN_HEIGHT - 64 ), style: .plain)
        mainTableView.dataSource = self
        mainTableView.delegate = self
        mainTableView.estimatedRowHeight = 143 * kSCREEN_SCALE
        mainTableView.register(UINib(nibName: "WorkBookCell", bundle: nil), forCellReuseIdentifier: identyfierTable)
        mainTableView.tableHeaderView = searchBar
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
        
        let myBook = MyBookViewController()
        
        self.navigationController?.pushViewController(myBook, animated: true)
    }
    
    
//    当数据为空的时候，显示提示
    
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
        
        let cell : WorkBookCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable, for: indexPath) as! WorkBookCell
        cell.selectionStyle = .default
        cell.workBookCellSetValue(model: model)
        
        cell.addWorkBookBlock = {
            print($0)
            //MARK:添加练习册
            let params =
                ["SESSIONID":SESSIONID,
                 "mobileCode":mobileCode,
                 "workBookId":model.work_book_Id
            ]
            
            netWorkForAddWorkBookToMe(params: params, callBack: { (flag) in
                
                if flag {
                    
                }
                
            })
            
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchBar.endEditing(true)
        tableView.deselectRow(at: indexPath, animated: true)
        let model = mainTableArr[indexPath.row] as! WorkBookModel
        let BookDetailVC = BookDetailViewController()
        BookDetailVC.model = model
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
                    "workBookId":model.work_book_Id,
                    "SESSIONID":SESSIONID,
                    "mobileCode":mobileCode
            ]
            
            netWorkForDeleteMyWorkBook(params: params, callBack: { (done) in
                
                if done == "done" {
                    self.mainTableArr.remove(model)
                    tableView.reloadData()
                    print("删除了---\(indexPath.section)分区-\(indexPath.row)行")

                }else{
                     print("删除失败")
                }

            })
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        
        return "删除练习册"
    }

    
//MARK:  UISearchBarDelegate
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        
        let searchVC = SearchBooksViewController()
        
        self.navigationController?.pushViewController(searchVC, animated: true)
        
        return true
    }
    
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        searchBar.endEditing(true)
    }
    
}
