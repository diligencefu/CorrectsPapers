//
//  TGetAccountViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/18.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class TGetAccountViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func requestData() {
        
        self.view.beginLoading()
        netWorkForMyCoin { (datas,flag) in
            if flag {
                self.mainTableArr.removeAllObjects()
                self.mainTableArr.addObjects(from: datas)
                self.mainTableView.reloadData()
            }
            self.view.endLoading()
        }
    }
    
    
    override func refreshHeaderAction() {
        self.view.beginLoading()
        netWorkForMyCoin { (datas,flag) in
            if flag {
                self.mainTableArr.removeAllObjects()
                self.mainTableArr.addObjects(from: datas)
                self.mainTableView.mj_header.endRefreshing()
                self.mainTableView.reloadData()
            }
            self.view.endLoading()
        }
    }
    
    
    override func configSubViews() {
        
        self.navigationItem.title = "我的学币"
        
        let headView = UINib(nibName:"IncomeHeadView",bundle:nil).instantiate(withOwner: self, options: nil).first as! IncomeHeadView
        headView.frame =  CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 685)
        
        
        mainTableView = UITableView.init(frame: CGRect(x: 0,
                                                       y: -500,
                                                       width: kSCREEN_WIDTH,
                                                       height: kSCREEN_HEIGHT - 64 + 500 ),
                                         style: .grouped)
        mainTableView.dataSource = self;
        mainTableView.delegate = self;
        mainTableView.estimatedRowHeight = 44
        mainTableView.register(UINib(nibName: "IncomeCell", bundle: nil), forCellReuseIdentifier: identyfierTable)
        mainTableView.tableHeaderView = headView
        self.view.addSubview(mainTableView)
        mainTableView.backgroundColor = kSetRGBColor(r: 239, g: 239, b: 244)
        
    }
    
    //    ******************代理 ： UITableViewDataSource,UITableViewDelegate  ************
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  mainTableArr.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = mainTableArr[indexPath.row] as! AccountModel
        let cell = tableView.dequeueReusableCell(withIdentifier: identyfierTable, for: indexPath) as! IncomeCell
        cell.setValuesForIncomeCell(model: model)
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }

}
