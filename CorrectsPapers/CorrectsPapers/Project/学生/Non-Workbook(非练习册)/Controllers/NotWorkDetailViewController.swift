//
//  NotWorkDetailViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/16.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyJSON

class NotWorkDetailViewController: BaseViewController,HBAlertPasswordViewDelegate{
    
    var typeArr = NSMutableArray()
    var headView = UIView()
    var underLine = UIView()
    var footBtnView = UIView()

    var currentIndex = 1
    var images = NSMutableArray()
    var showDateView = UIView()
    var dateBtn = UIButton()
    
    var workModel = NotWorkDetailModel()
    var pointArr = NSMutableArray()
    var answerArr = NSMutableArray()
    var gradeArr = NSMutableArray()
    
    var titleArr3 = ["作业视频讲解","作业答案文档下载","文字版答案"]
    var currentTitle2 = ""
    
    let identyfierTable6 = "identyfierTable6"
    let identyfierTable7 = "identyfierTable7"
    let identyfierTable8 = "identyfierTable8"
    let identyfierTable9 = "identyfierTable9"
    let identyfierTable10 = "identyfierTable10"
    let identyfierTable11 = "identyfierTable11"
    let identyfierTable12 = "identyfierTable12"

    var model = SNotWorkModel()
    
    var workVideoModel = PayModel()
    var workAnswerModel = PayModel()
    var workTextModel = PayModel()
    
    var payModels = NSMutableArray()
    
    var type = ["1","2","3"]
    
    
    var state = ""

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func requestData() {
        
        let params =
            [
                "non_exercise_Id":model.non_exercise_id,
                "SESSIONID":SESSIONID,
                "mobileCode":mobileCode
        ] as [String:Any]

        NetWorkStudentGetAllnon_exercise(params: params) { (dataArr,flag) in
            
            if flag {
                
                if dataArr.count > 0{
                    self.workModel = dataArr[0] as! NotWorkDetailModel
                    self.state = self.workModel.correct_states
                    self.mainTableView.reloadData()
                }
            }
            print(dataArr)
        }
        
        if Int(model.correct_states)! > Int(3) {
            let params1 =
                [
                    "bookId":model.non_exercise_id,
                    "SESSIONID":SESSIONID,
                    "mobileCode":mobileCode
                    ] as [String:Any]
            NetWorkStudentCheckPay(params: params1) { (pays,flag) in
                deBugPrint(item: pays)
                if flag && pays.count > 0{
                    self.payModels.addObjects(from: pays)
                    
                    if pays.count == 1 {
                        self.workVideoModel = self.payModels[0] as! PayModel
                    }
                    
                    if pays.count == 2 {
                        self.workAnswerModel = self.payModels[1] as! PayModel
                    }
                    
                    if pays.count == 3 {
                        self.workTextModel = self.payModels[2] as! PayModel
                    }
                    
                    if self.workVideoModel.isPay != "no" {
                        self.titleArr3.remove(at: self.titleArr3.index(of: "作业视频讲解")!)
                        self.type.remove(at: self.type.index(of: "1")!)
                    }
                    
                    if self.workAnswerModel.isPay != "no" {
                        self.titleArr3.remove(at: self.titleArr3.index(of: "作业答案文档下载")!)
                        self.type.remove(at: self.type.index(of: "2")!)
                    }
                    
                    if self.workTextModel.isPay != "no" {
                        self.titleArr3.remove(at: self.titleArr3.index(of: "文字版答案")!)
                        self.type.remove(at: self.type.index(of: "3")!)
                    }
                    self.footView(titles: self.titleArr3)
                }
            }
        }
        
    }
    
