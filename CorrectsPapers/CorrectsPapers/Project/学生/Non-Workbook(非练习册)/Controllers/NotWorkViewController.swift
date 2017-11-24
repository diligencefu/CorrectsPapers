//
//  NotWorkViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/16.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import QuickLook

class NotWorkViewController: BaseViewController ,QLPreviewControllerDelegate,QLPreviewControllerDataSource{
    let viewFile = QLPreviewController()
    
    var pageNum = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addFooterRefresh()
        rightBarButton()
    }
    
    override func requestData() {
        
        let param =
            [
                "SESSIONID":SESSIONID,
                "mobileCode":mobileCode,
                "pageNo":"1",
                ]
        NetWorkTeacherGetExerciseList(params: param) { (datas) in
            self.mainTableArr.removeAllObjects()
            self.mainTableArr.addObjects(from: datas)
            self.mainTableView.reloadData()
        }
    }
    
    
    override func refreshHeaderAction() {
        pageNum = 1
        let param =
            [
                "SESSIONID":SESSIONID,
                "mobileCode":mobileCode,
                "pageNo":"1",
                ]
        NetWorkTeacherGetExerciseList(params: param) { (datas) in
            self.mainTableArr.removeAllObjects()
            self.mainTableArr.addObjects(from: datas)
            self.mainTableView.mj_header.endRefreshing()
            self.mainTableView.mj_footer.resetNoMoreData()
            self.mainTableView.reloadData()
        }
    }
    
    override func refreshFooterAction() {
        pageNum = pageNum+1
        let param =
            [
                "SESSIONID":SESSIONID,
                "mobileCode":mobileCode,
                "pageNo":String(pageNum),
                ]
        NetWorkTeacherGetExerciseList(params: param) { (datas) in
            if datas.count > 0{
                self.mainTableArr.addObjects(from: datas)
                self.mainTableView.mj_footer.endRefreshing()
            }else{
                self.mainTableView.mj_footer.endRefreshingWithNoMoreData()
            }
            self.mainTableView.reloadData()
        }

    }
    
    
    override func leftBarButton() {
        
    }
    
    override func configSubViews() {
        
        self.navigationItem.title = "非练习册"        
        mainTableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: kSCREEN_HEIGHT - 64 ), style: .plain)
        mainTableView.dataSource = self;
        mainTableView.delegate = self;
        mainTableView.estimatedRowHeight = 143 * kSCREEN_SCALE;
        mainTableView.register(UINib(nibName: "NotWorkCellCell", bundle: nil), forCellReuseIdentifier: identyfierTable)
        self.view.addSubview(mainTableView)
    }
    
    //    右键
    func rightBarButton() {
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: #imageLiteral(resourceName: "book_icon_default"), style: .plain, target: self, action: #selector(createNotWork(sender:)))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
    }
    
    @objc func createNotWork(sender:UIBarButtonItem) {

        let bookVc = CreateNotWorkViewController()
        self.navigationController?.pushViewController(bookVc, animated: true)
    }
    
    //MARK:  ******代理 ：UITableViewDataSource,UITableViewDelegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return mainTableArr.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = mainTableArr[indexPath.row] as! SNotWorkModel
        let cell : NotWorkCellCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable, for: indexPath) as! NotWorkCellCell
        cell.setDataWithModel(model: model)
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            viewFile.delegate = self
            viewFile.dataSource = self
            viewFile.currentPreviewItemIndex = 1
            self.navigationController?.pushViewController(viewFile, animated: true)
            
        }else{
            tableView.deselectRow(at: indexPath, animated: true)
            let model = mainTableArr[indexPath.row] as! SNotWorkModel
            let detailVC = NotWorkDetailViewController()
            detailVC.state = model.correct_states
            detailVC.model = model
            self.navigationController?.pushViewController(detailVC, animated: true)

        }
    }

    
//    QLPreviewControllerDataSource
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 2
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        return NSURL.fileURL(withPath: Bundle.main.path(forResource: "批改作业接口 1107(1)", ofType: "docx")!) as QLPreviewItem
//        return NSURL.fileURL(withPath: "https://pan.baidu.com/s/1eSngSxG") as QLPreviewItem
     }
    
    
}
