//
//  XCNavigationController.swift
//  PlasticSurgery
//
//  Created by RongXing on 2017/9/21.
//  Copyright © 2017年 RongXing. All rights reserved.
//

import UIKit

class XCNavigationController: UINavigationController {
    

    override func viewDidLoad() {
        super.viewDidLoad()        
//        setupBarButtonStyle()
        setupTitleViewMainStyle()
    }
        
    //push的时候判断到子控制器的数量。当大于零时隐藏BottomBar 也就是UITabBarController 的tababar
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.childViewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
//    重新设置标题颜色和样式
    func setupTitleViewSectionStyle() {
        let titleV = UINavigationBar.appearance()
        let textAttrs = NSMutableDictionary()
        textAttrs[NSAttributedStringKey.foregroundColor] = UIColor.black
        textAttrs[NSAttributedStringKey.font] = UIFont.boldSystemFont(ofSize: 18)
        titleV.titleTextAttributes = (textAttrs as? [NSAttributedStringKey : Any])
    }
    
    func setupTitleViewMainStyle() {
        let titleV = UINavigationBar.appearance()
        let textAttrs = NSMutableDictionary()
        textAttrs[NSAttributedStringKey.foregroundColor] = UIColor.white
        textAttrs[NSAttributedStringKey.font] = UIFont.boldSystemFont(ofSize: 18)
        titleV.titleTextAttributes = (textAttrs as? [NSAttributedStringKey : Any])
        
    }


    func setupBarButtonStyle() {
        
        let barItem = UIBarButtonItem.appearance()
        
        let textAttrs = NSMutableDictionary()
        textAttrs[NSAttributedStringKey.foregroundColor] = UIColor.white
        textAttrs[NSAttributedStringKey.font] = UIFont.systemFont(ofSize: 15)
        barItem.setTitleTextAttributes((textAttrs as? [NSAttributedStringKey : Any]), for: .normal)
        barItem.setTitleTextAttributes(textAttrs as? [NSAttributedStringKey : Any] , for: .highlighted)
        
        let disableTextAttrs = NSMutableDictionary()
        disableTextAttrs[NSAttributedStringKey.foregroundColor] = UIColor.white
        barItem.setTitleTextAttributes((disableTextAttrs as? [NSAttributedStringKey : Any]), for: .disabled)
    }
}
