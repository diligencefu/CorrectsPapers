//
//  BaseViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/10.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import MJRefresh

class BaseViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
 
    var mainTableView = UITableView()
    //    数据源
    var mainTableArr = NSMutableArray()
    
    let identyfierTable  = "identyfierTable"
    let identyfierTable1 = "identyfierTable1"
    let identyfierTable2 = "identyfierTable2"
    let identyfierTable3 = "identyfierTable3"
    let identyfierTable4 = "identyfierTable4"
    let identyfierTable5 = "identyfierTable5"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configSubViews()
        mainTableView.backgroundColor = kSetRGBColor(r: 244, g: 244, b: 244)
        leftBarButton()
        self.navigationController?.navigationBar.isTranslucent = false
        self.view.backgroundColor = kBGColor()
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.black
        configNavigationBarMainColor()
        requestData()
        addHeaderRefresh()
    }
    
    func addHeaderRefresh()  {
        
        mainTableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            
            self.refreshHeaderAction()
        })

    }
    
    
    func refreshHeaderAction() {
        setToast(str: "刷新")
        mainTableView.mj_header.endRefreshing()
    }
    
    func addFooterRefresh() {
        mainTableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {

            self.refreshFooterAction()
        })
    }
    
    func refreshFooterAction() {
        setToast(str: "刷新")
        mainTableView.mj_header.endRefreshing()
    }

    
    //    每个导航控制器的第一个子控制器的导航栏都是 红色的
    func configNavigationBarMainColor() {
        self.navigationController?.navigationBar.setBackgroundImage(getNavigationIMG(64, fromColor: kSetRGBColor(r: 0, g: 200, b: 255), toColor: kSetRGBColor(r: 0, g: 160, b: 255)), for: .default)
        self.navigationItem.leftBarButtonItem?.tintColor = kSetRGBColor(r: 255, g: 255, b: 255)
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    //    后面的基本都是白色的
    func configNavigationBarSectionColor() {
        self.navigationController?.navigationBar.setBackgroundImage(getNavigationIMG(64, fromColor: UIColor.white, toColor: UIColor.white), for: .default)
        self.navigationItem.leftBarButtonItem?.tintColor = kSetRGBColor(r: 69, g: 69, b: 69)
        self.navigationItem.rightBarButtonItem?.tintColor = kMainColor()
        UIApplication.shared.statusBarStyle = .default
    }
    
    //    导航栏的标题是黑色的，在导航控制器写成了白色，但是有的控制器需要黑色，调用此方法，重写titleView
    func setupTitleViewSectionStyle(titleStr:String) {
        let titleView = UILabel.init(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        titleView.text = titleStr
        titleView.textAlignment = .center
        titleView.textColor = UIColor.black
        self.navigationItem.titleView = titleView
    }
    
    func configSubViews() -> Void {
        
        
    }
    
    
    func requestData() -> Void {
        
        
    }

    
    
//    back_icon_default
    //    重写返回键
    func leftBarButton() {
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: #imageLiteral(resourceName: "back_icon_default"), style: .done, target: self, action: #selector(backAction(sender:)))
        //        返回手势
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
        
    }
    
    //    返回事件
    @objc func backAction(sender:UIBarButtonItem) -> Void {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    //    ******************代理 ： UITableViewDataSource,UITableViewDelegate  ************
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
}
