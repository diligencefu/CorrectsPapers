//
//  AddFriendViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/17.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class AddFriendViewController: BaseViewController {
    
    var searchView = UITextField()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configSubViews() {
        
        self.navigationItem.title = "添加好友"
        
        searchView = UITextField.init(frame: CGRect(x: 0, y: 20*kSCREEN_SCALE, width: kSCREEN_WIDTH, height: 88*kSCREEN_SCALE))
        searchView.backgroundColor = kGaryColor(num: 255)
        searchView.placeholder = " 学生姓名/学生学号/老师姓名/老师工号"
        searchView.font = kFont30
        
        let searchBtn = UIButton.init(frame: CGRect(x: 20, y: 156*kSCREEN_SCALE, width: kSCREEN_WIDTH - 40, height: 72*kSCREEN_SCALE))
        searchBtn.backgroundColor = UIColor.gray
        searchBtn.setTitle("查找", for: .normal)
        searchBtn.setTitleColor(UIColor.white, for: .normal)
        searchBtn.layer.cornerRadius = 10*kSCREEN_SCALE
        searchBtn.clipsToBounds = true
        searchBtn.titleLabel?.font = kFont34
        searchBtn.setBackgroundImage(getNavigationIMG(27, fromColor: kSetRGBColor(r: 0, g: 200, b: 255), toColor: kSetRGBColor(r: 0, g: 162, b: 255)), for: .normal)
        searchBtn.addTarget(self, action: #selector(searchFriendAction(sender:)), for: .touchUpInside)
        
        let headView = UIView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 276*kSCREEN_SCALE))
        headView.backgroundColor = kGaryColor(num: 244)
        headView.addSubview(searchBtn)
        headView.addSubview(searchView)
        

        mainTableView = UITableView.init(frame: CGRect(x: 0,
                                                       y: 0,
                                                       width: kSCREEN_WIDTH,
                                                       height: kSCREEN_HEIGHT - 64 ),
                                         style: .grouped)
        mainTableView.dataSource = self;
        mainTableView.delegate = self;
        mainTableView.estimatedRowHeight = 44
        mainTableView.register(UINib(nibName: "ShowFridensCell", bundle: nil), forCellReuseIdentifier: identyfierTable)
        self.view.addSubview(mainTableView)
        mainTableView.tableHeaderView = headView
        mainTableView.backgroundColor = kSetRGBColor(r: 239, g: 239, b: 244)
    }
    
    @objc func searchFriendAction(sender:UIButton) {
        
//        mainTableArr = ["关于我们","清除缓存","清除缓存","清除缓存","清除缓存","清除缓存","清除缓存","检查更新"]
        
        
        if searchView.text != "" {
            
            var params = ["":""]
            
            let decimal = NSDecimalNumber(string: searchView.text)
            print(decimal.intValue)
            if decimal.floatValue == 9 {
                params =
                    [
                        "name":searchView.text!,
                        "SESSIONID":SESSIONID,
                        "mobileCode":mobileCode
                    ]
            }else{
                params =
                    [
                        "num":searchView.text!,
                        "SESSIONID":SESSIONID,
                        "mobileCode":mobileCode
                ]
            }
            
            netWorkForGetSpecifiedUser(params: params, callBack: { (datas) in
                
            })
            
        }else{
            
            netWorkForGetAllPeope(callBack: { (datas) in
                
            })
            
        }
                
        mainTableView.reloadData()
    }
    
    
    //    ******************代理 ： UITableViewDataSource,UITableViewDelegate  ************
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  mainTableArr.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identyfierTable, for: indexPath) as! ShowFridensCell
        cell.ShowFridensCellForAddFriend()
        cell.addFriendsBlock = {
            print($0)
            self.addFriendsAction()
        }
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 19 * kSCREEN_SCALE))
        view.backgroundColor = UIColor.blue
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 && mainTableArr.count > 0{
            let showLabel = UILabel.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 21))
            showLabel.text = "   共找到\(mainTableArr.count)人  "
            showLabel.font = kFont28
            
            showLabel.isAttributedContent = true
            showLabel.textColor = kGaryColor(num: 176)
            
            let attributeText = NSMutableAttributedString.init(string: showLabel.text!)
            let count = String(mainTableArr.count).characters.count
            //设置段落属性
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 2     //设置行间距
            attributeText.addAttributes([NSAttributedStringKey.paragraphStyle: paragraphStyle], range: NSMakeRange(0, (showLabel.text?.characters.count)!))
            attributeText.addAttributes([NSAttributedStringKey.font:  kFont28], range: NSMakeRange(0, (showLabel.text?.characters.count)!))
            attributeText.addAttributes([NSAttributedStringKey.foregroundColor: kSetRGBColor(r: 255, g: 153, b: 0)], range: NSMakeRange(6,  count))
            
            showLabel.attributedText = attributeText
            
            return showLabel
        }
        
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 19 * kSCREEN_SCALE))
        view.backgroundColor = kSetRGBColor(r: 239, g: 239, b: 244)
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 21
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01 * kSCREEN_SCALE
    }
    
    
    //    网络请求
    
    func addFriendsAction() {
    
        let params = [
            "SESSIONID":SESSIONID,
            "mobileCode":mobileCode,
            "userbyId":"1",
            ]
        netWorkForApplyFriend(params: params) { (flag) in
            
        }
    }
}

