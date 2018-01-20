//
//  ChooseMemberViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/21.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class TChooseMemberViewController: BaseViewController {

    var selectArr = [String]()
    
    var addMembers = [ApplyModel]()
    
    var class_id = ""
    var state = ""
    var type = ""
    
    var action = ""
    
    var chooseMemberBlock:((Array<ApplyModel>)->())?  //声明闭包

    override func viewDidLoad() {
        super.viewDidLoad()
        rightBarButton()
        addImageWhenEmpty()
    }
    
    
    override func configSubViews() {
        
        self.navigationItem.title = action
        
        mainTableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: kSCREEN_HEIGHT - 64 ), style: .plain)
        mainTableView.dataSource = self;
        mainTableView.delegate = self;
        mainTableView.estimatedRowHeight = 143 * kSCREEN_SCALE;
        mainTableView.register(UINib(nibName: "ShowFridensCell", bundle: nil), forCellReuseIdentifier: identyfierTable)
        self.view.addSubview(mainTableView)
        mainTableView.tableFooterView = UIView()

    }
    
    override func addHeaderRefresh() {
        
    }
    
    
    override func requestData() {
        
        
        if class_id.count>0 {
            let params = [
                "SESSIONID":Defaults[userToken]!,
                "mobileCode":mobileCode,
                "class_id":class_id,
                "type":type,
                ]
            self.view.beginLoading()
            NetWorkForInvitation(params: params) { (datas, flag) in
                if flag {
                    self.mainTableArr.addObjects(from: datas)
                    self.mainTableView.reloadData()
                }
                self.view.endLoading()
            }

        }else{
            
            netWorkForMyFriend { (datas, success) in
                deBugPrint(item: datas)
                
                for index in 0..<datas.count {
                    
                    let model = datas[index] as! ApplyModel
                    
                    if self.type == "2" {
                        
                        if model.user_type == "1" {
                            self.mainTableArr.add(model)
                        }
                    }else{
                        if model.user_type == "2" {
                            self.mainTableArr.add(model)
                        }
                    }
                }
                self.mainTableView.reloadData()
            }
        }
    }
    
    
    //    右键
    func rightBarButton() {
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "完成", style: .plain, target: self, action: #selector(selectDone(sender:)))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white

    }
    
    
    @objc func selectDone(sender:UIBarButtonItem) {
        
        if class_id.count > 0 {
            var params = [String:String]()
            
            if state == "0" {
                params = [
                    "SESSIONID":Defaults[userToken]!,
                    "mobileCode":mobileCode,
                    "class_id":class_id,
                    "type":type,
                    "userId":selectArr.joined(separator: ","),
                    ]
            }else{
                params = [
                    "SESSIONID":Defaults[userToken]!,
                    "mobileCode":mobileCode,
                    "state":state,
                    "class_id":class_id,
                    "type":type,
                    "userId":selectArr.joined(separator: ","),
                    ]
            }
            NetWorkTeachersAddToClass(params: params) { (result) in
                
                if result {
                    self.navigationController?.popToViewController((self.navigationController?.viewControllers[1])!, animated: true)
                }
            }
        }else{
            
            if chooseMemberBlock != nil {
                chooseMemberBlock!(addMembers)
            }
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    //MARK:  ******代理 ：UITableViewDataSource,UITableViewDelegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if mainTableArr.count == 0 {
            self.mainTableView.addSubview(emptyView)
        }else{
            emptyView.removeFromSuperview()
        }

        return mainTableArr.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = mainTableArr[indexPath.row] as! ApplyModel
        
        let cell : ShowFridensCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable, for: indexPath) as! ShowFridensCell
        cell.selectionStyle = .default
        
        var selected = false
        
        if class_id.count>0 {
            if selectArr.contains(model.freind_id) {
                selected = true
            }
        }else{
//            if addMembers.contains(model) {
//                selected = true
//            }
            
            for m in addMembers {
                if m.freind_id == model.freind_id {
                    selected = true
                }
            }
        }
        
        model.user_type = type
        cell.ShowFridensCellForChooseMembers(model: model, isSelected: selected)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = mainTableArr[indexPath.row] as! ApplyModel

        if class_id.count>0 {
            if selectArr.contains(model.freind_id) {
                selectArr.remove(at: selectArr.index(of: model.freind_id)!)
            }else{
                selectArr.append(model.freind_id)
            }
        }else{
            
            var contain = false
            for m in addMembers {
                if m.freind_id == model.freind_id {
                    addMembers.remove(at: addMembers.index(of: m)!)
                    contain = true
                }
            }
            if !contain {
                addMembers.append(model)
            }
        }

        tableView.reloadData()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    
    var emptyView = UIView()
    //    当数据为空的时候，显示提示
    func addImageWhenEmpty() {
        
        emptyView = UIView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: kSCREEN_HEIGHT - 46))
        emptyView.backgroundColor = kBGColor()
        let imageView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: 200 * kSCREEN_SCALE, height: 200 * kSCREEN_SCALE))
        imageView.image = #imageLiteral(resourceName: "404_icon_default")
        imageView.center = CGPoint(x: emptyView.centerX, y: emptyView.centerY - 200 * kSCREEN_SCALE)
        emptyView.addSubview(imageView)
        
        let label = UILabel.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 18))
        label.textAlignment = .center
        label.textColor = kGaryColor(num: 163)
        label.center = CGPoint(x: emptyView.centerX, y: emptyView.centerY-40)
        label.font = kFont34
        label.numberOfLines = 2
        label.text = "暂时没有可选择好友"
        emptyView.addSubview(label)
    }

}


