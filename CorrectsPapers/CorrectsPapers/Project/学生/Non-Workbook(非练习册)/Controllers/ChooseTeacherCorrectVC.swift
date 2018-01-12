//
//  ChooseTeacherCorrectVC.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/10.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class ChooseTeacherCorrectVC: BaseViewController {

    var selectArr = [String]()
    var teachers = [ApplyModel]()
    var chooseMemberBlock:((ApplyModel)->())?  //声明闭包
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        rightBarButton()
    }
    
    override func requestData() {
        netWorkForMyFriend { (datas, success) in
            
            deBugPrint(item: datas)
            for index in 0..<datas.count {
                
                let model = datas[index] as! ApplyModel
                if model.user_type != "1" {
                    self.teachers.append(model)
                }
            }
            self.mainTableView.reloadData()
        }
    }
    
    
    override func configSubViews() {
        
        self.navigationItem.title = "选择老师"
        
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
        
//        if chooseMemberBlock != nil {
//            chooseMemberBlock!(selectArr)
//        }
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:  ******代理 ：UITableViewDataSource,UITableViewDelegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return teachers.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = teachers[indexPath.section]
        let cell : ShowFridensCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable, for: indexPath) as! ShowFridensCell
        cell.selectionStyle = .default
        cell.ShowFridensCellForShowFriend(model: model)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let model = teachers[indexPath.section]
        if chooseMemberBlock != nil {
            chooseMemberBlock!(model)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
}
