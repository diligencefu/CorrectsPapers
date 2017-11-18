//
//  NotWorkViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/16.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class NotWorkViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rightBarButton()
    }
    
    override func requestData() {
//        let dic = ["SESSIONID":SESSIONID,"mobileCode":mobileCode]

    }
    
    override func leftBarButton() {
        
    }
    
    override func configSubViews() {
        
        self.navigationItem.title = "非练习册"
        
        mainTableArr =  ["","","","","","",""]
        
        mainTableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: kSCREEN_HEIGHT - 64 ), style: .plain)
        mainTableView.dataSource = self;
        mainTableView.delegate = self;
        mainTableView.estimatedRowHeight = 143 * kSCREEN_SCALE;
        mainTableView.register(UINib(nibName: "NotWorkCellCell", bundle: nil), forCellReuseIdentifier: identyfierTable)
        self.view.addSubview(mainTableView)
        
    }
    
    //    右键
    func rightBarButton() {
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: #imageLiteral(resourceName: "book_icon_default"), style: .plain, target: self, action: #selector(createNotWork(sender:)))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
    }
    
    @objc func createNotWork(sender:UIBarButtonItem) {

        let bookVc = CreateNotWorkViewController()
        self.navigationController?.pushViewController(bookVc, animated: true)
    }
    
    //MARK:  ******代理 ：UITableViewDataSource,UITableViewDelegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 20
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : NotWorkCellCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable, for: indexPath) as! NotWorkCellCell
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailVC = NotWorkDetailViewController()
        detailVC.state = indexPath.row%6+2
        self.navigationController?.pushViewController(detailVC, animated: true)
    }

}
