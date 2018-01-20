//
//  MessgaeCenterViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/17.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class MessgaeCenterViewController: BaseViewController {

    var pageNum = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        addFooterRefresh()
        rightBarButton()
     }
 
    
    override func requestData() {
        let params =
            [
                "SESSIONID":Defaults[userToken]!,
                "mobileCode":mobileCode,
                ] as [String : Any]
        self.view.beginLoading()
        
        if Defaults[userIdentity] == kTeacher {
            netWorkForGetMessages(params: params) { (datas,flag) in
                
                if flag {
                    self.mainTableArr.removeAllObjects()
                    self.mainTableArr.addObjects(from: datas)
                    self.mainTableView.reloadData()
                }
                self.view.endLoading()
                self.mainTableView.mj_header.endRefreshing()
            }

        }else{
            NetWorkStudentGetMsgBystudent(params: params) { (datas,flag) in
                
                if flag {
                    self.mainTableArr.removeAllObjects()
                    self.mainTableArr.addObjects(from: datas)
                    self.mainTableView.reloadData()
                }
                self.mainTableView.mj_header.endRefreshing()
                self.view.endLoading()
            }
        }
    }
    
    override func refreshHeaderAction() {
        requestData()
    }
    
    
    func rightBarButton() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: #imageLiteral(resourceName: "empty_icon_default"), style: .plain, target: self, action: #selector(pushToSetting(sender:)))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        
    }
    
    @objc func pushToSetting(sender:UIBarButtonItem) {
        
        
        let alert = UIAlertController.init(title: "提示", message: "确定清空所有通知消息？", preferredStyle: .alert)
        
        let action1 = UIAlertAction.init(title: "确定", style: .destructive) { (alertAction) in
            let params =
                [
                    "SESSIONID":Defaults[userToken]!,
                    "mobileCode":Defaults[mCode]!,
                    "state":"2",
                    ] as [String : Any]
            NetWorkTeachersDelMsgTeacher(params: params) { (flag) in
                if flag {
                    self.requestData()
                }
            }
        }
        
        let action2 = UIAlertAction.init(title: "取消", style: .cancel, handler: nil)
        alert.addAction(action1)
        alert.addAction(action2)
        
        self.present(alert, animated: true, completion: nil)
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
        
        return  mainTableArr.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = mainTableArr[indexPath.row] as! SMessageModel
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identyfierTable, for: indexPath) as! MessgesCell
        if Defaults[userIdentity] == kTeacher {
            cell.setValueMessgesCell(model:model)
        }else{
            cell.setValueMessgesCellTeacher(model:model)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let model = mainTableArr[indexPath.row] as! SMessageModel

        let msgVC = SystemMsgViewController()
        msgVC.model = model
        self.navigationController?.pushViewController(msgVC, animated: true)

    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let model = mainTableArr[indexPath.row] as! SMessageModel
        
        if editingStyle == .delete {
            let params =
                [
                    "SESSIONID":Defaults[userToken]!,
                    "mobileCode":mobileCode,
                    "msgId":model.msgId,
                    "state":"1",
                    "type":model.type
                    ] as [String : Any]
            NetWorkTeachersDelMsgTeacher(params: params) { (flag) in
                if flag {
                    self.requestData()
                }
            }

        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        
        return "删除"
    }

    
    override func viewWillAppear(_ animated: Bool) {
        self.requestData()
    }
    
}
