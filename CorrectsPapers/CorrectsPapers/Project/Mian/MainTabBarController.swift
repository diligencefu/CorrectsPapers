//
//  MainTabBarController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/10.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyUserDefaults
import UserNotifications



class MainTabBarController: UITabBarController {

    var workBookVC  = WorkBookViewController()
    var non_WorkBookVC  = NotWorkViewController()
    var classVC    = ClassViewController()
    var personVC    = PersonnalViewController()
    
    var tWorkBookVC  = TBookViewController()
    var tOtherWorkVC  = TOtherWorkViewController()
    var tClassVC    = TClassViewController()
    var tPersonVC    = TPersonalViewController()
    
    
    var model = PersonalModel()

    
    var currentCount = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChildCOntrollers()
    }

    
    func addChildCOntrollers() {
        //
        
        if Defaults[userIdentity] == kTeacher {
            
            //        练习册
            tWorkBookVC.tabBarItem = UITabBarItem.init(title: "练习册", image: UIImage.init(named: "lianxice_icon_default"), selectedImage: UIImage.init(named: "lianxice_icon_pressed"))
            tWorkBookVC.tabBarItem.tag = 0
            tWorkBookVC.tabBarItem.accessibilityIdentifier = "workBookVC"
            selectedTapTabBarItems(tabBarItem: tWorkBookVC.tabBarItem)
            unSelectedTapTabBarItems(tabBarItem: tWorkBookVC.tabBarItem)
            let Nav0 = XCNavigationController.init(rootViewController: tWorkBookVC)
            
            //        非练习册
            tOtherWorkVC.tabBarItem = UITabBarItem.init(title: "非练习册", image: UIImage.init(named: "feilianxice_icon_default"), selectedImage: UIImage.init(named: "feilianxice_icon_pressed"))
            tOtherWorkVC.tabBarItem.tag = 1
            tOtherWorkVC.tabBarItem.accessibilityIdentifier = "non_WorkBookVC"
            selectedTapTabBarItems(tabBarItem: tOtherWorkVC .tabBarItem)
            unSelectedTapTabBarItems(tabBarItem: tOtherWorkVC.tabBarItem)
            let Nav1 = XCNavigationController.init(rootViewController: tOtherWorkVC)
            
            //        班级
            tClassVC.tabBarItem = UITabBarItem.init(title: "班级", image: UIImage.init(named: "banji_icon_default"), selectedImage: UIImage.init(named: "banji_icon_pressed"))
            tClassVC.tabBarItem.tag = 2
            tClassVC.tabBarItem.accessibilityIdentifier = "classVC"
            selectedTapTabBarItems(tabBarItem: tClassVC.tabBarItem)
            unSelectedTapTabBarItems(tabBarItem: tClassVC.tabBarItem)
            let Nav2 = XCNavigationController.init(rootViewController: tClassVC)
            
            //        我的
            tPersonVC.tabBarItem = UITabBarItem.init(title: "我的", image: UIImage.init(named: "my_icon_default"), selectedImage: UIImage.init(named: "my_icon_pressed"))
            tPersonVC.tabBarItem.tag = 3
            tPersonVC.tabBarItem.accessibilityIdentifier = "orderVC"
            selectedTapTabBarItems(tabBarItem: tPersonVC.tabBarItem)
            unSelectedTapTabBarItems(tabBarItem: tPersonVC.tabBarItem)
            let Nav3 = XCNavigationController.init(rootViewController: tPersonVC)
            
            self.viewControllers = [Nav0,Nav1,Nav2,Nav3]
            
        }else{
            
            //        练习册
            workBookVC.tabBarItem = UITabBarItem.init(title: "练习册", image: UIImage.init(named: "lianxice_icon_default"), selectedImage: UIImage.init(named: "lianxice_icon_pressed"))
            workBookVC.tabBarItem.tag = 0
            workBookVC.tabBarItem.accessibilityIdentifier = "workBookVC"
            selectedTapTabBarItems(tabBarItem: workBookVC.tabBarItem)
            unSelectedTapTabBarItems(tabBarItem: workBookVC.tabBarItem)
            let Nav0 = XCNavigationController.init(rootViewController: workBookVC)
            
            //        非练习册
            non_WorkBookVC.tabBarItem = UITabBarItem.init(title: "非练习册", image: UIImage.init(named: "feilianxice_icon_default"), selectedImage: UIImage.init(named: "feilianxice_icon_pressed"))
            non_WorkBookVC.tabBarItem.tag = 1
            non_WorkBookVC.tabBarItem.accessibilityIdentifier = "non_WorkBookVC"
            selectedTapTabBarItems(tabBarItem: non_WorkBookVC .tabBarItem)
            unSelectedTapTabBarItems(tabBarItem: non_WorkBookVC.tabBarItem)
            let Nav1 = XCNavigationController.init(rootViewController: non_WorkBookVC)
            
            //        班级
            classVC.tabBarItem = UITabBarItem.init(title: "班级", image: UIImage.init(named: "banji_icon_default"), selectedImage: UIImage.init(named: "banji_icon_pressed"))
            classVC.tabBarItem.tag = 2
            classVC.tabBarItem.accessibilityIdentifier = "classVC"
            selectedTapTabBarItems(tabBarItem: classVC.tabBarItem)
            unSelectedTapTabBarItems(tabBarItem: classVC.tabBarItem)
            let Nav2 = XCNavigationController.init(rootViewController: classVC)
            
            //        我的
            personVC.tabBarItem = UITabBarItem.init(title: "我的", image: UIImage.init(named: "my_icon_default"), selectedImage: UIImage.init(named: "my_icon_pressed"))
            personVC.tabBarItem.tag = 3
            personVC.tabBarItem.accessibilityIdentifier = "orderVC"
            selectedTapTabBarItems(tabBarItem: personVC.tabBarItem)
            unSelectedTapTabBarItems(tabBarItem: personVC.tabBarItem)
            let Nav3 = XCNavigationController.init(rootViewController: personVC)
            
            self.viewControllers = [Nav0,Nav1,Nav2,Nav3]
        }
        
        _ = Timer.scheduledTimer(timeInterval: 20, target: self, selector: #selector(countDown(timer:)), userInfo: nil, repeats: true)

        let params = [
            "SESSIONID":Defaults[userToken]!,
            "mobileCode":Defaults[mCode]!
        ]
        netWorkForMyData(params: params) { (dataArr,flag) in
            
            if flag {
                if dataArr.count > 0{
                    self.model = dataArr[0] as! PersonalModel
                    if Defaults[userIdentity] != kTeacher {

                        if Int(self.model.num)! > 0{
                            self.personVC.tabBarItem.badgeValue = self.model.num
                            //        通知中心
                            NotificationCenter.default.post(name: Notification.Name(rawValue: SuccessEditNotiStudent), object: self, userInfo: ["refresh":"begin"])
                        }else{
                            self.tabBarItem.badgeValue = nil
                        }
                        Defaults[messageCount] = self.model.num
                        
                    }else{
                        
                        if Int(self.model.num)! > 0{
                            self.tPersonVC.tabBarItem.badgeValue = self.model.num
                            //        通知中心
                            NotificationCenter.default.post(name: Notification.Name(rawValue: SuccessEditNotiTeacher), object: self, userInfo: ["refresh":"begin"])
                        }else{
                            self.tabBarItem.badgeValue = nil
                        }

                    }
                    Defaults[messageCount] = self.model.num
                }
            }
        }
        
        self.selectedIndex = 0
    }
    
    
    
    @objc func countDown(timer:Timer) {
        let params = [
            "SESSIONID":Defaults[userToken]!,
            "mobileCode":Defaults[mCode]!
        ]
        netWorkForMyData(params: params) { (dataArr,flag) in
            if flag {
                if dataArr.count > 0{
                    self.model = dataArr[0] as! PersonalModel

                    if Defaults[userIdentity] != kTeacher {
                        
                        if Int(self.model.num)! > 0{
                            self.personVC.tabBarItem.badgeValue = self.model.num
                        }else{
                            self.tabBarItem.badgeValue = nil
                        }
                        //        通知中心
                        NotificationCenter.default.post(name: Notification.Name(rawValue: SuccessEditNotiStudent), object: self, userInfo: ["refresh":"begin"])
                        
                    }else{
                        
                        if Int(self.model.num)! > 0{
                            self.tPersonVC.tabBarItem.badgeValue = self.model.num
                        }else{
                            self.tabBarItem.badgeValue = nil
                        }
                        //        通知中心
                        NotificationCenter.default.post(name: Notification.Name(rawValue: SuccessEditNotiTeacher), object: self, userInfo: ["refresh":"begin"])
                    }
                    
                    if Int(self.model.num)! > Int(Defaults[messageCount]!)! {
                        setToast(str: "你有"+String(Int(self.model.num)!-Int(Defaults[messageCount]!)!)+"条新的通知消息")
//                        self.addNotification(message: "你有"+String(Int(self.model.num)!-Int(Defaults[messageCount]!)!)+"条新的通知消息")
                    }
                    Defaults[messageCount] = self.model.num
                }
            }
        }
    }
    
    
    func addNotification(message:String) {
        
//        // 初始化一个通知
//        let localNoti = UILocalNotification()
//        // 通知的触发时间，例如即刻起15分钟后
//        let fireDate = NSDate().addingTimeInterval(0)
//        localNoti.fireDate = fireDate as Date
//        // 设置时区
//        localNoti.timeZone = NSTimeZone.default
//        // 通知上显示的主题内容
//        localNoti.alertBody = "通知消息"
//        // 收到通知时播放的声音，默认消息声音
//        localNoti.soundName = UILocalNotificationDefaultSoundName
//        //待机界面的滑动动作提示
//        localNoti.alertAction = message
//        // 应用程序图标右上角显示的消息数
//        localNoti.applicationIconBadgeNumber = 0
//        // 通知上绑定的其他信息，为键值对
//        localNoti.userInfo = ["id": "1",  "name": "xxxx"]
//        // 添加通知到系统队列中，系统会在指定的时间触发
//        UIApplication.shared.scheduleLocalNotification(localNoti)
        
        //MARK:  加一个本地通知
        if #available(iOS 10.0, *) {
            let content = UNMutableNotificationContent.init()
            content.badge = 1
            content.sound = UNNotificationSound.default()
            content.title = "通知"
            content.subtitle = "通知消息"
            content.body = message
            content.userInfo = ["url":"1"]
            
            let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 5, repeats: false)
            let nofi = UNNotificationRequest.init(identifier: "notification", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(nofi) { (error) in
                print(nofi.content.userInfo)
            }
            

        } else {
            // Fallback on earlier versions
        }
        
    }
    

    func unSelectedTapTabBarItems(tabBarItem:UITabBarItem) {
        tabBarItem.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12),NSAttributedStringKey.foregroundColor:UIColor.lightGray], for: .normal);
    }
    
    
    func selectedTapTabBarItems(tabBarItem:UITabBarItem) {
        
        tabBarItem.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12),NSAttributedStringKey.foregroundColor:kMainColor()], for: .selected);
        
    }
}
