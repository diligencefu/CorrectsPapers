//
//  ComplaintRecordViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/17.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class ComplaintRecordViewController: BaseViewController {

    //    记录分组状态
    var stateArr = Array<String>()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "被投诉记录"
    }
    
    override func requestData() {
        NetWorkTeacherGetComplaintRecord { (datas) in
            self.mainTableArr.removeAllObjects()
            self.mainTableArr.addObjects(from: datas)
            self.mainTableView.reloadData()
        }
    }
    
    
    //    布局
    override func configSubViews() {
        //    记录当前每个分组的状态0关闭，1打开
        stateArr.removeAll()
        for _ in 0..<20 {
            stateArr.append("0")
        }
        
        mainTableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: kSCREEN_HEIGHT-64), style: .plain)
        
        mainTableView.dataSource = self
        mainTableView.delegate = self
        
        mainTableView.estimatedRowHeight = 40
        mainTableView.tableFooterView = UIView()
        self.view.addSubview(mainTableView)
        mainTableView.register(UINib(nibName: "ComplaintDetailcell", bundle: nil), forCellReuseIdentifier: identyfierTable1)
        mainTableView.register(UINib(nibName: "ComplaintRecordCell", bundle: nil), forCellReuseIdentifier: identyfierTable)
    }
    
    //  MARK:  tableViewDelegate and Datasource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return mainTableArr.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let model = mainTableArr[section] as! TComplaintModel
        
        if stateArr[section] == "1" {
            // 如果是展开状态
            return model.coms.count+1
        }else{
            // 闭合状态
            return 1
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = mainTableArr[indexPath.section] as! TComplaintModel
        if indexPath.row == 0 {
            //每个分区的第一行是群名
            let cell : ComplaintRecordCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable, for: indexPath) as! ComplaintRecordCell
            
            // 根据状态数组中的记录来确定图标
            if stateArr[indexPath.section] == "1" {
                
                cell.changeState(model: model, isOn: true)
            }else{
                
                cell.changeState(model: model, isOn: false)
            }
            cell.selectedBackgroundView = UIView.init()
            return cell
        }else{
            
            let cell : ComplaintDetailcell = tableView.dequeueReusableCell(withIdentifier: identyfierTable1, for: indexPath) as! ComplaintDetailcell
            cell.showTheDetail(model: model.coms[indexPath.row-1])
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 10
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //        点击每一个分区的第一个cell，是在开关分组
        if indexPath.row == 0 {
            
            if stateArr[indexPath.section] == "1" {
                stateArr[indexPath.section] = "0"
            }else{
                stateArr[indexPath.section] = "1"
            }
            
            self.mainTableView.reloadSections(IndexSet.init(integer: indexPath.section), with: .automatic)
        }
    }
}
