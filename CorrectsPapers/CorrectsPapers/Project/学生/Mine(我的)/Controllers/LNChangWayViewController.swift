//
//  LNChangWayViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2018/1/16.
//  Copyright © 2018年 Fu Yaohui. All rights reserved.
//

import UIKit

class LNChangWayViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func addHeaderRefresh() {
        
    }
    
    
    override func configSubViews() {
        
        self.navigationItem.title = "更改密码"
        
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
        mainTableView.tableFooterView = UIView.init()
        mainTableArr = ["我记得旧密码","我忘了旧密码"]
        
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
        cell.showForCreateBook(isShow: false, title: mainTableArr[indexPath.row] as! String, subTitle: "")
        if indexPath.row == 2 {
            cell.selectionStyle = .none
        }
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            let aboutVC = LNChangePassWordVC()
            self.navigationController?.pushViewController(aboutVC, animated: true)
        }
        
        if indexPath.row == 1 {
            let aboutVC = LNSetPswViewController()
            aboutVC.isChange = true
            self.navigationController?.pushViewController(aboutVC, animated: true)
        }
    }
    
    
}
