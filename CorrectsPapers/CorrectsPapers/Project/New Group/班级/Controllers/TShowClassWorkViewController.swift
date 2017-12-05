//
//  TShowClassWorkViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/18.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class TShowClassWorkViewController: BaseViewController {

    var model = TShowClassWorksModel()
    
    var reasonView = ShowTagsView()
    var BGView = UIView()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configSubViews() {
        
        self.navigationItem.title = "作业详情"
        
        mainTableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: kSCREEN_HEIGHT - 64 ), style: .plain)
        mainTableView.dataSource = self;
        mainTableView.delegate = self;
        mainTableView.estimatedRowHeight = 143 * kSCREEN_SCALE;
        mainTableView.register(UINib(nibName: "TGoodWorkCell",     bundle: nil), forCellReuseIdentifier: identyfierTable)
        mainTableView.register(UINib(nibName: "TNotGoodWorkCell",    bundle: nil), forCellReuseIdentifier: identyfierTable1)
        mainTableView.register(UINib(nibName: "TNotGoodWorkCell1",    bundle: nil), forCellReuseIdentifier: identyfierTable2)
        mainTableView.tableFooterView = UIView()
        self.view.addSubview(mainTableView)
        
        let footView = UIView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 350*kSCREEN_SCALE))
        footView.backgroundColor = UIColor.clear
        let certain = UIButton.init(frame: CGRect(x: 60 * kSCREEN_SCALE, y: 72*kSCREEN_SCALE, width: kSCREEN_WIDTH - 120 * kSCREEN_SCALE, height: 86 * kSCREEN_SCALE))
        certain.layer.cornerRadius = 10 * kSCREEN_SCALE
        certain.clipsToBounds = true
        certain.setBackgroundImage(getNavigationIMG(27, fromColor: kSetRGBColor(r: 0, g: 200, b: 255), toColor: kSetRGBColor(r: 0, g: 162, b: 255)), for: .normal)
        certain.setTitle("确认批改", for: .normal)
        certain.setTitleColor(kSetRGBColor(r: 255, g: 153, b: 0), for: .normal)
        certain.addTarget(self, action: #selector(certainCorrect), for: .touchUpInside)
        certain.setTitleColor(UIColor.white, for: .normal)
        footView.addSubview(certain)
        
        let sendBack = UIButton.init(frame: CGRect(x: 60 * kSCREEN_SCALE, y: 224*kSCREEN_SCALE, width: kSCREEN_WIDTH - 120 * kSCREEN_SCALE, height: 86 * kSCREEN_SCALE))
        sendBack.layer.cornerRadius = 10 * kSCREEN_SCALE
        sendBack.clipsToBounds = true
        sendBack.layer.borderColor = kMainColor().cgColor
        sendBack.layer.borderWidth = 1
        sendBack.setTitle("退回作业", for: .normal)
        sendBack.setTitleColor(kSetRGBColor(r: 255, g: 153, b: 0), for: .normal)
        sendBack.setTitleColor(kMainColor(), for: .normal)
        sendBack.addTarget(self, action: #selector(sendBackAction), for: .touchUpInside)
        footView.addSubview(sendBack)
        mainTableView.tableFooterView = footView
        
        //        弹出视图弹出来之后的背景蒙层
        BGView = UIView.init(frame: self.view.frame)
        BGView.backgroundColor = kSetRGBAColor(r: 5, g: 5, b: 5, a: 0.5)
        BGView.alpha = 0
        //        BGView.isHidden = true
        
        let tapGes1 = UITapGestureRecognizer.init(target: self, action: #selector(showChooseCondi(tap:)))
        tapGes1.numberOfTouchesRequired = 1
        BGView.addGestureRecognizer(tapGes1)
        self.view.addSubview(BGView)
        
        reasonView = UINib(nibName:"ShowTagsView",bundle:nil).instantiate(withOwner: self, options: nil).first as! ShowTagsView
        reasonView.ShowTagsViewForChooseEdu(title: "", index: 1000)
        reasonView.frame =  CGRect(x: 0, y: kSCREEN_HEIGHT, width: kSCREEN_WIDTH, height: 190+206*kSCREEN_SCALE)
        reasonView.layer.cornerRadius = 24*kSCREEN_SCALE
        reasonView.selectBlock = {
            if !$1 {
                deBugPrint(item: $0)
                let params =
                    ["SESSIONID":SESSIONIDT,
                     "mobileCode":mobileCodeT,
                     "student_id":self.model.student_id,
                     "type":"1",
                     "reason":"$0",
                     "book_id":self.model.class_book_id
                        ] as [String:Any]

                NetWorkTeacherGobackWrokBook(params: params, callBack: { (flag) in

                })
                
                
            }
            self.hiddenViews()
        }
        
        reasonView.clipsToBounds = true
        self.view.addSubview(reasonView)
    }
    
    
    @objc func showChooseCondi(tap:UITapGestureRecognizer) -> Void {
        
        if tap.view?.alpha == 1 {
            UIView.animate(withDuration: 0.5) {
                tap.view?.alpha = 0
                self.reasonView.transform = .identity
            }
        }
    }
    
    
    func hiddenViews() {
        
        UIView.animate(withDuration: 0.5) {
            self.BGView.alpha = 0
            self.reasonView.transform = .identity
        }
    }
    
    func showTheProjectTagsView() -> Void {
        
        let y = 180+206*kSCREEN_SCALE
        UIView.animate(withDuration: 0.5) {
            self.reasonView.transform = .init(translationX: 0, y: -y)
            self.BGView.alpha = 1
        }
    }
    
    
    @objc func certainCorrect() {
        
        if model.type == "2" {
            
            let cell = mainTableView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as! TNotGoodWorkCell1
            let editorVC = QQQEditorViewController(nibName: "QQQEditorViewController", bundle: nil)
            editorVC.images = cell.editArr
            editorVC.theName = model.user_name
            editorVC.theNum = "学号 "+model.student_num
            editorVC.bookid = model.class_book_id
            editorVC.bookState = model.type
            editorVC.whereCome = 3
            self.present(editorVC, animated: true, completion: nil)
        }else{
            
            let cell = mainTableView.cellForRow(at: IndexPath.init(row: 1, section: 0)) as! TNotGoodWorkCell
            let editorVC = QQQEditorViewController(nibName: "QQQEditorViewController", bundle: nil)
            editorVC.images = cell.editArr
            editorVC.theName = model.user_name
            editorVC.theNum = "学号 "+model.student_num
            editorVC.bookid = model.class_book_id
            editorVC.bookState = model.type
            editorVC.whereCome = 3
            self.present(editorVC, animated: true, completion: nil)
        }
    }
    
    
    @objc func sendBackAction() {
        showTheProjectTagsView()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if model.type == "2"  {
            return 1
        }else{
            return 2
        }
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if model.type == "2" {
            let cell : TNotGoodWorkCell1 = tableView.dequeueReusableCell(withIdentifier: identyfierTable2, for: indexPath) as! TNotGoodWorkCell1
            cell.TNotGoodWorkCell1SetValuesForFristCorrectedUndone(model: model)
            cell.selectionStyle = .none
            return cell
        }else {
            
            if indexPath.row == 0 {
                let cell : TGoodWorkCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable, for: indexPath) as! TGoodWorkCell
                cell.TGoodWorkCellSetValuesForFirstCorrectDone(model: model)
                cell.selectionStyle = .none
                return cell
            }else{
                let cell : TNotGoodWorkCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable1, for: indexPath) as! TNotGoodWorkCell
                cell.TNotGoodWorkCellSetValuesForCorrectUndone(model: model)
                cell.selectionStyle = .none
                return cell
            }
        }
    }
    
}
