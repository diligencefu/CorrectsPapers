//
//  TShowOneGradeVCViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/14.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class TShowOneGradeVCViewController: BaseViewController {

    
    var user_num = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func requestData() {
        
        let params =
            ["SESSIONID":SESSIONIDT,
             "mobileCode":mobileCodeT,
             "studentId":user_num
        ]
        NetWorkTeacherGetTScoresByStudentId(params: params) { (datas) in
            self.mainTableArr.removeAllObjects()
            
            if datas.count == 0 {
                setToast(str: "暂无数据")
            }
            
            self.mainTableArr.addObjects(from: datas)
            self.mainTableView.reloadData()
        }
    }
    
    override func configSubViews() {
        
        self.navigationItem.title = "刘大锤"
        
        mainTableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: kSCREEN_HEIGHT - 64 ), style: .plain)
        mainTableView.dataSource = self;
        mainTableView.delegate = self;
        mainTableView.estimatedRowHeight = 143 * kSCREEN_SCALE;
        mainTableView.register(UINib(nibName: "ClassGradeCell", bundle: nil), forCellReuseIdentifier: identyfierTable)
        mainTableView.tableFooterView = UIView()
        self.view.addSubview(mainTableView)
    }
    
    
    //MARK:  ******代理 ：UITableViewDataSource,UITableViewDelegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return mainTableArr.count+1
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : ClassGradeCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable, for: indexPath) as! ClassGradeCell
        
        if indexPath.row == 0 {
            cell.is1thCell()
        }else{
            let model = mainTableArr[indexPath.row-1] as! TShowGradeModel
            cell.setValueForBookGrade(model:model)
//            cell.setValueForClassGradeCell(index: 10-indexPath.row)

        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
