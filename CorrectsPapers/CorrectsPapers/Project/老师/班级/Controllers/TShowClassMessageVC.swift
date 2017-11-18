//
//  TShowClassMessageVC.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/15.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class TShowClassMessageVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func requestData() {

    }
    
    override func configSubViews() {
        
        self.navigationItem.title = "信息通知"
        
        mainTableArr =  ["",""]
        
        mainTableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: kSCREEN_HEIGHT - 64 ), style: .plain)
        mainTableView.dataSource = self;
        mainTableView.delegate = self;
        mainTableView.estimatedRowHeight = 143 * kSCREEN_SCALE;
        mainTableView.register(UINib(nibName: "TClassMessageCell", bundle: nil), forCellReuseIdentifier: identyfierTable)
        mainTableView.separatorStyle = .none
        self.view.addSubview(mainTableView)
    }
    
    
    //MARK:  ******代理 ：UITableViewDataSource,UITableViewDelegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return mainTableArr.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : TClassMessageCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable, for: indexPath) as! TClassMessageCell
        cell.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = UIView()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
