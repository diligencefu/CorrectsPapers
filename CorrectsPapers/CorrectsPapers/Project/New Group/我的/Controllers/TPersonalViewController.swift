//
//  TPersonalViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/20.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyUserDefaults
import MJRefresh

class TPersonalViewController: BaseViewController {
    
    var dataArr = [Array<String>]()
    var infoArr = [Array<String>]()
    
    var model = PersonalModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            self.refreshHeaderAction()
        })
        //        学生编辑资料成功
        NotificationCenter.default.addObserver(self, selector: #selector(receiveNitification(nitofication:)), name: NSNotification.Name(rawValue: SuccessEditNotiStudent), object: nil)
    }
    
    @objc func receiveNitification(nitofication:Notification) {
//        let params = [
//            "SESSIONID":Defaults[userToken]!,
//            "mobileCode":mobileCode
//        ]
//        netWorkForMyData(params: params) { (dataArr,flag) in
//            
//            if flag {
//                if dataArr.count > 0{
//                    self.model = dataArr[0] as! PersonalModel
//                    self.infoArr = [[""],[self.model.coin_count!+"学币"],[self.model.friendCount+"人",""],[self.model.num,"",""]]
//                    
//                    Defaults[username] = self.model.user_name
//                    Defaults[userArea] = self.model.user_area
//                    Defaults[userId] = self.model.user_num
//                    Defaults[userAccount] = OCTools.init().positiveFormat(self.model.coin_count!)
//                    Defaults[messageNum] = self.model.num
//                    Defaults[userAccount] = self.model.coin_count
//                    Defaults[userFriendCount] = self.model.friendCount
//                    Defaults[userGrade] = self.model.user_fit_class
//                    
//                    if Int(self.model.num)! > 0{
//                        self.tabBarItem.badgeValue = self.model.num
//                    }else{
//                        self.tabBarItem.badgeValue = nil
//                    }
//                    self.mainTableView.reloadData()
//
//                }
//                self.mainTableView.reloadData()
//            }
//        }
    }
    
    
    
    override func requestData() {
        
        self.view.beginLoading()
        let params = [
            "SESSIONID":Defaults[userToken]!,
            "mobileCode":mobileCode
        ]
        netWorkForMyData(params: params) { (dataArr,flag) in

            if flag {
                if dataArr.count > 0{
                    self.model = dataArr[0] as! PersonalModel
                    self.infoArr = [[""],[self.model.coin_count!+"学币"],[self.model.friendCount+"人",""],[self.model.num,"",""]]
                    
                    Defaults[username] = self.model.user_name
                    Defaults[userArea] = self.model.user_area
                    Defaults[userId] = self.model.user_num
                    Defaults[userAccount] = OCTools.init().positiveFormat(self.model.coin_count!)
                    Defaults[messageCount] = self.model.num
                    Defaults[userPhone] = self.model.user_phone
                    Defaults[userFriendCount] = self.model.friendCount
                    Defaults[userGrade] = self.model.user_fit_class
                    Defaults[correct_subject] = self.model.user_correct_subject

                    if Int(self.model.num)! > 0{
                        if Int(self.model.num)!>99{
                            self.tabBarItem.badgeValue = "99+"
                        }else{
                            self.tabBarItem.badgeValue = self.model.num
                        }
                    }else{
                        self.tabBarItem.badgeValue = nil
                    }
                    self.mainTableView.reloadData()

                }
                self.mainTableView.reloadData()
            }
            self.view.endLoading()
        }
        addShareView()
    }
    
    
    override func refreshHeaderAction() {
        
        self.view.beginLoading()
        let params = [
            "SESSIONID":Defaults[userToken]!,
            "mobileCode":mobileCode
        ]
        netWorkForMyData(params: params) { (dataArr,flag) in
            
            if flag {
                if dataArr.count > 0{
                    self.model = dataArr[0] as! PersonalModel
                    self.infoArr = [[""],[self.model.coin_count!+"学币"],[self.model.friendCount+"人",""],[self.model.num,"",""]]
                    
                    Defaults[username] = self.model.user_name
                    Defaults[userArea] = self.model.user_area
                    Defaults[userId] = self.model.user_num
                    Defaults[userAccount] = OCTools.init().positiveFormat(self.model.coin_count!)
                    Defaults[messageCount] = self.model.num
                    Defaults[userAccount] = self.model.coin_count
                    Defaults[userFriendCount] = self.model.friendCount
                    Defaults[userGrade] = self.model.user_fit_class
                    Defaults[correct_subject] = self.model.user_correct_subject

                    if Int(self.model.num)! > 0{
                        if Int(self.model.num)!>99{
                            self.tabBarItem.badgeValue = "99+"
                        }else{
                            self.tabBarItem.badgeValue = self.model.num
                        }
                    }else{
                        self.tabBarItem.badgeValue = nil
                    }
                    self.mainTableView.reloadData()

                }
                
                self.mainTableView.mj_header.endRefreshing()
                self.mainTableView.reloadData()
            }
            self.view.endLoading()
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
        
        model.user_name = Defaults[username]
        model.user_area = Defaults[userArea]
        model.user_num = Defaults[userId]
        
        if Defaults[userGrade] != nil {
            model.user_fit_class = Defaults[userGrade]!
        }else{
            model.user_fit_class = "一年级"
        }

        if Defaults[messageCount] != nil {
            model.num = Defaults[messageCount]
        }else{
            model.num = "1"
        }
        if Defaults[userAccount] != nil{
            model.coin_count = Defaults[userAccount]
        }else{
            model.coin_count = "100"
        }
        if Defaults[userFriendCount] != nil {
            model.friendCount = Defaults[userFriendCount]
        }else{
            model.friendCount = "0"
        }
        
        dataArr = [[""],["我的收入"],["我的好友","邀请好友"],["消息中心","被投诉记录","意见和建议"]]
        self.infoArr = [[""],[self.model.coin_count!+"学币"],[self.model.friendCount+"人",""],[self.model.num,"",""]]
        
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
        
        if indexPath.section == 3 && indexPath.row == 0 {
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
            
            let cell = tableView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as! PersonHeadCell
            let editVC = TEditInfoViewController()
            editVC.model = model
            editVC.headImage = cell.headIcon.image!
            self.navigationController?.pushViewController(editVC, animated: true)
            
        }
        
        if indexPath.section == 1 {
            let incomeVC = IncomeViewController()
            self.navigationController?.pushViewController(incomeVC, animated: true)
        }
        
        if indexPath.section == 2 {
            
            switch indexPath.row {
            case 0:
                let friendsVC = MyFriendViewController()
                self.navigationController?.pushViewController(friendsVC, animated: true)
                break
            case 1:

                showShareView()
                break
            default:
                break
            }
        }
        
        if indexPath.section == 3 {
            
            if indexPath.row == 0 {
                
                let messageVC = MessgaeCenterViewController()
                self.navigationController?.pushViewController(messageVC, animated: true)
                
            }else if indexPath.row == 1{
                
                let complainrecordVC = ComplaintRecordViewController()
                self.navigationController?.pushViewController(complainrecordVC, animated: true)
                
            }else{
                
                let suggestVC = SuggestViewController()
                self.navigationController?.pushViewController(suggestVC, animated: true)
                
            }
        }
    }
    
    
    var BGView = UIView()
    var shareView = ShareView()
    
    func addShareView()  {
        //        弹出视图弹出来之后的背景蒙层
        BGView = UIView.init(frame: self.view.frame)
        BGView.backgroundColor = kSetRGBAColor(r: 5, g: 5, b: 5, a: 0.5)
        BGView.alpha = 0
        //        BGView.isHidden = true
        
        let tapGes1 = UITapGestureRecognizer.init(target: self, action: #selector(showChooseCondi(tap:)))
        tapGes1.numberOfTouchesRequired = 1
        BGView.addGestureRecognizer(tapGes1)
        self.view.addSubview(BGView)
        
        shareView = UINib(nibName:"ShareView",bundle:nil).instantiate(withOwner: self, options: nil).first as! ShareView
        shareView.frame =  CGRect(x: 0, y: kSCREEN_HEIGHT, width: kSCREEN_WIDTH, height: 278)
        shareView.layer.cornerRadius = 30*kSCREEN_SCALE
        shareView.clipsToBounds = true
        shareView.chooseShareTypeAction = {
            
            // 1.创建分享参数
            let shareParames = NSMutableDictionary()
            shareParames.ssdkSetupShareParams(byText: Defaults[username]!+"邀请您加入思而邀请您加入思而慧！",
                                              images : UIImage(named: "AppIcon.png"),
                                              url : NSURL(string:"https://github.com/diligencefu/CorrectsPapers/commits/master") as URL!,
                                              title : "思而慧，让孩子们从此独立完成作业！",
                                              type : SSDKContentType.auto)
            
            switch $0 {
            case .ShareTypeWechat:
                //2.进行分享
                ShareSDK.share(SSDKPlatformType.subTypeWechatSession, parameters: shareParames) { (state : SSDKResponseState, nil, entity : SSDKContentEntity?, error :Error?) in
                    
                    switch state{
                    case SSDKResponseState.success: setToast(str: "分享成功")
                    case SSDKResponseState.fail:    setToast(str: "分享失败")
                    case SSDKResponseState.cancel:  setToast(str: "取消分享")
                    default:
                        break
                    }
                }
                
                break
            case .ShareTypeQQ:
                //2.进行分享
                ShareSDK.share(SSDKPlatformType.subTypeQQFriend, parameters: shareParames) { (state : SSDKResponseState, nil, entity : SSDKContentEntity?, error :Error?) in
                    
                    switch state{
                    case SSDKResponseState.success: setToast(str: "分享成功")
                    case SSDKResponseState.fail:    setToast(str: "分享失败")
                    case SSDKResponseState.cancel:  setToast(str: "取消分享")
                    default:
                        break
                    }
                }
                
                break
            case .ShareTypeQQZone:
                //2.进行分享
                ShareSDK.share(SSDKPlatformType.subTypeQZone, parameters: shareParames) { (state : SSDKResponseState, nil, entity : SSDKContentEntity?, error :Error?) in
                    
                    switch state{
                    case SSDKResponseState.success: setToast(str: "分享成功")
                    case SSDKResponseState.fail:    setToast(str: "分享失败")
                    case SSDKResponseState.cancel:  setToast(str: "取消分享")
                    default:
                        break
                    }
                }
                break
            default:
                break
            }
            self.hiddenViews()
        }
        self.view.addSubview(shareView)
    }
    
    
    @objc func showChooseCondi(tap:UITapGestureRecognizer) -> Void {
        if tap.view?.alpha == 1 {
            
            UIView.animate(withDuration: 0.5) {
                tap.view?.alpha = 0
                self.shareView.transform = .identity
            }
        }
    }
    
    
    func showShareView() -> Void {
        let y = 235+49
        
        UIView.animate(withDuration: 0.5) {
            self.shareView.transform = .init(translationX: 0, y: CGFloat(-y))
            self.BGView.alpha = 1
        }
    }
    
    
    func hiddenViews() {
        
        UIView.animate(withDuration: 0.5) {
            self.BGView.alpha = 0
            self.shareView.transform = .identity
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let params = [
            "SESSIONID":Defaults[userToken]!,
            "mobileCode":mobileCode
        ]
        netWorkForMyData(params: params) { (dataArr,flag) in
            
            if flag {
                if dataArr.count > 0{
                    self.model = dataArr[0] as! PersonalModel
                    self.infoArr = [[""],[self.model.coin_count!+"学币"],[self.model.friendCount+"人",""],[self.model.num,"",""]]
                    
                    Defaults[username] = self.model.user_name
                    Defaults[userArea] = self.model.user_area
                    Defaults[userId] = self.model.user_num
                    Defaults[userAccount] = OCTools.init().positiveFormat(self.model.coin_count!)
                    Defaults[messageCount] = self.model.num
                    Defaults[userAccount] = self.model.coin_count
                    Defaults[userFriendCount] = self.model.friendCount
                    Defaults[userGrade] = self.model.user_fit_class
                    Defaults[correct_subject] = self.model.user_correct_subject

                    if Int(self.model.num)! > 0{
                        if Int(self.model.num)!>99{
                            self.tabBarItem.badgeValue = "99+"
                        }else{
                            self.tabBarItem.badgeValue = self.model.num
                        }
                    }else{
                        self.tabBarItem.badgeValue = nil
                    }
                }
                self.mainTableView.reloadData()
            }
        }
    }

    
}
