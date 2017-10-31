//
//  Complaint ViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/14.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class ComplaintViewController: BaseViewController ,UITextFieldDelegate,UITextViewDelegate{
    
    var tipTextField = UITextField()
    var content = UITextView()
    
    var selectArr = NSMutableArray()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rightBarButton()
    }
 
    override func leftBarButton() {
        
    }
    
    func rightBarButton(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "提交", style: .plain, target: self, action: #selector(pushSearchClass(sender:)))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
    }

    @objc func pushSearchClass(sender:UIBarButtonItem) {
    
    }
    
    override func configSubViews() {
        
        mainTableArr = ["未批改","未按时批改","批改错误","其他"]
        
        mainTableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: kSCREEN_HEIGHT - 64 ), style: .plain)
        mainTableView.dataSource = self;
        mainTableView.delegate = self;
        mainTableView.rowHeight = 42;
        mainTableView.register(UINib(nibName: "ComplaintCell", bundle: nil), forCellReuseIdentifier: identyfierTable)
        self.view.addSubview(mainTableView)

        let footView = UIView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 250))
        
        content = UITextView.init(frame: CGRect(x: 15, y: 30, width: kSCREEN_WIDTH-30, height: 200))
        content.layer.cornerRadius = 5
        content.font = kFont34
        content.layer.borderColor = kGaryColor(num: 221).cgColor
        content.delegate = self
        content.layer.borderWidth = 1
        self.view.addSubview(content)
        
        tipTextField = UITextField.init(frame: CGRect(x: 0, y: 8, width: kSCREEN_WIDTH, height: 21))
        tipTextField.placeholder = " 填写投诉原因...."
        tipTextField.borderStyle = .none
        tipTextField.delegate = self
        content.addSubview(tipTextField)
        
        footView.addSubview(content)
        
        mainTableView.tableFooterView = footView
    }
    
    //MARK:  ******代理 ：UITableViewDataSource,UITableViewDelegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainTableArr.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : ComplaintCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable, for: indexPath) as! ComplaintCell
        cell.selectionStyle = .default
        
        var isSelect = false
        
        if selectArr.contains(mainTableArr[indexPath.row] as! String) {
            isSelect = true
        }
        
        cell.complaintValues(flag: isSelect,title1:mainTableArr[indexPath.row] as! String)
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if selectArr.contains( mainTableArr[indexPath.row] as! String) {
            selectArr.remove(mainTableArr[indexPath.row])
            
        }else{
            selectArr.add(mainTableArr[indexPath.row])
        }
        
       tableView.reloadData()
        
    }

    //    MARK:UITextViewDelegate
    func textViewDidChange(_ textView: UITextView) {
        
        if textView.text.count == 0 {
            tipTextField.isHidden = false
        }else{
            tipTextField.isHidden = true
        }
        
    }
    
    
    //    MARK:UITextFieldDelegate
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        tipTextField.isHidden = true
        content.becomeFirstResponder()
        return true
    }


}
