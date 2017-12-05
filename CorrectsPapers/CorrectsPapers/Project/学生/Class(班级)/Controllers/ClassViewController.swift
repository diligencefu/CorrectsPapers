//
//  ClassViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/10.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class ClassViewController: BaseViewController {
    var emptyView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        rightBarButton()
        addImageWhenEmpty()
    }

    override func leftBarButton() {
        
    }
    
    
    override func requestData() {
        let params = [
            "SESSIONID":SESSIONID,
            "mobileCode":mobileCode
        ]
        self.view.beginLoading()
        netWorkForMyClass(params: params) { (datas,flag) in
            if flag {
                
                self.mainTableArr.removeAllObjects()
                self.mainTableArr.addObjects(from: datas)
                self.mainTableView.reloadData()
            }
            self.view.endLoading()
        }
    }
    
    
    override func configSubViews() {
        
        self.navigationItem.title = "我的班级"
                
        mainTableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: kSCREEN_HEIGHT - 64 ), style: .plain)
        mainTableView.dataSource = self;
        mainTableView.delegate = self;
        mainTableView.estimatedRowHeight = 143 * kSCREEN_SCALE;
        mainTableView.register(UINib(nibName: "ClassCell", bundle: nil), forCellReuseIdentifier: identyfierTable)
        mainTableView.tableFooterView = UIView()
        self.view.addSubview(mainTableView)
    }
    
    fileprivate func extractedFunc(_ params: [String : String]) {
        
        self.view.beginLoading()
        netWorkForMyClass(params: params) { (datas,flag) in
            
            if flag {
                self.mainTableArr.removeAllObjects()
                self.mainTableArr.addObjects(from: datas)
                self.mainTableView.reloadData()
            }
            self.view.endLoading()
        }
    }
    
    override func refreshHeaderAction() {
        let params = [
            "SESSIONID":SESSIONID,
            "mobileCode":mobileCode
        ]
        self.view.beginLoading()
        netWorkForMyClass(params: params) { (datas,flag) in
            
            if flag {
                self.mainTableArr.removeAllObjects()
                self.mainTableArr.addObjects(from: datas)
                self.mainTableView.reloadData()
            }
            self.view.endLoading()
            self.mainTableView.mj_header.endRefreshing()
        }

    }

    
    func rightBarButton() {
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: #imageLiteral(resourceName: "lookup_icon_default"), style: .plain, target: self, action: #selector(pushSearchClass(sender:)))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white

    }
    
    
    @objc func pushSearchClass(sender:UIBarButtonItem) {
        
        let searchVC = SearchClassViewController()
        
        self.navigationController?.pushViewController(searchVC, animated: true)
    }
    
    
    //    当数据为空的时候，显示提示
    
    //    当数据为空的时候，显示提示
    func addImageWhenEmpty() {
        
        emptyView = UIView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: kSCREEN_HEIGHT - 46))
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
        label.text = "暂时没有班级"
        emptyView.addSubview(label)
        
        let creatBook = UIButton.init(frame: CGRect(x: 0, y: 0, width: 120, height: 30))
        creatBook.setBackgroundImage(getNavigationIMG(27, fromColor: kSetRGBColor(r: 0, g: 200, b: 255), toColor: kSetRGBColor(r: 0, g: 162, b: 255)), for: .normal)
        creatBook.center = CGPoint(x: emptyView.centerX, y: emptyView.centerY + 10 * kSCREEN_SCALE)
        creatBook.setTitle("查找班级", for: .normal)
        creatBook.layer.cornerRadius = 5
        creatBook.clipsToBounds = true
        creatBook.addTarget(self, action: #selector(creatClassAction(sender:)), for: .touchUpInside)
        emptyView.addSubview(creatBook)
        
    }
    
    
    @objc func creatClassAction(sender:UIButton) {
    
        let searchVC = SearchClassViewController()
        
        self.navigationController?.pushViewController(searchVC, animated: true)
    }

    
    //MARK:  ******代理 ：UITableViewDataSource,UITableViewDelegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if mainTableArr.count == 0 {
            self.mainTableView.addSubview(emptyView)
        }else{
            emptyView.removeFromSuperview()
        }
        
        return mainTableArr.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = mainTableArr[indexPath.row] as! ClassModel
        let cell : ClassCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable, for: indexPath) as! ClassCell
        cell.selectionStyle = .default
        cell.classCellSetValue(model: model, isSearch: false)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailVC = ClassDetailViewController()
        
        self.navigationController?.pushViewController(detailVC, animated: true)

    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let model = mainTableArr[indexPath.row] as! ClassModel
            let params = [
                "SESSIONID":SESSIONID,
                "classes_id":model.classes_id,
                "mobileCode":mobileCode
                ] as [String:Any]
            netWorkForQuitClass(params: params, callBack: { (flag) in
                
            })

//            mainTableArr.removeObject(at: indexPath.row)
//            tableView.reloadData()
            deBugPrint(item: "删除了---\(indexPath.section)分区-\(indexPath.row)行")
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {

        if indexPath.row%3 == 0 {
            return "解散班级"
        }
        
        return "退出班级"
    }

    
    
//    
//    if currentIndex == 1 {
//    let cell : ShowClassMemberCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable5, for: indexPath) as! ShowClassMemberCell
//    return cell
//    
//    }
//    
//    
//    if currentIndex == 2 {
//    let cell : TClassInfoCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable6, for: indexPath) as! TClassInfoCell
//    return cell
//    }
//    
//    let cell : TGoodWorkCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable7, for: indexPath) as! TGoodWorkCell
//    cell.TGoodWorkCellSetValueForGreade(count: indexPath.row+1)
//    return cell
}
