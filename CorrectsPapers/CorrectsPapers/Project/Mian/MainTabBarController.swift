//
//  MainTabBarController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/10.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyUserDefaults
class MainTabBarController: UITabBarController {

    var workBookVC  = WorkBookViewController()
    var non_WorkBookVC  = Non_WorkBookViewController()
    var classVC    = ClassViewController()
    var personVC    = PersonnalViewController()
    
    var tWorkBookVC  = TBookViewController()
    var tOtherWorkVC  = TOtherWorkViewController()
    var tClassVC    = TClassViewController()
    var tPersonVC    = TPersonalViewController()
    
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

    
    
    self.selectedIndex = 3
}

func unSelectedTapTabBarItems(tabBarItem:UITabBarItem) {
    tabBarItem.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12),NSAttributedStringKey.foregroundColor:UIColor.lightGray], for: .normal);
}


func selectedTapTabBarItems(tabBarItem:UITabBarItem) {
    
    tabBarItem.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12),NSAttributedStringKey.foregroundColor:kMainColor()], for: .selected);
    
}
}
