//
//  MyFriendViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/17.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class MyFriendViewController: BaseViewController {

    var underLine = UIView()
    var headView = UIView()
    var currentIndex = 123456

    var teachers = [ApplyModel]()
    var students = [ApplyModel]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        rightBarButton()
        addImageWhenEmpty()
    }

    func rightBarButton(){
        let applyBarBtn = UIBarButtonItem.init(image: #imageLiteral(resourceName: "BuddyList_icon_default"), style: .plain, target: self, action: #selector(pushSearchClass(sender:)))
        applyBarBtn.tag = 10086
        
        let addFriendBtn = UIBarButtonItem.init(image: #imageLiteral(resourceName: "AddFriends_icon_default"), style: .plain, target: self, action: #selector(pushSearchClass(sender:)))
        addFriendBtn.tag = 10068

        self.navigationItem.rightBarButtonItems = [addFriendBtn,applyBarBtn]
        
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        
    }
    
    @objc func pushSearchClass(sender:UIBarButtonItem) {
        
        if sender.tag == 10086 {
            
            let applyVC = ApplyListViewController()
            self.navigationController?.pushViewController(applyVC, animated: true)

        }else{
            
            let addFriendVC = AddFriendViewController()
            self.navigationController?.pushViewController(addFriendVC, animated: true)

        }
        
    }

    
    override func requestData() {
        
        netWorkForMyFriend { (datas, success) in
            
            print(datas)
            
            for index in 0..<datas.count {
                
                let model = datas[index] as! ApplyModel
                
                if model.user_type == "1" {
                    self.students.append(model)
                }else{
                    self.teachers.append(model)
                }
            }
            self.mainTableView.reloadData()
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        netWorkForMyFriend { (datas, success) in
            
            self.mainTableArr.removeAllObjects()
            for index in 0..<datas.count {
                
                let model = datas[index] as! ApplyModel
                
                if model.user_type == "1" {
                    self.students.append(model)
                }else{
                    self.teachers.append(model)
                }
            }
            self.mainTableView.reloadData()
        }

    }
    
    override func configSubViews() {
        
        self.navigationItem.title = "我的好友"
        
        headView = UIView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 80*kSCREEN_SCALE+2))
        headView.backgroundColor = UIColor.white
        
        let studBtn = UIButton.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH/2, height: 80*kSCREEN_SCALE))
        studBtn.setTitle("学生", for: .normal)
        studBtn.addTarget(self, action: #selector(changeFriendsType(sender:)), for: .touchUpInside)
        studBtn.setTitleColor(kMainColor(), for: .normal)
        studBtn.tag = 123456
        headView.addSubview(studBtn)
        
        let teachBtn = UIButton.init(frame: CGRect(x: kSCREEN_WIDTH/2, y: 0, width: kSCREEN_WIDTH/2, height: 80*kSCREEN_SCALE))
        teachBtn.setTitle("老师", for: .normal)
        teachBtn.setTitleColor(kGaryColor(num: 117), for: .normal)
        teachBtn.addTarget(self, action: #selector(changeFriendsType(sender:)), for: .touchUpInside)
        teachBtn.tag = 123457
        headView.addSubview(teachBtn)

        let line = UIView.init(frame: CGRect(x: 0, y: 80*kSCREEN_SCALE+1 , width: kSCREEN_WIDTH, height: 1))
        line.backgroundColor = kGaryColor(num: 223)
        headView.addSubview(line)

        underLine = UIView.init(frame: CGRect(x: 0, y: 41.5, width: getLabWidth(labelStr: "粉丝", font: kFont32, height: 1) - 5, height: 2))
        underLine.backgroundColor = kMainColor()
        underLine.layer.cornerRadius = 1
        underLine.clipsToBounds = true
        underLine.center.x = studBtn.center.x
        headView.addSubview(underLine)

        
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
        mainTableArr = ["关于我们","清除缓存","检查更新","关于我们","清除缓存","检查更新","关于我们","清除缓存","检查更新"]
        
    }
    
    
    
    
    @objc func changeFriendsType(sender:UIButton) {
        
        let view = headView.viewWithTag(currentIndex) as! UIButton
        
        if view == sender {
            return
        }
        
        view.setTitleColor(kGaryColor(num: 117), for: .normal)
        sender.setTitleColor(kMainColor(), for: .normal)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.underLine.bounds.size.width = getLabWidth(labelStr: (sender.titleLabel?.text)!, font: kFont32, height: 2)-5
            
            self.underLine.center = CGPoint(x:  sender.center.x, y:  self.underLine.center.y)
        })

        currentIndex = sender.tag
        mainTableView.reloadData()
        
    }
    
    //    当数据为空的时候，显示提示
    var emptyView = UIView()

    func addImageWhenEmpty() {
        emptyView = UIView.init(frame: CGRect(x: 0, y: 80*kSCREEN_SCALE+2, width: kSCREEN_WIDTH, height: kSCREEN_HEIGHT - 46))
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
        label.text = "未发现该类型好友"
        emptyView.addSubview(label)
    }
    

    
    //    ******************代理 ： UITableViewDataSource,UITableViewDelegate  ************
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if currentIndex == 123456 {
            if students.count == 0 {
                self.mainTableView.addSubview(emptyView)
            }else{
                emptyView.removeFromSuperview()
            }

            return students.count
        }
        
        if teachers.count == 0 {
            self.mainTableView.addSubview(emptyView)
        }else{
            emptyView.removeFromSuperview()
        }

        return  teachers.count
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var model = ApplyModel()
        
        if currentIndex == 123456 {
            model = students[indexPath.section]
        }else{
            model = teachers[indexPath.section]
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identyfierTable, for: indexPath) as! ShowFridensCell
        cell.ShowFridensCellForShowFriend(model: model)
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
//            let params =
//                [
//                    "workBookId":model.work_book_Id,
//                    "SESSIONID":SESSIONID,
//                    "mobileCode":mobileCode
//            ]
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        
        return "删除"
    }
    

}
