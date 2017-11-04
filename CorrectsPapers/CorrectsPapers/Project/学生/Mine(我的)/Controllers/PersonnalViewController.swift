//
//  PersonnalViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/10.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyUserDefaults
import MJRefresh

class PersonnalViewController: BaseViewController {
    
    var dataArr = [Array<String>]()
    var infoArr = [Array<String>]()
    
    var model = PersonalModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            self.refreshHeaderAction()
        })

    }
    
    override func requestData() {
        
        netWorkForMyData { (dataArr) in
            
            if dataArr.count > 0{
                self.model = dataArr[0] as! PersonalModel
                self.infoArr = [[""],[self.model.coin_count!+"学币",self.model.friendCount+"人",""],[self.model.num,""],["",""]]
                
                Defaults[username] = self.model.user_name
                Defaults[userArea] = self.model.user_area
                Defaults[userId] = self.model.user_num
                Defaults[userGrade]! = self.model.user_fit_class
                Defaults[userAccount] = self.model.coin_count
                
            }
            self.mainTableView.reloadData()
        }
    }
    
    override func refreshHeaderAction() {
        netWorkForMyData { (dataArr) in
            
            if dataArr.count > 0{
                self.model = dataArr[0] as! PersonalModel
                self.infoArr = [[""],[self.model.coin_count!+"学币",self.model.friendCount+"人",""],[self.model.num,""],["",""]]
                
                Defaults[username] = self.model.user_name
                Defaults[userArea] = self.model.user_area
                Defaults[userId] = self.model.user_num
                Defaults[userGrade]! = self.model.user_fit_class
                Defaults[userAccount] = self.model.coin_count

            }
            
            self.mainTableView.mj_header.endRefreshing()
            self.mainTableView.reloadData()
        }
    }
    
    override func leftBarButton() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: #imageLiteral(resourceName: "set_icon_default"), style: .plain, target: self, action: #selector(pushToSetting(sender:)))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        
    }
    
    @objc func pushToSetting(sender:UIBarButtonItem) {
        let setVC = SettingViewController()
        self.navigationController?.pushViewController(setVC, animated: true)
        
    }
    
    override func configSubViews() {
        self.navigationItem.title = "我的"
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        dataArr = [[""],["我的学币","我的好友","邀请好友"],["消息中心","我想成为老师"],["意见和建议"]]
              
        model.user_name = Defaults[username]
        model.user_area = Defaults[userArea]
        model.user_num = Defaults[userId]
        model.user_fit_class = Defaults[userGrade]!
        
        if Defaults[messageNum] != nil {
            model.num = Defaults[messageNum]
        }else{
            model.num = "0"
        }
        if Defaults[userAccount] != nil{
            model.coin_count = Defaults[userAccount]
        }else{
            model.coin_count = "0"
        }
        if Defaults[userFriendCount] != nil {
            model.friendCount = Defaults[userFriendCount]
        }else{
            model.friendCount = "0"
        }

        self.infoArr = [[""],[self.model.coin_count!+"学币",self.model.friendCount+"人",""],[self.model.num,""],["",""]]
        
//        infoArr = [[""],["10000学币","15624学分","100人",""],["",""],["",""]]
        
        mainTableView = UITableView.init(frame: CGRect(x: 0,
                                                       y: -504,
                                                       width: kSCREEN_WIDTH,
                                                       height: kSCREEN_HEIGHT - 64 + 504),
                                         style: .grouped)
        mainTableView.dataSource = self;
        mainTableView.delegate = self;
        mainTableView.estimatedRowHeight = 44
        mainTableView.register(UINib(nibName: "CreateBookCell", bundle: nil), forCellReuseIdentifier: identyfierTable)
        mainTableView.register(UINib(nibName: "PersonHeadCell", bundle: nil), forCellReuseIdentifier: identyfierTable1)
        self.view.addSubview(mainTableView)
        mainTableView.backgroundColor = kSetRGBColor(r: 239, g: 239, b: 244)
        mainTableArr = ["关于医生端","清除缓存","检查更新"]
    }
    
    //    ******************代理 ： UITableViewDataSource,UITableViewDelegate  ************
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return  dataArr[section].count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return dataArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell : PersonHeadCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable1, for: indexPath) as! PersonHeadCell
            cell.setValues(model: model)
            return cell
        }
        
        let cell : CreateBookCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable, for: indexPath) as! CreateBookCell
        cell.selectionStyle = .default
        var isShow = false
                
        if indexPath.section == 0 {
            isShow = true
        }
        
        if indexPath.section == 2 && indexPath.row == 0 {
            if model.num == nil {
                
                cell.showForMessages(count:"",titleStr:"消息中心")
            }else{
                
                cell.showForMessages(count:model.num,titleStr:"消息中心")
            }
        }else{
            
            cell.showForCreateBook(isShow: isShow, title:  dataArr[indexPath.section][indexPath.row], subTitle: infoArr[indexPath.section][indexPath.row])
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 19 * kSCREEN_SCALE))
        
        if section == 0 {
            view.height = 0
        }
        
        view.backgroundColor = UIColor.blue
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 19 * kSCREEN_SCALE))
        view.backgroundColor = kSetRGBColor(r: 239, g: 239, b: 244)
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 {
            return 0
        }
        return 19 * kSCREEN_SCALE
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01 * kSCREEN_SCALE
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            let editVC = EditInfoViewController()
            editVC.model = model
            self.navigationController?.pushViewController(editVC, animated: true)
            
        }
        
        if indexPath.section == 1 {
            
            switch indexPath.row {
                
            case 0:
                
                let incomeVC = IncomeViewController()
                self.navigationController?.pushViewController(incomeVC, animated: true)
                break
            case 1:
                let friendsVC = MyFriendViewController()
                self.navigationController?.pushViewController(friendsVC, animated: true)

                
                break
            case 2:
                
                break
            default:
                break
            }
        }
        
        if indexPath.section == 2 {
            
            switch indexPath.row {
            case 0:
                
                let messageVC = MessgaeCenterViewController()
                self.navigationController?.pushViewController(messageVC, animated: true)
                break
            case 1:
                
                let perfecVC = PerfectInfoViewController()
                perfecVC.isTeacher = true
                self.navigationController?.pushViewController(perfecVC, animated: true)
                break
            default:
                break
            }
        }
        
        if indexPath.section == 3 {
            
            switch indexPath.row {
            case 0:
                let suggestVC = SuggestViewController()
                self.navigationController?.pushViewController(suggestVC, animated: true)
                break
            case 1:
                
                break
            default:
                break
            }
        }
    }
}

