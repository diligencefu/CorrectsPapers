//
//  WorkBookViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/10.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class WorkBookViewController: BaseViewController ,UISearchBarDelegate{

    var emptyView = UIView()
    var searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        rightBarButton()
    }
    
    override func leftBarButton() {
        
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
        
        mainTableArr =  ["最近天气真的好热呀，出门就像","Swift 中随机数的使用总结在我们开发的过程中，时不时地需要产生一些随机数。这里我们总结一下Swift中常用的一些随机数生成函数。这里我们将在Playground中来做些示例演示。","在我们开发的过程中，时不时地需要产生一些随机数。这里我们总结一下Swift中常用的一些随机数生成函数。这里我们将在Playground中来做些示例演示。整型随机数","在大部分应用中，上","这个函数使用ARC4加密的随机数来填充该函数第二个参数指定的长度的缓存区域。因此，如果我们传入的是sizeof(UInt64)，该函数便会生成一个随机数来填充8个字节的区域，并返回给r。那么64位的随机数生成方法便可以如下实现：","其实如果翻看一下Swift中关于C函数的API，发现还有许多跟随机数相关的函数，如arc4random_addrandom，erand48等。上面的只是我们经常用到的一些函数，这几个函数基本上够用了。当然，不同场景有不同的需求，我们需要根据实际的需求来选择合适的函数。","在Swift中使用随机数 在我们的开发过程中,有时需要产生一些随机数.而Swift中并没有像JAVA中一样提供一个专门的Random类来集中的生成随机数. 在Swift中,提供了几个全局的函数来生...","大叔：这是因为我们国家经济宏观调控，第四代领导核心英明神武（没错他原词说的就是英明神武），房地产市场连带其他市场欣欣向荣，世界经济崩溃，唯独中国形势一片大好。。。。（五分钟新闻联播，还是番外版）","大三宿舍卫生不搞，把垃圾放在门口害我们整个宿舍被通报取消评奖评优资格。有时候门禁过了还不回宿舍，发消息问她回不回来永远是没有回复，回宿舍以后打开手电筒照醒我们所有人。夏天实在闷热睡不着觉，也因为她不能开窗透气，只要他发现，第二天肯定会说自己感冒头疼，","一个好朋友吃饭她也要来，来就来咯"]
        
        mainTableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: kSCREEN_HEIGHT - 64 ), style: .plain)
        mainTableView.dataSource = self;
        mainTableView.delegate = self;
        mainTableView.estimatedRowHeight = 143 * kSCREEN_SCALE;
        mainTableView.register(UINib(nibName: "WorkBookCell", bundle: nil), forCellReuseIdentifier: identyfierTable)
        mainTableView.tableHeaderView = searchBar
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
//        creatBook.addTarget(self, action: #selector(createBookAction(sender:)), for: .touchUpInside)
        emptyView.addSubview(creatBook)
        
        self.mainTableView.addSubview(emptyView)
        
    }


//MARK:  ******代理 ：UITableViewDataSource,UITableViewDelegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if mainTableArr.count == 0 {
            addImageWhenEmpty()
        }else{
            emptyView.removeFromSuperview()
        }

        return mainTableArr.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : WorkBookCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable, for: indexPath) as! WorkBookCell
        cell.selectionStyle = .default
        cell.workBookCellSetValue(index:indexPath.row)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchBar.endEditing(true)
        tableView.deselectRow(at: indexPath, animated: true)
        
        let BookDetailVC = BookDetailViewController()
        BookDetailVC.workState = indexPath.row % 6
        self.navigationController?.pushViewController(BookDetailVC, animated: true)
        searchBar.resignFirstResponder()
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
