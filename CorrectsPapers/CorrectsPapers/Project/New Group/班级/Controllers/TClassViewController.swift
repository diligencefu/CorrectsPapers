//
//  TClassViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/20.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class TClassViewController: BaseViewController {
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
            "SESSIONID":SESSIONIDT,
            "mobileCode":mobileCodeT
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
    
    
    override func refreshHeaderAction() {
        let params = [
            "SESSIONID":SESSIONIDT,
            "mobileCode":mobileCodeT
        ]
        netWorkForMyClass(params: params) { (datas,flag) in
            if flag {
                self.mainTableArr.removeAllObjects()
                self.mainTableArr.addObjects(from: datas)
                self.mainTableView.reloadData()
            }
            self.view.endLoading()
            self.mainTableView.mj_header.endLoading()
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
    
    
    func rightBarButton(){
        let createClass = UIBarButtonItem.init(image:#imageLiteral(resourceName: "create-class_icon"), style: .plain, target: self, action: #selector(pushSearchClass(sender:)))
        createClass.tag = 10086
        
        let searchClass = UIBarButtonItem.init(image: #imageLiteral(resourceName: "lookup_icon_default"), style: .plain, target: self, action: #selector(pushSearchClass(sender:)))
        searchClass.tag = 10068
        
        self.navigationItem.rightBarButtonItems = [searchClass,createClass,]
        
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        
    }
    
    @objc func pushSearchClass(sender:UIBarButtonItem) {
        
        if sender.tag == 10086 {
            
            let createClass = TCreateClassViewController()
            self.navigationController?.pushViewController(createClass, animated: true)
            
        }else{
            
            let searchClass = TSearchClassViewController()
            self.navigationController?.pushViewController(searchClass, animated: true)
            
        }
        
    }
    
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
        creatBook.setTitle("立即创建班级", for: .normal)
        creatBook.layer.cornerRadius = 5
        creatBook.clipsToBounds = true
        creatBook.addTarget(self, action: #selector(creatClassAction(sender:)), for: .touchUpInside)
        emptyView.addSubview(creatBook)
        
    }
    
    
    @objc func creatClassAction(sender:UIButton) {
        
        let createVC = TCreateClassViewController()
        
        self.navigationController?.pushViewController(createVC, animated: true)
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
//        let editorVC = QQQEditorViewController(nibName: "QQQEditorViewController", bundle: nil)
//        editorVC.images = [#imageLiteral(resourceName: "wocao")]
//        editorVC.theName = "刘二蛋"
//        editorVC.theNum = "学号 008"
//        self.present(editorVC, animated: true, completion: nil)
        
        let model = mainTableArr[indexPath.row] as! ClassModel
        let classVC = TClassDetailViewController()
        classVC.classid = model.classes_id
        self.navigationController?.pushViewController(classVC, animated: true)

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
                "SESSIONID":SESSIONIDT,
                "mobileCode":mobileCodeT,
                "classes_id":model.classes_id
            ] as [String:Any]
            
            NetWorkTeacherDeleteMyclasses(params: params, callBack: { (flag) in
                
            })
            
            mainTableArr.removeObject(at: indexPath.row)
            tableView.reloadData()
            print("删除了---\(indexPath.section)分区-\(indexPath.row)行")
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        
        let model = mainTableArr[indexPath.row] as! ClassModel
        
        if model.is_head_teacher == "yes" {
            return "解散班级"
        }
        return "退出班级"
    }
    
}