    override func refreshHeaderAction() {
        if currentIndex == 1 {
            let params =
                [
                    "non_exercise_Id":model.non_exercise_id,
                    "SESSIONID":SESSIONID,
                    "mobileCode":mobileCode
                    ] as [String:Any]
            
            NetWorkStudentGetAllnon_exercise(params: params) { (dataArr,flag) in
                
                if flag {
                    if dataArr.count > 0{
                        self.workModel = dataArr[0] as! NotWorkDetailModel
                        self.state = self.workModel.correct_states
                        self.mainTableView.reloadData()
                        self.mainTableView.mj_header.endRefreshing()
                    }
                }
                print(dataArr)
            }
            
            
        }else if currentIndex == 2 {
            let params =
                [
                    "NonExcrcise_id":model.non_exercise_id,
                    "SESSIONID":SESSIONID,
                    "mobileCode":mobileCode
                    ] as [String:Any]
            self.view.beginLoading()
            NetWorkStudentGetKnowledgePoint(params: params, callBack: { (datas, flag) in
                if flag {
                    self.pointArr.removeAllObjects()
                    self.pointArr.addObjects(from: datas)
                    self.mainTableView.reloadData()
                    self.mainTableView.mj_header.endRefreshing()
                }
                self.view.endLoading()
            })
            
        }else if currentIndex == 3 {
            let type = self.type.joined(separator: ",")

            let params =
                [
                    "bookId":model.non_exercise_id,
                    "type":type,
                    "SESSIONID":SESSIONID,
                    "mobileCode":mobileCode
                    ] as [String:Any]
            NetWorkStudentGetAnswrs(params: params) { (datas, flag) in
                if flag {
                    self.answerArr.addObjects(from: datas)
                    self.mainTableView.mj_header.endRefreshing()
                    self.mainTableView.reloadData()
                }
            }
            
        }else if currentIndex == 4 {
            
            
        }

    }
    
    
    override func configSubViews() {
        
        self.navigationItem.title = "非练习册"
        
        typeArr = ["我的作业","知识点讲解","参考答案","成绩统计"]
        let kHeight = CGFloat(44)
        
        var contentWidth = CGFloat()
        var totalWidth = CGFloat()
        
        headView = UIView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 43))
        
        //MARK: 因为按钮字数不一样，长短有别，所以我先看看一共有多长再平分space
        for index in 0...typeArr.count-1{
            
            let kWidth = getLabWidth(labelStr: typeArr[index] as! String, font: kFont32, height: kHeight) + 10
            totalWidth += kWidth
            
        }
        
        let kSpace = CGFloat(kSCREEN_WIDTH - totalWidth)/5
        
        for index in 0..<typeArr.count{
            
            let kWidth = getLabWidth(labelStr: typeArr[index] as! String, font: kFont32, height: kHeight) + 10
            let markBtn = UIButton.init(frame: CGRect(x: kSpace + (contentWidth + kSpace * CGFloat(index)) , y: 1, width: kWidth, height: kHeight))
            //            markBtn.center.y = headView.center.y
            markBtn.setTitle(typeArr[index] as? String, for: .normal)
            markBtn.setTitleColor(kGaryColor(num: 117), for: .normal)
            markBtn.titleLabel?.font = kFont28
            markBtn.addTarget(self, action: #selector(goodAtProject(sender:)), for: .touchUpInside)
            contentWidth += kWidth
            markBtn.tag = 131 + index
            headView.addSubview(markBtn)
        }
        
        let line = UIView.init(frame: CGRect(x: 0, y: 41 , width: kSCREEN_WIDTH, height: 1))
        line.backgroundColor = kGaryColor(num: 223)
        headView.addSubview(line)
        
        let view = headView.viewWithTag(131) as! UIButton
        view.setTitleColor(kMainColor(), for: .normal)
        underLine = UIView.init(frame: CGRect(x: 0, y: 40, width: getLabWidth(labelStr: "时我粉丝", font: kFont32, height: 1) - 5, height: 2))
        underLine.backgroundColor = kMainColor()
        underLine.layer.cornerRadius = 1
        underLine.clipsToBounds = true
        underLine.center.x = view.center.x
        headView.addSubview(underLine)
        
        headView.backgroundColor = UIColor.white
        self.view.addSubview(headView)
        
        mainTableView = UITableView.init(frame: CGRect(x: 0, y: 42, width: kSCREEN_WIDTH, height: kSCREEN_HEIGHT - 64 - 42), style: .plain)
        mainTableView.dataSource = self;
        mainTableView.delegate = self;
        mainTableView.estimatedRowHeight = 342
        mainTableView.tableFooterView = UIView.init()
        
        mainTableView.register(UINib(nibName: "AnserImageCell", bundle: nil), forCellReuseIdentifier: identyfierTable)
        mainTableView.register(UINib(nibName: "UpLoadWorkCell", bundle: nil), forCellReuseIdentifier: identyfierTable1)
        mainTableView.register(UINib(nibName: "CheckWorkCell", bundle: nil), forCellReuseIdentifier: identyfierTable2)
        mainTableView.register(UINib(nibName: "AnserVideoCell", bundle: nil), forCellReuseIdentifier: identyfierTable3)
        mainTableView.register(UINib(nibName: "ClassGradeCell", bundle: nil), forCellReuseIdentifier: identyfierTable4)
        mainTableView.register(UINib(nibName: "CreateBookCell", bundle: nil), forCellReuseIdentifier: identyfierTable5)
        mainTableView.register(UINib(nibName: "TViewBookCell", bundle: nil), forCellReuseIdentifier: identyfierTable6)
        mainTableView.register(UINib(nibName: "TViewBookCell1", bundle: nil), forCellReuseIdentifier: identyfierTable9)
        mainTableView.register(UINib(nibName: "TViewBookCell2", bundle: nil), forCellReuseIdentifier: identyfierTable10)
        mainTableView.register(UINib(nibName: "TViewBookCell3", bundle: nil), forCellReuseIdentifier: identyfierTable11)
        mainTableView.register(UINib(nibName: "ShowFileCell", bundle: nil), forCellReuseIdentifier: identyfierTable7)
        mainTableView.register(UINib(nibName: "ShowWriteAnswerCell", bundle: nil), forCellReuseIdentifier: identyfierTable8)
        mainTableView.register(UINib(nibName: "AnswerImageCell", bundle: nil), forCellReuseIdentifier: identyfierTable12)

        self.view.addSubview(mainTableView)
    }
    
    
    //MARK:   顶部选择栏选择事件
    @objc func goodAtProject(sender:UIButton) {
        
        let view = headView.viewWithTag(currentIndex+130) as! UIButton
        
        if view == sender {
            return
        }
        
        view.setTitleColor(kGaryColor(num: 117), for: .normal)
        sender.setTitleColor(kMainColor(), for: .normal)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.underLine.bounds.size.width = getLabWidth(labelStr: (sender.titleLabel?.text)!, font: kFont32, height: 2)-5
            
            self.underLine.center = CGPoint(x:  sender.center.x, y:  self.underLine.center.y)
        })
        
        currentIndex = sender.tag - 130
        
      
        if currentIndex == 3 {
            footView(titles: titleArr3)
        }else{
            footBtnView.removeFromSuperview()
        }
        
        if currentIndex == 1 {
            let params =
                [
                    "non_exercise_Id":model.non_exercise_id,
                    "SESSIONID":SESSIONID,
                    "mobileCode":mobileCode
                    ] as [String:Any]
            
            NetWorkStudentGetAllnon_exercise(params: params) { (dataArr,flag) in
                
                if flag {
                    if dataArr.count > 0{
                        self.workModel = dataArr[0] as! NotWorkDetailModel
                        self.state = self.workModel.correct_states
                        self.mainTableView.reloadData()
                    }
                }
                print(dataArr)
            }

            
        }else if currentIndex == 2 {
            let params =
                [
                    "NonExcrcise_id":model.non_exercise_id,
                    "SESSIONID":SESSIONID,
                    "mobileCode":mobileCode
                    ] as [String:Any]
            self.view.beginLoading()
            NetWorkStudentGetKnowledgePoint(params: params, callBack: { (datas, flag) in
                if flag {
                    self.pointArr.removeAllObjects()
                    self.pointArr.addObjects(from: datas)
                    self.mainTableView.reloadData()
                }
                self.view.endLoading()
            })

        }else if currentIndex == 3 {
            let type = self.type.joined(separator: ",")
            
            let params =
                [
                    "bookId":model.non_exercise_id,
                    "type":type,
                    "SESSIONID":SESSIONID,
                    "mobileCode":mobileCode
                    ] as [String:Any]
            NetWorkStudentGetOtherAnswrs(params: params) { (datas, flag) in
                if flag {
                    self.answerArr.removeAllObjects()
                    self.answerArr.addObjects(from: datas)
                    self.mainTableView.reloadData()
                }
            }
            
        }else if currentIndex == 4 {
            
            
        }

        mainTableView.reloadData()
    }
    
    
    func footView(titles:[String]) {
        footBtnView.removeFromSuperview()
        _ = footBtnView.subviews.map {
            $0.removeFromSuperview()
        }
        
        let kHeight = CGFloat(72 * kSCREEN_SCALE)
        let kWidth = CGFloat(435*kSCREEN_SCALE)
        let kSpace = 53*kSCREEN_SCALE
        
        var viewHeight = CGFloat(titles.count)*kHeight+CGFloat(titles.count+1)*kSpace
        
        if titles.count == 0 {
            viewHeight = 0
        }
        
        footBtnView = UIView.init(frame: CGRect(x: 0, y: 0, width: KScreenWidth, height: viewHeight))
        for index in 0..<titles.count {
            
            let markBtn = UIButton.init(frame: CGRect(x: (kSCREEN_WIDTH-kWidth)/2 , y: kSpace+(kSpace+kHeight)*CGFloat(index), width: kWidth, height: kHeight))
            markBtn.setTitle(titles[index], for: .normal)
            markBtn.setTitleColor(kGaryColor(num: 117), for: .normal)
            markBtn.titleLabel?.font = kFont28
            markBtn.setBackgroundImage(getNavigationIMG(27, fromColor: kSetRGBColor(r: 0, g: 200, b: 255), toColor: kSetRGBColor(r: 0, g: 162, b: 255)), for: .normal)
            markBtn.addTarget(self, action: #selector(showDownloadBtn(sender:)), for: .touchUpInside)
            markBtn.layer.cornerRadius = 10*kSCREEN_SCALE
            markBtn.clipsToBounds = true
            markBtn.setTitleColor(UIColor.white, for: .normal)
            markBtn.tag = 181 + index
            footBtnView.addSubview(markBtn)
        }
        mainTableView.tableFooterView = footBtnView
    }

    
    //MARK:下载视频点击事件
    @objc func showDownloadBtn(sender:UIButton) {
        
        let passwd = HBAlertPasswordView.init(frame: self.view.bounds)
        passwd.delegate = self
        
        if currentIndex == 1 {
            
        }else{
            
        }
        
        passwd.titleLabel.text = "五哈哈哈哈"
        self.view.addSubview(passwd)
        
        if currentIndex == 3 {
            currentTitle2 = (sender.titleLabel?.text)!
        }
    }
    
    
    //    HBAlertPasswordViewDelegate 密码弹框代理
    func sureAction(with alertPasswordView: HBAlertPasswordView!, password: String!) {
        alertPasswordView.removeFromSuperview()
        setToast(str: "输入的密码为:"+password)
        if currentIndex == 3 {
            
            titleArr3.remove(at: titleArr3.index(of: currentTitle2)!)
            footView(titles: titleArr3)
            mainTableView.reloadData()
        }
    }

    
    //MARK:  ******代理 ：UITableViewDataSource,UITableViewDelegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if currentIndex == 3 {
            return answerArr.count
        }
        
        if currentIndex == 1 {
            
            if Int(state)! < 4 {
                
                return 1
            }
            
            if workModel.correct_states == "4" && workModel.pre_score == "5" {
                return 1
            }
            
            if workModel.correct_states == "7" && workModel.pre_score == "5" {
                return 1
            }

            return 2
        }
        
        if currentIndex == 2 {
            return pointArr.count
        }
        
        if Int(model.correct_states)! == 4 || Int(model.correct_states)! == 7 {
            return 2
        }
        
        return 1
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if currentIndex == 1 {
            
            if state == "1" {
                let cell : UpLoadWorkCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable1, for: indexPath) as! UpLoadWorkCell
                
                cell.upLoadImagesForWorkBook(images: images as! Array<UIImage>)
                
                cell.chooseImagesAction = {
                    
                    if $0 == "uploadAction" {
                        let params = [
                            "SESSIONID":SESSIONID,
                            "mobileCode":mobileCode,
                            "non_exercise_name":cell.workDescrip.text!,
                            "correct_way":self.workModel.correct_way,
                            "classes_id":self.workModel.pre_comment,
                            "subject_id":self.workModel.correct_way,
                            "freind_id":self.workModel.correct_way,
                            ] as! [String : String]

                        var nameArr = [String]()
                        for index in 0..<self.images.count {
                            nameArr.append("image\(index)")
                        }
                        
                        netWorkForUploadWorkBook(params: params , data: self.images as! [UIImage], name: nameArr, success: { (datas) in
                            let json = JSON(datas)
                            deBugPrint(item: json)
                            setToast(str: "上传成功")
                            let params =
                                [
                                    "non_exercise_Id":self.model.non_exercise_id,
                                    "SESSIONID":SESSIONID,
                                    "mobileCode":mobileCode
                                    ] as [String:Any]
                            
                            NetWorkStudentGetAllnon_exercise(params: params) { (dataArr,flag) in
                                
                                if flag {
                                    if dataArr.count > 0{
                                        self.workModel = dataArr[0] as! NotWorkDetailModel
                                        self.state = self.workModel.correct_states
                                        self.mainTableView.reloadData()
                                    }
                                }
                                print(dataArr)
                            }
                            deBugPrint(item: datas)
                        }, failture: { (error) in
                            deBugPrint(item: error)
                        })
                        
                    }else{
                        self.setupPhoto1(count: 2,currentIndex: Int($0)!)
                    }
                }
                
                return cell
            }
            
            if state == "2" {
                let cell : CheckWorkCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable2, for: indexPath) as! CheckWorkCell
                
                cell.checkWorkCellSetValues1NotWork(model:workModel)
                return cell
            }
            
            if  state == "3" {
                
                if indexPath.row == 0 {
                    let cell : CheckWorkCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable2, for: indexPath) as! CheckWorkCell
                    cell.checkWorkCellSetValues2NotWork(model:workModel)
                    cell.resubmitAction = {
//                        self.state = "0"
//                        tableView.reloadData()
                        let VC = CreateNotWorkViewController()
                        self.navigationController?.pushViewController(VC, animated: true)
                    }
                    cell.complainAction = {
                        let complianVC = ComplaintViewController()
                        self.navigationController?.pushViewController(complianVC, animated: true)
                    }
                    return cell
                }
            }
            
            if state == "4" {
                
                if  indexPath.row == 0 {
                    let cell : CheckWorkCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable2, for: indexPath) as! CheckWorkCell
                    cell.checkWorkCellSetValues3NotWork(model:workModel)
                    cell.complainAction = {
                        let complianVC = ComplaintViewController()
                        self.navigationController?.pushViewController(complianVC, animated: true)
                    }
                    
                    return cell
                }
                
                let cell : UpLoadWorkCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable1, for: indexPath) as! UpLoadWorkCell
                cell.upLoadImagesForResubmit(images: images as! Array<UIImage>)
                
                cell.chooseImagesAction = {
                    if $0 == "uploadAction" {
                        
                        let params =
                            [
                                "SESSIONID":SESSIONID,
                                "mobileCode":mobileCode,
                                "non_exercise_Id":self.model.non_exercise_id
                        ] as! [String : String]
                        
                        deBugPrint(item: params)
                        var nameArr = [String]()
                        nameArr.append("pre_photos1")
                        nameArr.append("pre_photos2")
                        netWorkForAddNonExerciseNext(params: params , data: self.images as! [UIImage] , name: nameArr, success: { (success) in
                            
                        }) { (erorr) in
                            
                        }
                    }else{
                        self.setupPhoto1(count: 2, currentIndex: Int($0)!)
                    }
                }
                return cell
            }
            
            if currentIndex == 1 && state == "5" {
                
                let cell : CheckWorkCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable2, for: indexPath) as! CheckWorkCell
                if  indexPath.row == 0 {
                    
                    cell.checkWorkCellSetValues3NotWork(model:workModel)
                    return cell
                }
                cell.checkWorkCellSetValues1NotWork(model:workModel)
                return cell
            }
            
            if currentIndex == 1 && state == "6" {
                let cell : CheckWorkCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable2, for: indexPath) as! CheckWorkCell
                
                if  indexPath.row == 0 {
                    
                    cell.checkWorkCellSetValues3NotWork(model:workModel)
                    return cell
                }
                
                cell.checkWorkCellSetValues2NotWork(model:workModel)
                
                cell.resubmitAction = {
                    self.state = "4"
                    tableView.reloadData()
                }
                
                cell.complainAction = {
                    let complaintVC = ComplaintViewController()
                    self.navigationController?.pushViewController(complaintVC, animated: true)
                }
                
                return cell
            }
            
            if currentIndex == 1 && state == "7" {
                
                if  indexPath.row == 0 {
                    
                    let cell : CheckWorkCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable2, for: indexPath) as! CheckWorkCell
                    cell.checkWorkCellSetValues3NotWork(model:workModel)
                    return cell
                }
                let cell : CheckWorkCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable2, for: indexPath) as! CheckWorkCell
                cell.checkWorkCellSetValues4NotWork(model:workModel)
                return cell
            }
        }
        
        if currentIndex == 2 {
            
            let model = pointArr[indexPath.row] as! UrlModel
            
            let cell : AnserVideoCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable3, for: indexPath) as! AnserVideoCell
            cell.AnserVideoCellSetValues(model: model)
            return cell
            
        }else if currentIndex == 3 {
            
            let model1 = answerArr[0] as! UrlModel
            let model2 = answerArr[1] as! UrlModel
            let model3 = answerArr[2] as! UrlModel
            let model4 = answerArr[3] as! UrlModel

            
            if indexPath.row < model1.title.count {
                let cell : AnserVideoCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable3, for: indexPath) as! AnserVideoCell
                cell.AnserVideoCellSetValuesForAnswer(title: model1.title[indexPath.row])
                return cell
            }else if indexPath.row < model1.title.count+model2.title.count {
                let cell : ShowFileCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable7, for: indexPath) as! ShowFileCell
                cell.setValues(model: model2)
                return cell
            }else if indexPath.row < model1.title.count+model2.title.count+model3.title.count {
                let cell : ShowWriteAnswerCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable8, for: indexPath) as! ShowWriteAnswerCell
                //                cell.showAnswer(text: model.title)
                return cell
            }else{
                let cell : AnswerImageCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable12, for: indexPath) as! AnswerImageCell
