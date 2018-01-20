//
//  IncomeViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/17.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class IncomeViewController: BaseViewController {

    var model = PersonalModel()
    var headView = IncomeHeadView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addRechargeView()
        // Do any additional setup after loading the view.
    }

    override func requestData() {

        self.view.beginLoading()
        netWorkForMyCoin { (datas,sumCoin,flag) in
            if flag {
                self.mainTableArr.addObjects(from: datas)
                self.headView.setAccount(num:sumCoin)
                self.mainTableView.reloadData()
            }
            self.view.endLoading()
        }
    }
    
    
    override func refreshHeaderAction() {

        netWorkForMyCoin { (datas,sumCoin,flag) in
            if flag {
                self.mainTableArr.removeAllObjects()
                self.mainTableArr.addObjects(from: datas)
                self.headView.setAccount(num:sumCoin)
                self.mainTableView.mj_header.endRefreshing()
                self.mainTableView.reloadData()
            }
        }
    }
    
    
    override func configSubViews() {

        self.navigationItem.title = "我的学币"
        
        headView = UINib(nibName:"IncomeHeadView",bundle:nil).instantiate(withOwner: self, options: nil).first as! IncomeHeadView
        headView.frame =  CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 685)
        headView.chooseImagesAction = {
            self.showRechargeView()
            
            
//            let params =
//                [
//                    "money":"1000",
//                    "SESSIONID":SESSIONID,
//                    "mobileCode":mobileCode
//                    ] as [String:Any]
//            NetWorkStudentUpdownAnswrs(params: params) { (flag) in
//                if flag {
//                    self.refreshHeaderAction()
//                }
//            }
        }
        
        mainTableView = UITableView.init(frame: CGRect(x: 0,
                                                       y: -500,
                                                       width: kSCREEN_WIDTH,
                                                       height: kSCREEN_HEIGHT - 64 + 500 ),
                                         style: .grouped)
        mainTableView.dataSource = self;
        mainTableView.delegate = self;
        mainTableView.estimatedRowHeight = 44
        mainTableView.register(UINib(nibName: "IncomeCell", bundle: nil), forCellReuseIdentifier: identyfierTable)
        mainTableView.tableHeaderView = headView
        self.view.addSubview(mainTableView)
        mainTableView.backgroundColor = kSetRGBColor(r: 239, g: 239, b: 244)
        
    }
    
    //    ******************代理 ： UITableViewDataSource,UITableViewDelegate  ************
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  mainTableArr.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = mainTableArr[indexPath.row] as! AccountModel
        let cell = tableView.dequeueReusableCell(withIdentifier: identyfierTable, for: indexPath) as! IncomeCell
        cell.setValuesForIncomeCell(model: model)
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
//        let tradeType = "APP"
//        let totalFee = Int("100")!*100 //价格
//        let orderNo = "APP"//订单号
//        let deviceIp = "APP"//设备IP地址
//        let wechatPartnerKey = "APP"
//        let notifyUrl = "APP"//通知地址
//
//
//
//
//        let adaptor = MXWechatSignAdaptor.init(wechatAppId: kAppKey, wechatMCHId: "mch_id", tradeNo: "", wechatPartnerKey: wechatPartnerKey, payTitle: "思而慧充值学币", orderNo: orderNo, totalFee: String(totalFee), deviceIp: deviceIp, notifyUrl: notifyUrl, tradeType: tradeType)
//
//        let request = PayReq.init()
//        //        商户号
//        request.partnerId = "1493754792"
//        //        预支付交易会话
//        request.prepayId = "wx201712071004374c9298d74d0629627935"
//        //        扩展字段
//        request.package = "Sign=WXPay"
//        //       随机字符串
//        request.nonceStr = "k7pxxpbMu7oat7jE9f46z3dwX3qK1HcV"
//        //        时间戳
//        request.timeStamp = 1512612281
//        //        签名
//        request.sign = "6BE7D71AAAFDDE3BD62D7F5895464218"
//
//        WXApi.send(request)
        
//        MXWechatPayHandler.jump(toWxPaywithPrice: 0.01, andTypeName: "思而慧充值学币")
    }
    
    
    
    var BGView = UIView()
    var rechargeView = LNRechargeView()
    
    @objc func showChooseCondi(tap:UITapGestureRecognizer) -> Void {
        if tap.view?.alpha == 1 {
            
            UIView.animate(withDuration: 0.5) {
                tap.view?.alpha = 0
                self.rechargeView.transform = .identity
            }
        }
    }
    
    func hiddenViews() {
        UIView.animate(withDuration: 0.5) {
            self.BGView.alpha = 0
            self.rechargeView.transform = .identity
        }
        
    }
    
    
    //    视图TagView
    func addRechargeView() {
        
        //        弹出视图弹出来之后的背景蒙层
        BGView = UIView.init(frame: self.view.frame)
        BGView.backgroundColor = kSetRGBAColor(r: 5, g: 5, b: 5, a: 0.5)
        BGView.alpha = 0
        //        BGView.isHidden = true
        
        let tapGes1 = UITapGestureRecognizer.init(target: self, action: #selector(showChooseCondi(tap:)))
        tapGes1.numberOfTouchesRequired = 1
        BGView.addGestureRecognizer(tapGes1)
        self.view.addSubview(BGView)
        
        
        rechargeView = UINib(nibName:"LNRechargeView",bundle:nil).instantiate(withOwner: self, options: nil).first as! LNRechargeView
        rechargeView.frame =  CGRect(x: 0, y: kSCREEN_HEIGHT-64, width: kSCREEN_WIDTH, height: 380)
        rechargeView.layer.cornerRadius = 24*kSCREEN_SCALE
        rechargeView.rechargeAction = {
            
            if $0 {
                MXWechatPayHandler.jump(toWxPaywithPrice: CGFloat(Float($1)!), andTypeName: "思而慧充值学币")
            }
            self.hiddenViews()
        }
        
        rechargeView.clipsToBounds = true
        self.view.addSubview(rechargeView)
    }
    
    
    func showRechargeView() {
        let y = CGFloat(310)
        UIView.animate(withDuration: 0.5) {
            self.rechargeView.transform = .init(translationX: 0, y: -y)
            self.BGView.alpha = 1
        }
    }
    
}
