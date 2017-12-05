//
//  ChooseMemberViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/21.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class TChooseMemberViewController: BaseViewController {

    var selectArr = [String]()
    
    var chooseMemberBlock:((Array<String>)->())?  //声明闭包

    override func viewDidLoad() {
        super.viewDidLoad()
        
        rightBarButton()
    }
    
    override func configSubViews() {
        
        self.navigationItem.title = "选择成员"
        
        mainTableArr =  ["","","","","","",""]
        
        mainTableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: kSCREEN_HEIGHT - 64 ), style: .plain)
        mainTableView.dataSource = self;
        mainTableView.delegate = self;
        mainTableView.estimatedRowHeight = 143 * kSCREEN_SCALE;
        mainTableView.register(UINib(nibName: "ShowFridensCell", bundle: nil), forCellReuseIdentifier: identyfierTable)
        self.view.addSubview(mainTableView)
        
    }
    
    //    右键
    func rightBarButton() {
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "完成", style: .plain, target: self, action: #selector(selectDone(sender:)))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white

    }
    
    @objc func selectDone(sender:UIBarButtonItem) {
        
        if chooseMemberBlock != nil {
            chooseMemberBlock!(selectArr)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:  ******代理 ：UITableViewDataSource,UITableViewDelegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return mainTableArr.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : ShowFridensCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable, for: indexPath) as! ShowFridensCell
        cell.selectionStyle = .default
//        cell.ShowFridensCellForShowFriend(model: <#ApplyModel#>)
        
        if selectArr.contains(String(indexPath.row)) {
            cell.accessoryType = .checkmark
        }else{
             cell.accessoryType = .none
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        
        if selectArr.contains(String(indexPath.row)) {
            selectArr.remove(at: selectArr.index(of: String(indexPath.row))!)
        }else{
            selectArr.append(String(indexPath.row))
        }
        tableView.reloadData()
        
        if selectArr.count == 4 {
            selectArr.remove(at: 0)
        }

    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
}


