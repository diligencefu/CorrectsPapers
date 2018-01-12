//
//  AppDelegate.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/10.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import UserNotifications
import SwiftyUserDefaults
import IQKeyboardManagerSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate,WXApiDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds);
        self.window!.backgroundColor=UIColor.white;
        
        if Defaults[userToken] != nil {
            
            self.window!.rootViewController=MainTabBarController()
        }else{
            
            let Nav1 = XCNavigationController.init(rootViewController: LoginViewController())
            self.window!.rootViewController = Nav1
        }
        
        self.window!.makeKeyAndVisible()
        
        
        if #available(iOS 10.0, *) {
            let notifiCenter = UNUserNotificationCenter.current()
            
            notifiCenter.delegate = self
            
            let types = UNAuthorizationOptions(arrayLiteral: [.alert, .badge, .sound])
            
            notifiCenter.requestAuthorization(options: types) { (flag, error) in
                if flag {
                    print("iOS request notification success")
                }else{
                    print(" iOS 10 request notification fail")
                }
            }

        } else {
            
            // Fallback on earlier versions
        }
        
        UIApplication.shared.applicationIconBadgeNumber = 0
        
        setKeyBoard()
        
        
        /**
         *  初始化ShareSDK应用
         *
         *  @param activePlatforms          使用的分享平台集合，如:@[@(SSDKPlatformTypeSinaWeibo), @(SSDKPlatformTypeTencentWeibo)];
         *  @param importHandler           导入回调处理，当某个平台的功能需要依赖原平台提供的SDK支持时，需要在此方法中对原平台SDK进行导入操作。具体的导入方式可以参考ShareSDKConnector.framework中所提供的方法。
         *  @param configurationHandler     配置回调处理，在此方法中根据设置的platformType来填充应用配置信息
         */
        
        ShareSDK.registerActivePlatforms(
            [SSDKPlatformType.typeQQ.rawValue,
             SSDKPlatformType.typeWechat.rawValue],
            // onImport 里的代码,需要连接社交平台SDK时触发
            onImport: {(platform : SSDKPlatformType) -> Void in
                switch platform
                {
                    
                case SSDKPlatformType.typeWechat:
                    ShareSDKConnector.connectWeChat(WXApi.classForCoder())
                case SSDKPlatformType.typeQQ:
                    ShareSDKConnector.connectQQ(QQApiInterface.classForCoder(), tencentOAuthClass: TencentOAuth.classForCoder())
                default:
                    break
                }
        },
            onConfiguration: {(platform : SSDKPlatformType , appInfo : NSMutableDictionary?) -> Void in
                switch platform
                {
                    
                case SSDKPlatformType.typeWechat:
                    //设置微信应用信息
                    appInfo?.ssdkSetupWeChat(byAppId: kWXAppKey,
                                             appSecret: kWXAppSecret)
                case SSDKPlatformType.typeQQ:
                    //设置QQ应用信息
                    appInfo?.ssdkSetupQQ(byAppId: kQQAppKey,
                                         appKey: kQQAppSecret,
                                         authType: SSDKAuthTypeWeb)
                default:
                    break
                }
        })
        
//        微信支付
//        enableMTA：是否支持数据上报
        WXApi.registerApp(kWXAppKey, enableMTA: true)
        
//        [4] 如果你的程序要发消息给微信，那么需要调用WXApi的sendReq函数：
//        -(BOOL) sendReq:(BaseReq*)req
//        其中req参数为SendMessageToWXReq类型。
        return true
    }

//    onReq是微信终端向第三方程序发起请求，要求第三方程序响应。第三方程序响应完后必须调用sendRsp返回。在调用sendRsp返回时，会切回到微信终端程序界面。
    func onReq(_ req: BaseReq!) {
        
    }
    
//    如果第三方程序向微信发送了sendReq的请求，那么onResp会被回调。sendReq请求调用后，会切到微信终端程序界面。
    func onResp(_ resp: BaseResp!) {
//        PayResp
        let strTitle = "支付结果"
        var strMsg = "\(resp.errCode)"
        if resp.isKind(of: PayResp.self) {
            switch resp.errCode {
            case 0 :
                strMsg = "支付成功!"
                print("retcode = \(resp.errCode), retstr = \(resp.errStr)")

                NotificationCenter.default.post(Notification.init(name: Notification.Name(rawValue: "WXPaySuccessNotification")))
              break
            case -1 :
                strMsg = "支付失败，请您重新支付!"
                print("retcode = \(resp.errCode), retstr = \(resp.errStr)")
                break
            case -2 :
                strMsg = "退出支付！"
                print("retcode = \(resp.errCode), retstr = \(resp.errStr)")
                break
                
            default:
                strMsg = "支付失败，请您重新支付!"
                print("retcode = \(resp.errCode), retstr = \(resp.errStr)")
            }
        }
        let alert = UIAlertView(title: strTitle, message: strMsg, delegate: nil, cancelButtonTitle: "好的")
        alert.show()
        
//        作者：iyakexi
//        链接：http://www.jianshu.com/p/7ad46552d6fc
//        來源：简书
//        著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
    }
    
    
    private func setKeyBoard() {
        
        let manager = IQKeyboardManager.sharedManager()
        manager.enable = true
        manager.shouldResignOnTouchOutside = true
        manager.shouldToolbarUsesTextFieldTintColor = true
        manager.enableAutoToolbar = true
                
    }
    

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return WXApi.handleOpen(url, delegate: self)
    }
    
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        return WXApi.handleOpen(url, delegate: WXApiManager.shared())
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

