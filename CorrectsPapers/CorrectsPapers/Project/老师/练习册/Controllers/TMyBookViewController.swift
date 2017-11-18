//
//  TMyBookViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/20.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class TMyBookViewController: BaseViewController {
    var emptyView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addImageWhenEmpty()
    }
    
    override func configSubViews() {
        
        self.navigationItem.title = "我的练习册"

        mainTableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: kSCREEN_HEIGHT - 64 ), style: .plain)
        mainTableView.dataSource = self;
        mainTableView.delegate = self;
        mainTableView.estimatedRowHeight = 143 * kSCREEN_SCALE;
        mainTableView.register(UINib(nibName: "TMYBooksCell", bundle: nil), forCellReuseIdentifier: identyfierTable)
        mainTableView.tableFooterView = UIView()
        self.view.addSubview(mainTableView)        
    }
    
    
    override func requestData() {
        
        let params =
            ["SESSIONID":SESSIONIDT,
             "mobileCode":mobileCodeT,
             ]

        NetWorkTeacherGetMyWorkList(params: params) { (datas) in
            
            self.mainTableArr.removeAllObjects()
            self.mainTableArr.addObjects(from: datas)
            self.mainTableView.reloadData()
        }
    }
    
    override func refreshHeaderAction() {
        let params =
            ["SESSIONID":SESSIONIDT,
             "mobileCode":mobileCodeT,
             ]
        
        NetWorkTeacherGetMyWorkList(params: params) { (datas) in
            
            self.mainTableArr.removeAllObjects()
            self.mainTableArr.addObjects(from: datas)
            self.mainTableView.reloadData()
            self.mainTableView.mj_header.endRefreshing()
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
        label.text = "暂时没有联系册"
        emptyView.addSubview(label)
        
        let creatBook = UIButton.init(frame: CGRect(x: 0, y: 0, width: 120, height: 30))
        creatBook.setBackgroundImage(getNavigationIMG(27, fromColor: kSetRGBColor(r: 0, g: 200, b: 255), toColor: kSetRGBColor(r: 0, g: 162, b: 255)), for: .normal)
        creatBook.center = CGPoint(x: emptyView.centerX, y: emptyView.centerY + 10 * kSCREEN_SCALE)
        creatBook.setTitle("创建练习册", for: .normal)
        creatBook.layer.cornerRadius = 5
        creatBook.clipsToBounds = true
        creatBook.addTarget(self, action: #selector(creatClassAction(sender:)), for: .touchUpInside)
//        emptyView.addSubview(creatBook)
        
        self.mainTableView.addSubview(emptyView)
    }
    
    
    @objc func creatClassAction(sender:UIButton) {
        
        let createVC = CreateBookViewController()
        
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
        
        let model = mainTableArr[indexPath.row] as! WorkBookModel
        let cell : TMYBooksCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable, for: indexPath) as! TMYBooksCell
        cell.selectionStyle = .default
        cell.TMYBooksCellSetValue(model: model)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let model = mainTableArr[indexPath.row] as! WorkBookModel
        let BookDetailVC = TBookDetailViewController()
        BookDetailVC.book_id = model.id!
        self.navigationController?.pushViewController(BookDetailVC, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let model = mainTableArr[indexPath.row] as! WorkBookModel
        
        if editingStyle == .delete {
            
            let params =
                ["SESSIONID":SESSIONIDT,
                 "mobileCode":mobileCodeT,
                 "workId":model.id
                    ] as! [String:String]

            NetWorkTeacherDelMyWork(params: params, callBack: { (flag) in
                
                if flag {
                    let params =
                        ["SESSIONID":SESSIONIDT,
                         "mobileCode":mobileCodeT,
                         ]
                    NetWorkTeacherGetMyWorkList(params: params) { (datas) in
                        
                        self.mainTableArr.removeAllObjects()
                        self.mainTableArr.addObjects(from: datas)
                        self.mainTableView.reloadData()
                    }
                }
                
            })
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        
        return "删除练习册"
    }
    
}
