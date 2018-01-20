//
//  CreditRankViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/8.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import MJRefresh
import SwiftyUserDefaults

class CreditRankViewController: BaseViewController {

    var ruleImage = UIImageView()
    
    
    
    var myRank = ""
    var myScore = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showRule()
        rightBarButton()
        addShareView()
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
            shareParames.ssdkSetupShareParams(byText: "关于"+Defaults[username]!+"成绩分享",
                                              images : UIImage(named: "AppIcon.png"),
                                              url : NSURL(string:"https://github.com/diligencefu/CorrectsPapers/commits/master") as URL!,
                                              title : Defaults[username]!+"同学在独立完成作业方面目前全国排名:第"+self.myRank+"名",
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
        let y = 235
        
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
    
    
    override func requestData() {
        self.view.beginLoading()
        refreshHeaderAction()
    }
    
    override func refreshHeaderAction() {
        let params =
            [
                "SESSIONID":Defaults[userToken]!,
                "mobileCode":mobileCode
                ] as [String:Any]
        netWorkForGetStudentScoress(params: params) { (datas,myRank,myScore,flag) in
            if flag {
                
                self.myRank = myRank
                self.myScore = myScore
                self.mainTableArr.removeAllObjects()
                self.mainTableArr.addObjects(from: datas)
                self.mainTableView.reloadData()
            }
            self.mainTableView.mj_header.endRefreshing()
            self.view.endLoading()
        }

    }
    
    
    
    //    右键
    func rightBarButton() {
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: #imageLiteral(resourceName: "share_icon"), style: .plain, target: self, action: #selector(shareRank(sender:)))
        
    }
    
    
    @objc func shareRank(sender:UIBarButtonItem) {

        showShareView()
    }
    
    override func configSubViews() {
        
        self.navigationItem.title = "学分排行"
        
        mainTableView = UITableView.init(frame: CGRect(x: 0,
                                                       y: 0,
                                                       width: kSCREEN_WIDTH,
                                                       height: kSCREEN_HEIGHT - 64),
                                         style: .grouped)
        mainTableView.dataSource = self;
        mainTableView.delegate = self;
        mainTableView.estimatedRowHeight = 44
        mainTableView.register(UINib(nibName: "RankCell", bundle: nil), forCellReuseIdentifier: identyfierTable)
        self.view.addSubview(mainTableView)
        mainTableView.backgroundColor = kSetRGBColor(r: 239, g: 239, b: 244)
        
    }
    
    
    func showRule() {
        ruleImage = UIImageView.init(frame: CGRect(x: kSCREEN_WIDTH-300*kSCREEN_SCALE-5, y: 30, width: 300*kSCREEN_SCALE, height: 260*kSCREEN_SCALE))
        ruleImage.image = #imageLiteral(resourceName: "ts_bg")
        
        let label = UILabel.init(frame: CGRect(x: 0, y: 10, width: ruleImage.width, height: ruleImage.height-10))
        label.text = "学分规则说明\n5星作业加5学分;\n4星作业加4学分;\n3星作业加3学分;\n2星作业加2学分;\n1星作业加1学分."
        label.font = kFont24
        let attributeText = NSMutableAttributedString.init(string: label.text!)
        //设置段落属性
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2     //设置行间距
        attributeText.addAttributes([NSAttributedStringKey.paragraphStyle: paragraphStyle], range: NSMakeRange(0, (label.text?.count)!))
        attributeText.addAttributes([NSAttributedStringKey.font:  kFont28], range: NSMakeRange(0, 6))
        attributeText.addAttributes([NSAttributedStringKey.foregroundColor: kGaryColor(num: 117)], range: NSMakeRange(0,  6))
        attributeText.addAttributes([NSAttributedStringKey.font:  kFont24], range: NSMakeRange(6, label.text!.count-6))
        attributeText.addAttributes([NSAttributedStringKey.foregroundColor: kGaryColor(num: 176)], range: NSMakeRange(6, (label.text?.count)!-6))
        //                attributeText.addAttributes([NSAttributedStringKey.foregroundColor: UIColor.black], range: NSMakeRange(0, 5))
        
        //  result.centerY = showLabel.centerY
        label.attributedText = attributeText

        label.numberOfLines = 0
        label.textAlignment = .center
        ruleImage.addSubview(label)
        ruleImage.alpha = 0
        self.view.addSubview(ruleImage)
//        mainTableView.bringSubview(toFront: ruleImage)
    }
    
    
    //    ******************代理 ： UITableViewDataSource,UITableViewDelegate  ************
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        }
        
//        return  mainTableArr.count
        return mainTableArr.count
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identyfierTable, for: indexPath) as! RankCell
        
        if indexPath.section == 0 {
            
            cell.showMyRank(ranking: myRank, score: myScore)
        }else{
            
            let model = mainTableArr[indexPath.row] as! LNShowRankModel
            var isme = false
            if Int(myRank) == indexPath.row+1 {
                isme = true
            }
            if indexPath.row < 3{
                
                cell.showTopThreeRank(model: model, isme: isme)
                
            }else{
                
                cell.showAfterThirdPlaceRank(model: model, isme: isme)
            }
        }
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        ruleImage.alpha = 0

    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 20*kSCREEN_SCALE))
        view.backgroundColor = kGaryColor(num: 244)
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 76*kSCREEN_SCALE))
        view.backgroundColor = kGaryColor(num: 244)

        let showLabel = UILabel.init(frame: CGRect(x: 0, y: 20*kSCREEN_SCALE, width: kSCREEN_WIDTH, height: 56*kSCREEN_SCALE))
        showLabel.text = "    学分排行榜"
        showLabel.font = kFont26
        showLabel.textColor = kGaryColor(num: 117)
        showLabel.backgroundColor = UIColor.white
        showLabel.textAlignment = .left
        showLabel.isAttributedContent = true
        view.addSubview(showLabel)

        if section == 0 {
            showLabel.text = "    我的学分"
            let btn = UIButton.init(frame: CGRect(x: kSCREEN_WIDTH-(15+kSCREEN_SCALE*50), y: 0, width: 50*kSCREEN_SCALE, height: 50*kSCREEN_SCALE))
            btn.setImage(#imageLiteral(resourceName: "help_icon"), for: .normal)
            btn.centerY = showLabel.centerY
            btn.addTarget(self, action: #selector(showTheRule(sender:)), for: .touchUpInside)
            view.addSubview(btn)
        }
        
        return view
    }
    
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {

        return 0
    }
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 76*kSCREEN_SCALE
    }
    
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        ruleImage.alpha = 0
    }
    
    @objc func showTheRule(sender:UIButton) {
        setToast(str: "show rule")
        if ruleImage.alpha == 0 {
            ruleImage.alpha = 1
        }else{
            ruleImage.alpha = 0
        }
    }
    
}