//                cell.showWithImage(image: model4.answard_res[indexPath.row])
                return cell

            }
            
//            if model1.type == "1" {
//
//            }else if model.type == "2" {
//
//            }else if model.type == "3" {
//
//            }else{
//            }
        }
        
        let cell : ClassGradeCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable4, for: indexPath) as! ClassGradeCell
        
        if Int(model.correct_states)! == 4 || Int(model.correct_states)! == 7 {

            if indexPath.row == 0 {
                cell.is1thCellForNonWorkBook()
            }else{
                cell.setValueForNonBookGrade(model: workModel)
            }
        }else{
            
            cell.noDatas()
        }
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if currentIndex == 2 {
            let model = pointArr[indexPath.row] as! UrlModel
              let url = NSURL.init(string: model.point_address!)
            
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url! as URL, options: [:],
                                          completionHandler: {
                                            (success) in
                })
            } else {
                // Fallback on earlier versions
            }
            
        }
        
        
        if currentIndex == 3 {
            let model = answerArr[indexPath.row] as! UrlModel
            
//            if model.type == "1" {
//                let url = NSURL.init(string: model.answard_res)
//
//                if #available(iOS 10.0, *) {
//                    UIApplication.shared.open(url! as URL, options: [:],
//                                              completionHandler: {
//                                                (success) in
//                    })
//                } else {
//                    // Fallback on earlier versions
//                }
//
//            }
//
            
        }
        
        if currentIndex == 4 {
            
            
//
//
//            // 获得此程序的沙盒路径
//            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
//
//            var files = [String]()
//            let fileManager = FileManager.default
//            let enumerator: FileManager.DirectoryEnumerator = fileManager.enumerator(atPath: path.first!)!
//            while let element = enumerator.nextObject() as? String {
//                if element.hasSuffix(".doc") || element.hasSuffix(".xls") || element.hasSuffix(".ppt") || element.hasSuffix(".docx") || element.hasSuffix(".xlsx") || element.hasSuffix(".pptx") || element.hasSuffix(".pdf") {
//                    files.append(element)
//                }
//            }
//
//            do {
//                if files.count > 0 {
//            
            
            
//                }
//
//            } catch  {
//                print("error :\(error)")
//            }
//
//            //复制文件（重命名）
//            NSString *copyPath = [NSHomeDirectory() stringByAppendingPathComponent:@"备份/Old Testament.txt"];                              [fileManager createDirectoryAtPath:[toPath stringByDeletingLastPathComponent] withIntermediateDirectories:YES attributes:nil error:nil]
//
//
//
//            let fileData = Data.init(contentsOf:NSURL.init(string: Bundle.main.path(forResource: "批改作业接口 1107(1)", ofType: "docx")!)! as URL)
//
//            fileData.write(to: NSURL.init(fileURLWithPath: path[0]) as URL)
//
            
        }
        
    }
    
    
    // 异步原图
    // 异步原图
    private func setupPhoto1(count:NSInteger,currentIndex:NSInteger) {
        let imagePickTool = CLImagePickersTool()
        
        imagePickTool.isHiddenVideo = true
        
        imagePickTool.setupImagePickerWith(MaxImagesCount: count, superVC: self) { (assetArr,cutImage) in
            deBugPrint(item: "返回的asset数组是\(assetArr)")
            
            PopViewUtil.share.showLoading()
            
            var imageArr = [UIImage]()
            var index = assetArr.count // 标记失败的次数
            
            // 获取原图，异步
            // scale 指定压缩比
            // 内部提供的方法可以异步获取图片，同步获取的话时间比较长，不建议！，如果是iCloud中的照片就直接从icloud中下载，下载完成后返回图片,同时也提供了下载失败的方法
            CLImagePickersTool.convertAssetArrToOriginImage(assetArr: assetArr, scale: 0.1, successClouse: {[weak self] (image,assetItem) in
                imageArr.append(image)
                
                if (self?.images.count)!<2{
                    self?.images.add(image)
                }else{
                    self?.images[currentIndex] = image
                }
                
                self?.dealImage(imageArr: imageArr, index: index)
                self?.mainTableView.reloadData()
                
                }, failedClouse: { () in
                    index = index - 1
                    self.dealImage(imageArr: imageArr, index: index)
            })
            
        }
    }

    
    @objc func dealImage(imageArr:[UIImage],index:Int) {
        // 图片下载完成后再去掉我们的转转转控件，这里没有考虑assetArr中含有视频文件的情况
        if imageArr.count == index {
            PopViewUtil.share.stopLoading()
        }
        // 图片显示出来以后可能还要上传到云端的服务器获取图片的url，这里不再细说了。
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        PopViewUtil.share.stopLoading()
    }
}
