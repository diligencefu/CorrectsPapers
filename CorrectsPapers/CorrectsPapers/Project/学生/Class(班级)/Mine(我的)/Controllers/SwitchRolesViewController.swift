//
//  SwitchRolesViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/16.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class SwitchRolesViewController: BaseViewController {
    var selectArr = NSMutableArray()
    
    var  currentRole = kStudent
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func configSubViews() {
        
        mainTableArr = ["学生","老师"]
        
        mainTableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: kSCREEN_HEIGHT - 64 ), style: .grouped)
        mainTableView.dataSource = self;
        mainTableView.delegate = self;
        mainTableView.rowHeight = 42;
        mainTableView.register(UINib(nibName: "ComplaintCell", bundle: nil), forCellReuseIdentifier: identyfierTable)
        self.view.addSubview(mainTableView)
        
        let footView = UIView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 120))
        //        footView.backgroundColor = kSetRGBColor(r: 239, g: 239, b: 244)
        let switchRole = UIButton.init(frame: CGRect(x: 60 * kSCREEN_SCALE, y: 50, width: kSCREEN_WIDTH - 120 * kSCREEN_SCALE, height: 86 * kSCREEN_SCALE))
        //        footView.backgroundColor = UIColor.brown
        switchRole.layer.cornerRadius = 6
        switchRole.clipsToBounds = true
        switchRole.setTitle("切换", for: .normal)
        switchRole.setTitleColor(UIColor.white, for: .normal)
        switchRole.setBackgroundImage(getNavigationIMG(27, fromColor: kSetRGBColor(r: 0, g: 200, b: 255), toColor: kSetRGBColor(r: 0, g: 162, b: 255)), for: .normal)
        switchRole.addTarget(self, action: #selector(changeRoles(sender:)), for: .touchUpInside)
            footView.addSubview(switchRole)
            mainTableView.tableFooterView = footView
        
    }
    
    //    MARK:提交
    @objc func changeRoles(sender:UIButton) {
        
        
        if currentRole == Defaults[userIdentity] {
            setToast(str: "你当前的角色已经是老师")
            return
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            
//            if self.currentRole == kTeacher {
//                Defaults[userIdentity] = kTeacher
//
//            }else{
//                Defaults[userIdentity] = kStudent
//            }

            Defaults[userIdentity] = self.currentRole
            
//            self.navigationController?.popViewController(animated: true)
            
            self.view.window?.rootViewController = MainTabBarController()
            
        }
        
        if self.currentRole == kStudent {
            setToast(str: "已切换角色为学生")
        }
        
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
        
        if currentRole == kTeacher {
           
            if indexPath.row == 1 {
                isSelect = true
            }
            
        }else{
            
            if indexPath.row == 0 {
                isSelect = true
            }
        }
        
        cell.complaintValues(flag: isSelect,title1:mainTableArr[indexPath.row] as! String)
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            currentRole = kStudent
        }else{
            currentRole = kTeacher
        }
        
        tableView.reloadData()
        
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 19 * kSCREEN_SCALE))
        view.backgroundColor = UIColor.blue
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 19 * kSCREEN_SCALE))
        view.backgroundColor = kSetRGBColor(r: 239, g: 239, b: 244)
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 19 * kSCREEN_SCALE
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01 * kSCREEN_SCALE
    }

}
