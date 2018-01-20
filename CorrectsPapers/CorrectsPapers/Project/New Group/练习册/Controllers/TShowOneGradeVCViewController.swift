//
//  TShowOneGradeVCViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/14.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class TShowOneGradeVCViewController: BaseViewController {

    
    var user_num = ""
    var user_name = ""
    var classid = ""

    var type = 3
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func requestData() {
        
//        let params =
//            ["SESSIONID":SESSIONIDT,
//             "mobileCode":mobileCodeT,
//             "studentId":user_num
//        ]
//        self.view.beginLoading()
//        NetWorkTeacherGetTScoresByStudentId(params: params) { (datas,flag) in
//            self.mainTableArr.removeAllObjects()
//            self.view.endLoading()
//            if flag {
//                if datas.count == 0 {
//                    setToast(str: "暂无数据")
//                }
//
//                self.mainTableArr.addObjects(from: datas)
//                self.mainTableView.reloadData()
//
//            }
//        }
        
        
        var params11 = [String:Any]()
        
        if type == 3 {
            params11 = [
                "SESSIONID":Defaults[userToken]!,
                "mobileCode":mobileCode,
                "classes_id":classid,
                "student_id":user_num,
                "type":"3"
            ]
        }else{
            params11 = [
                "SESSIONID":Defaults[userToken]!,
                "student_id":user_num,
                "mobileCode":mobileCode,
                "type":"3"
            ]
        }
        
        
        NetWorkTeacherGetStudentScroes(params: params11) { (datas,flag) in
            
            if flag {
                self.mainTableArr.addObjects(from: datas)
                self.mainTableView.reloadData()
            }
            self.mainTableView.reloadData()
            self.view.endLoading()
        }
    }
    
    
    override func configSubViews() {
        
        self.navigationItem.title = user_name
        
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
            
            if classid == "" {
                cell.setValueForBookGrade(model:model)
            }else{
                cell.setValueForBookGradeClassDetailGrade(model:model)
            }            
            
//            cell.setValueForClassGradeCell(index: 10-indexPath.row)

        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
