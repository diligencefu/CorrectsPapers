//
//  SettingViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/16.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class SettingViewController: BaseViewController {

    var dataArr = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    override func addHeaderRefresh() {
        
    }
    
    
    override func configSubViews() {
        
        self.navigationItem.title = "设置"
        
        let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString")

        dataArr = ["","","170.3MB","V "+(version as! String)]
        
        mainTableView = UITableView.init(frame: CGRect(x: 0,
                                                       y: 0,
                                                       width: kSCREEN_WIDTH,
                                                       height: kSCREEN_HEIGHT - 64 ),
                                         style: .plain)
        mainTableView.dataSource = self;
        mainTableView.delegate = self;
        mainTableView.estimatedRowHeight = 44
        mainTableView.register(UINib(nibName: "CreateBookCell", bundle: nil), forCellReuseIdentifier: identyfierTable)
        self.view.addSubview(mainTableView)
        mainTableView.backgroundColor = kSetRGBColor(r: 239, g: 239, b: 244)
        mainTableArr = ["关于我们","设置支付密码","清除缓存","检查更新"]
        
        
        let footView = UIView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 400))
        footView.backgroundColor = UIColor.clear
        let logout = UIButton.init(frame: CGRect(x: 60 * kSCREEN_SCALE, y: 350, width: kSCREEN_WIDTH - 120 * kSCREEN_SCALE, height: 86 * kSCREEN_SCALE))
        logout.layer.cornerRadius = 10 * kSCREEN_SCALE
        logout.clipsToBounds = true
        logout.layer.borderColor = kSetRGBColor(r: 255, g: 153, b: 0).cgColor
        logout.layer.borderWidth = 1
        logout.setTitle("退出登录", for: .normal)
        logout.setTitleColor(kSetRGBColor(r: 255, g: 153, b: 0), for: .normal)
        logout.addTarget(self, action: #selector(logoutAction), for: .touchUpInside)
        footView.addSubview(logout)
        mainTableView.tableFooterView = footView
        
    }
    
    @objc func logoutAction() {
        Defaults[username] = nil
        Defaults[userToken] = nil
        Defaults[mCode] = nil
        Defaults[username] = nil
        Defaults[userArea] = nil
        Defaults[userId] = nil
        Defaults[userGrade] = nil
        Defaults[userAccount] = nil
        Defaults[HavePayPassword] = nil

       Defaults.removeAll()
        self.tabBarController?.present(XCNavigationController.init(rootViewController: LoginViewController()), animated: true, completion: nil)
    }
    
    
    //    ******************代理 ： UITableViewDataSource,UITableViewDelegate  ************
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  mainTableArr.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identyfierTable, for: indexPath) as! CreateBookCell
        
        cell.showForCreateBook(isShow: false, title: mainTableArr[indexPath.row] as! String, subTitle: dataArr[indexPath.row])
        
        if indexPath.row == 2 {
            cell.selectionStyle = .none
        }
        
        return cell
        
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            let aboutVC = AboutUsViewController()
            self.navigationController?.pushViewController(aboutVC, animated: true)
        }
        if indexPath.row == 1 {
            
            if Defaults[HavePayPassword] == "yes" {

            }
            let aboutVC = LNSetPswViewController()
            self.navigationController?.pushViewController(aboutVC, animated: true)
        }

    }
    
}
