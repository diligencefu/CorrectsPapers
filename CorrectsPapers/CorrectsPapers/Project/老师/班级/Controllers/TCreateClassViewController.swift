//
//  TCreateClassViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/21.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class TCreateClassViewController: BaseViewController {
    
    var dataArr = [Array<String>]()
    var infoArr = [Array<String>]()
    
    var teachers = ["班主任","添加助教老师"]
    var students = ["批量添加学生"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rightBarButton()
    }
    
    func rightBarButton() {
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "完成", style: .plain, target: self, action: #selector(classCreateDone(sender:)))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        
    }
    
    
    @objc func classCreateDone(sender:UIBarButtonItem) {
        let params = [
            "SESSIONID":"1",
            "mobileCode":"on",
            "classPhoto":"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image%26quality=100%26size=b4000_4000%26sec=1509332899%26di=e437533fc8f920fcc2c7782014f3d5ff%26src=http://i8.hexunimg.cn/2011-09-15/133395549.jpg",
            "className":"我的班级",
            "deliveryCycle":"1天",
            "deadline":"19:00-20:00",
            "workTimes":"12",
            "headTeacher":"六大",
            "user":"001,002,003",
            "classSize":"55",
            "friendId":"1,2,3"
        ]
        
        netWorkForInsertClasses(params: params) { (str) in
            
        }
        
    }
    
    
    override func configSubViews() {
        
        self.navigationItem.title = "创建班级"
        
        dataArr = [["班级头像","班级名字"],["交作业周天","交作业截止时间","本学期交作业次数"],teachers,students]
        infoArr = [["",""],["按天","18:00前","次"],["吴老师",""],[""]]
        
        mainTableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: kSCREEN_HEIGHT - 64 ), style: .grouped)
        mainTableView.dataSource = self;
        mainTableView.delegate = self;
        mainTableView.estimatedRowHeight = 143 * kSCREEN_SCALE;
        mainTableView.register(UINib(nibName: "CreateClassCell", bundle: nil), forCellReuseIdentifier: identyfierTable)
        mainTableView.register(UINib(nibName: "ShowFridensCell", bundle: nil), forCellReuseIdentifier: identyfierTable1)
        mainTableView.register(UINib(nibName: "CreateClassCell2", bundle: nil), forCellReuseIdentifier: identyfierTable2)
        mainTableView.register(UINib(nibName: "CreateHeadCell", bundle: nil), forCellReuseIdentifier: identyfierTable3)
        
        self.view.addSubview(mainTableView)
        
    }
    
    
    //MARK:  ******代理 ：UITableViewDataSource,UITableViewDelegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 2 {
            return teachers.count
        }
        
        if section == 3 {
            return students.count
        }
        
        return dataArr[section].count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return dataArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : CreateClassCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable, for: indexPath) as! CreateClassCell
        cell.selectionStyle = .default
        
        let cell2 : CreateClassCell2 = tableView.dequeueReusableCell(withIdentifier: identyfierTable2, for: indexPath) as! CreateClassCell2
        cell2.selectionStyle = .default
        
        if indexPath.section == 0 && indexPath.row == 0{
            let cellHead : CreateHeadCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable3, for: indexPath) as! CreateHeadCell
            cellHead.selectionStyle = .default
            return cellHead
        }
        
        if indexPath.section == 0 && indexPath.row == 1 {
            
            cell2.CreateClassCell2ShowAll(title: dataArr[indexPath.section][indexPath.row], info: infoArr[indexPath.section][indexPath.row],placeholder:"字数限制16字以内...")
            return cell2
            
        }else if indexPath.section == 1 &&  indexPath.row == 2 {
            cell2.CreateClassCell2ShowAll(title: dataArr[indexPath.section][indexPath.row], info: infoArr[indexPath.section][indexPath.row],placeholder:"填写次数")
            return cell2
            
        }else if indexPath.section == 2  {
            
            if indexPath.row == 0 {
                cell.CreateClassCellNormal(title: dataArr[indexPath.section][indexPath.row], name: infoArr[indexPath.section][indexPath.row])
                return cell
                
            }else if indexPath.row == 1 {
                cell2.CreateClassCell2(title: teachers[indexPath.row])
                return cell2
                
            }else{
                let cell : ShowFridensCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable1, for: indexPath) as! ShowFridensCell
                cell.ShowFridensCellForShowFriend()
                return cell
            }
            
        }else if indexPath.section == 3{
            
            if indexPath.row == 0 {
                cell2.CreateClassCell2(title: students[indexPath.row])
                
                return cell2
            }else{
                let cell : ShowFridensCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable1, for: indexPath) as! ShowFridensCell
                cell.ShowFridensCellForShowFriend()
                return cell
                
            }
        }else{
            cell.CreateClassCellNormal(title: dataArr[indexPath.section][indexPath.row], name: infoArr[indexPath.section][indexPath.row])
            return cell
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 2  && indexPath.row == 1  {
            
            let chooseTeacher = TChooseMemberViewController()
            chooseTeacher.selectArr = teachers
            chooseTeacher.chooseMemberBlock = {
                
                for index in 0..<$0.count {
                    if !self.teachers.contains($0[index]) {
                        self.teachers.append($0[index])
                    }
                }
                
                tableView.reloadSections([2], with: .automatic)
            }
            
            self.navigationController?.pushViewController(chooseTeacher, animated: true)
        }
        
        if indexPath.section == 3  && indexPath.row == 0  {
            
            let chooseStudent = TChooseMemberViewController()
            chooseStudent.selectArr = students
            chooseStudent.chooseMemberBlock = {
                
                for index in 0..<$0.count {
                    
                    if !self.students.contains($0[index]) {
                        self.students.append($0[index])
                    }
                }
                
                tableView.reloadSections([3], with: .automatic)
            }
            
            self.navigationController?.pushViewController(chooseStudent, animated: true)
            
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 12))
        view.backgroundColor = kGaryColor(num: 244)
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 3 {
            let showLabel = UILabel.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 19))
            showLabel.text = "     目前已添加\(students.count-1)人"
            showLabel.font = kFont26
            showLabel.textColor = kGaryColor(num: 176)
            showLabel.textAlignment = .left
            showLabel.isAttributedContent = true
            
            let attributeText = NSMutableAttributedString.init(string: showLabel.text!)
            
            let count = String(mainTableArr.count).characters.count
            //设置段落属性
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 2     //设置行间距
            attributeText.addAttributes([NSAttributedStringKey.paragraphStyle: paragraphStyle], range: NSMakeRange(0, (showLabel.text?.characters.count)!))
            attributeText.addAttributes([NSAttributedStringKey.font:  kFont28], range: NSMakeRange(0, (showLabel.text?.characters.count)!))
            attributeText.addAttributes([NSAttributedStringKey.foregroundColor: kSetRGBColor(r: 255, g: 153, b: 0)], range: NSMakeRange(10,  count))
            showLabel.attributedText = attributeText
            //            showLabel.textAlignment = .right
            showLabel.font = kFont26
            showLabel.backgroundColor = UIColor.white
            return showLabel
        }
        
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 12))
        view.backgroundColor = kGaryColor(num: 244)
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        if section == 2 {
            return 12
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 3 {
            return 25
        }
        
        return 12
    }
    
}

