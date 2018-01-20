//
//  TBookViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/20.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class TBookViewController: BaseViewController {

    var emptyView = UIView()
    var searchBar = UISearchBar()
//    添加练习册的id
    var book_id = ""
    var index = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        rightBarButton()
        addImageWhenEmpty()
//        addFooterRefresh()
        addTipView()
        //        接收创建练习册成功的通知
        NotificationCenter.default.addObserver(self, selector: #selector(receiveNitification(nitofication:)), name: NSNotification.Name(rawValue: SuccessRefreshNotificationCenter), object: nil)
    }
    
    @objc func receiveNitification(nitofication:Notification) {
        self.mainTableView.mj_header.beginRefreshing()
    }
    

    override func leftBarButton() {
        
    }
    
    
    override func refreshFooterAction() {
        self.mainTableView.mj_footer.endRefreshing() 
    }
    
    
    override func requestData() {
        
        let params =
            ["SESSIONID":Defaults[userToken]!,
             "mobileCode":mobileCode,
             ]
        self.view.beginLoading()
        NetWorkTeacherGetTAllWorkList(params: params) { (datas,flag) in
            if flag {
                self.mainTableArr.removeAllObjects()
                self.mainTableArr.addObjects(from: datas)
                self.mainTableView.reloadData()
            }
            self.view.endLoading()
        }
    }
    
    
    override func refreshHeaderAction() {
        
        let params =
            ["SESSIONID":Defaults[userToken]!,
             "mobileCode":mobileCode,
             ]
        NetWorkTeacherGetTAllWorkList(params: params) { (datas,flag) in
            
            if flag {
                self.mainTableArr.removeAllObjects()
                self.mainTableArr.addObjects(from: datas)
                self.mainTableView.reloadData()
            }
            self.mainTableView.mj_header.endRefreshing()
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
        
        mainTableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: kSCREEN_HEIGHT - 64 ), style: .plain)
        mainTableView.dataSource = self;
        mainTableView.delegate = self;
        mainTableView.estimatedRowHeight = 143 * kSCREEN_SCALE;
        mainTableView.register(UINib(nibName: "TShowBookCell", bundle: nil), forCellReuseIdentifier: identyfierTable)
        mainTableView.tableHeaderView = searchBar
        mainTableView.tableFooterView = UIView()
        self.view.addSubview(mainTableView)
        
    }
    
    
    @objc func pushToSearchBook(sender:UIBarButtonItem) {
        let searchVC = TSearchBookViewController()
        //        searchVC.style
        self.navigationController?.pushViewController(searchVC, animated: true)
    }
    
    //    右键
    func rightBarButton() {
        
        let createClass = UIBarButtonItem.init(image:#imageLiteral(resourceName: "create-class_icon"), style: .plain, target: self, action: #selector(pushToMyBook(sender:)))
        createClass.tag = 10086
        
        let searchClass = UIBarButtonItem.init(image: #imageLiteral(resourceName: "MyBook_icon_default"), style: .plain, target: self, action: #selector(pushToMyBook(sender:)))
        searchClass.tag = 10068
        
        self.navigationItem.rightBarButtonItems = [searchClass,createClass,]
    }
    
    
    @objc func pushToMyBook(sender:UIBarButtonItem) {
        
        if sender.tag != 10086 {
            let myBook = TMyBookViewController()
            self.navigationController?.pushViewController(myBook, animated: true)
        }else{
            let myBook = CreateBookViewController()
            self.navigationController?.pushViewController(myBook, animated: true)
        }
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
        
        let creatBook = UIButton.init(frame: CGRect(x: 0, y: 0, width: 120, height: 30))
        creatBook.setBackgroundImage(getNavigationIMG(27, fromColor: kSetRGBColor(r: 0, g: 200, b: 255), toColor: kSetRGBColor(r: 0, g: 162, b: 255)), for: .normal)
        creatBook.center = CGPoint(x: emptyView.centerX, y: emptyView.centerY + 10 * kSCREEN_SCALE)
        creatBook.setTitle("创建练习册", for: .normal)
        creatBook.layer.cornerRadius = 5
        creatBook.clipsToBounds = true
                creatBook.addTarget(self, action: #selector(createBookAction(sender:)), for: .touchUpInside)
        emptyView.addSubview(creatBook)
    }
    
    
    @objc func createBookAction(sender:UIButton) {
        let createBook = CreateBookViewController()
        self.navigationController?.pushViewController(createBook, animated: true)
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
        let cell : TShowBookCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable, for: indexPath) as! TShowBookCell
        cell.selectionStyle = .default
        cell.addWorkBlock = {
            self.book_id = model.id!
            self.index = indexPath.row
            self.showTheTipView()
        }
        cell.selectionStyle = .none
        cell.TShowBookCellSetValue(model:model)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchBar.endEditing(true)
        tableView.deselectRow(at: indexPath, animated: true)
                
//        缺少参数，暂时关闭
//        let model = mainTableArr[indexPath.row] as! WorkBookModel
//
//        let BookDetailVC = TBookDetailViewController()
//        BookDetailVC.book_id = model.id!
//        self.navigationController?.pushViewController(BookDetailVC, animated: true)
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
            deBugPrint(item: "删除了---\(indexPath.section)分区-\(indexPath.row)行")
        }
    }
    
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        
        return "删除练习册"
    }
    
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        searchBar.endEditing(true)
    }
    
    
    var tipView = TShowTheTipView()
    var BGView = UIView()

    func addTipView()  {
        //        弹出视图弹出来之后的背景蒙层
        BGView = UIView.init(frame: self.view.frame)
        BGView.backgroundColor = kSetRGBAColor(r: 5, g: 5, b: 5, a: 0.5)
        BGView.alpha = 0
        let tapGes1 = UITapGestureRecognizer.init(target: self, action: #selector(showChooseCondi(tap:)))
        tapGes1.numberOfTouchesRequired = 1
        BGView.addGestureRecognizer(tapGes1)
        self.view.addSubview(BGView)
        
        tipView = UINib(nibName:"TShowTheTipView",bundle:nil).instantiate(withOwner: self, options: nil).first as! TShowTheTipView
        tipView.frame =  CGRect(x: 30*kSCREEN_SCALE, y: kSCREEN_HEIGHT/2-130-30, width: kSCREEN_WIDTH-60*kSCREEN_SCALE, height: 550*kSCREEN_SCALE)
        tipView.layer.cornerRadius = 24*kSCREEN_SCALE
        
        self.tipView.isHidden = true

        tipView.chooseBlock = {
            if !$0 {
                let params =
                    ["SESSIONID":Defaults[userToken]!,
                     "mobileCode":Defaults[mCode]!,
                     "workId":self.book_id,
                ] as [String:Any]

                NetWorkTeacherAddMyWork(params: params, callBack: { (flag) in
                    
                    if flag {
                        self.mainTableArr.removeObject(at: self.index)
                        self.mainTableView.reloadData()
                    }
                    
                })
                
            }
            self.hiddenViews()
        }
        
        tipView.clipsToBounds = true
        self.view.addSubview(tipView)
    }
    
    
    @objc func showChooseCondi(tap:UITapGestureRecognizer) -> Void {
        
//        if tap.view?.alpha == 1 {
//            UIView.animate(withDuration: 0.5) {
//                tap.view?.alpha = 0
//                self.tipView.isHidden = true
//            }
//        }
    }
    
    
    func hiddenViews() {
        
        UIView.animate(withDuration: 0.5) {
            self.BGView.alpha = 0
            self.tipView.isHidden = true
        }
    }
    
    
    func showTheTipView() -> Void {
        UIView.animate(withDuration: 0.5) {
            self.tipView.isHidden = false
            self.BGView.alpha = 1
        }
    }
    
    
    @objc func certainCorrect() {
        
    }

}

