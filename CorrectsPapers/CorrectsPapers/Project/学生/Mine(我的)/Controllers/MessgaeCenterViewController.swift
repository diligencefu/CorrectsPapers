//
//  MessgaeCenterViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/17.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class MessgaeCenterViewController: BaseViewController {

    var pageNum = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addFooterRefresh()
     }
 
    
    override func requestData() {
        let params =
            [
                "SESSIONID":"1",
                "mobileCode":"on",
                "pageNo":pageNum
                ] as [String : Any]

        netWorkForGetMessages(params: params) { (datas) in
            self.mainTableArr.removeAllObjects()
            self.mainTableArr.addObjects(from: datas)
            self.mainTableView.reloadData()

        }
    }
    
    override func refreshFooterAction() {
        pageNum = pageNum+1
        let params =
            [
                "SESSIONID":"1",
                "mobileCode":"on",
                "pageNo":pageNum
                ] as [String : Any]
        
        netWorkForGetMessages(params: params) { (datas) in
            self.mainTableArr.addObjects(from: datas)
            self.mainTableView.reloadData()
        }
    }
    
    
    
    override func configSubViews() {
        
        self.navigationItem.title = "消息中心"

        
        mainTableView = UITableView.init(frame: CGRect(x: 0,
                                                       y: 0,
                                                       width: kSCREEN_WIDTH,
                                                       height: kSCREEN_HEIGHT - 64 ),
                                         style: .plain)
        mainTableView.dataSource = self;
        mainTableView.delegate = self;
        mainTableView.estimatedRowHeight = 44
        mainTableView.register(UINib(nibName: "MessgesCell", bundle: nil), forCellReuseIdentifier: identyfierTable)
        self.view.addSubview(mainTableView)
        mainTableView.backgroundColor = kSetRGBColor(r: 239, g: 239, b: 244)
        mainTableView.tableFooterView = UIView()
    }
    
    
    //    ******************代理 ： UITableViewDataSource,UITableViewDelegate  ************
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if mainTableArr.count == 0 {
//            mainTableView.mj_footer.endRefreshingWithNoMoreData()
//        }
        
        return  mainTableArr.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = mainTableArr[indexPath.row] as! MessageModel
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identyfierTable, for: indexPath) as! MessgesCell
        cell.setValueMessgesCell(model:model)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}
