//
//  TLNChooseTypeViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2018/1/11.
//  Copyright © 2018年 Fu Yaohui. All rights reserved.
//

import UIKit

class TLNChooseTypeViewController: BaseViewController {

    
    var tipTextField = UITextField()
    var content = UITextView()
    
    var selectArr = NSMutableArray()
    
    var class_id = "<#value#>"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func addHeaderRefresh() {
        
    }
    
    
    override func configSubViews() {
        
        self.navigationItem.title = "选择成员类型"
        
        mainTableArr = ["上课老师","助教老师","学生"]
        
        mainTableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: kSCREEN_HEIGHT - 64 ), style: .plain)
        mainTableView.dataSource = self;
        mainTableView.delegate = self;
        mainTableView.rowHeight = 42;
        mainTableView.register(UINib(nibName: "ComplaintCell", bundle: nil), forCellReuseIdentifier: identyfierTable)
        self.view.addSubview(mainTableView)
        
        mainTableView.tableFooterView = UIView()
    }
    
    //MARK:  ******代理 ：UITableViewDataSource,UITableViewDelegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainTableArr.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : ComplaintCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable, for: indexPath) as! ComplaintCell
        cell.selectionStyle = .default
        cell.accessoryType = .disclosureIndicator
        cell.chooseMemberType(title1: mainTableArr[indexPath.row] as! String)
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)

        let chooseVC = TChooseMemberViewController()
        chooseVC.class_id = class_id
        if indexPath.row == 2 {
            chooseVC.type = "2"
            chooseVC.state = "0"
            chooseVC.action = "选择添加学生"
        }else{
            chooseVC.type = "1"
            if indexPath.row == 0 {
                chooseVC.state = "1"
                chooseVC.action = "选择添加上课老师"
            }else{
                chooseVC.action = "选择添加助教老师"
                chooseVC.state = "2"
            }
        }
        self.navigationController?.pushViewController(chooseVC, animated: true)
    }

}
