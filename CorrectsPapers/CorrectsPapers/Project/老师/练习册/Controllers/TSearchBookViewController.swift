//
//  TSearchBookViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/20.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class TSearchBookViewController: BaseViewController,UITextFieldDelegate{
    
    var emptyView = UIView()
    var isSearching = false
    
    var searchTextfield = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetTitleView()
    }
    
    override func requestData() {
        
    }
    
    
    override func configSubViews() {
        
        mainTableArr =  ["","","","",""]

        mainTableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: kSCREEN_HEIGHT - 64 ), style: .grouped)
        mainTableView.dataSource = self;
        mainTableView.delegate = self;
        mainTableView.estimatedRowHeight = 143 * kSCREEN_SCALE;
        mainTableView.register(UINib(nibName: "TShowBookCell", bundle: nil), forCellReuseIdentifier: identyfierTable)
        mainTableView.tableFooterView = UIView.init()
        mainTableView.tableFooterView = UIView()
        self.view.addSubview(mainTableView)
        
    }
    
    
    override func leftBarButton() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image:#imageLiteral(resourceName: "back_icon_default"), style: .done, target: self, action: #selector(backAction(sender:)))
        //        返回手势
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title:"搜索", style: .done, target: self, action: #selector(searchBegin))
        
    }
    
    @objc func searchBegin() {
        setToast(str: "开始搜索")

        let params =
            ["SESSIONID":SESSIONIDT,
             "mobileCode":mobileCodeT,
             "workName":searchTextfield.text!,
             ] as [String : Any]
        
        NetWorkTeacherGetTAllWorkList(params: params) { (datas) in
            self.isSearching = true
            self.mainTableArr.removeAllObjects()
            self.mainTableArr.addObjects(from: datas)
            self.mainTableView.reloadData()
        }
        
    }
    
    
    func resetTitleView() {
        
        //        密码
        searchTextfield.frame = CGRect(x: 30, y: 150, width: kSCREEN_WIDTH - 110, height: 32)
        searchTextfield.borderStyle = .roundedRect
        searchTextfield.leftViewRect(forBounds: CGRect(x: 0, y: 0, width: 26, height: 17))
        searchTextfield.placeholder = "搜索练习册"
        searchTextfield.leftViewMode = .always
        searchTextfield.returnKeyType = .search
        searchTextfield.delegate = self
        
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: 26, height: 17))
        
        let leftImage = UIImageView.init(frame: CGRect(x: 8, y: 0, width: 17, height: 17))
        leftImage.image = #imageLiteral(resourceName: "search_icon_default")
        
        view.addSubview(leftImage)
        searchTextfield.leftView = view
        self.navigationItem.titleView = searchTextfield
        
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
        label.text = "未搜索到此练习册"
        emptyView.addSubview(label)
        
        let creatBook = UIButton.init(frame: CGRect(x: 0, y: 0, width: 120, height: 30))
        creatBook.setBackgroundImage(getNavigationIMG(27, fromColor: kSetRGBColor(r: 0, g: 200, b: 255), toColor: kSetRGBColor(r: 0, g: 162, b: 255)), for: .normal)
        creatBook.center = CGPoint(x: emptyView.centerX, y: emptyView.centerY + 10 * kSCREEN_SCALE)
        creatBook.setTitle("创建练习册", for: .normal)
        creatBook.layer.cornerRadius = 5
        creatBook.clipsToBounds = true
        creatBook.addTarget(self, action: #selector(createBookAction(sender:)), for: .touchUpInside)
        emptyView.addSubview(creatBook)
        
        self.mainTableView.addSubview(emptyView)
    }
    
    
    @objc func createBookAction(sender:UIButton) {
        let createBook = CreateBookViewController()
        self.navigationController?.pushViewController(createBook, animated: true)
    }
    
    //MARK:  ******代理 ：UITableViewDataSource,UITableViewDelegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if mainTableArr.count == 0 {
            addImageWhenEmpty()
        }else{
            emptyView.removeFromSuperview()
        }
        
        return mainTableArr.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : TShowBookCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable, for: indexPath) as! TShowBookCell
        cell.selectionStyle = .default
        cell.TShowBookCellForSearch(index: indexPath.row)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        searchTextfield.endEditing(true)
        mainTableArr = []
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
            if isSearching {
                let showLabel = UILabel.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 19))
                showLabel.text = "  搜索结果"
                showLabel.font = kFont26
                showLabel.textColor = kGaryColor(num: 176)
                
                let result = UILabel.init(frame: CGRect(x: 80, y: 3, width: kSCREEN_WIDTH-80, height: 19))
                result.text = "共找到\(mainTableArr.count)个班级  "
                result.isAttributedContent = true
                result.textColor = kGaryColor(num: 176)
                
                let attributeText = NSMutableAttributedString.init(string: result.text!)
                let count = String(mainTableArr.count).characters.count
                //设置段落属性
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.lineSpacing = 2     //设置行间距
                attributeText.addAttributes([NSAttributedStringKey.paragraphStyle: paragraphStyle], range: NSMakeRange(0, (result.text?.characters.count)!))
                attributeText.addAttributes([NSAttributedStringKey.font:  kFont28], range: NSMakeRange(0, (result.text?.characters.count)!))
                attributeText.addAttributes([NSAttributedStringKey.foregroundColor: kSetRGBColor(r: 255, g: 153, b: 0)], range: NSMakeRange(3,  count))
                //                attributeText.addAttributes([NSAttributedStringKey.foregroundColor: UIColor.black], range: NSMakeRange(0, 5))
                
                //                result.centerY = showLabel.centerY
                result.attributedText = attributeText
                result.textAlignment = .right
                result.font = kFont26
                showLabel.addSubview(result)
                
                return showLabel
            }
        }
        
        return UIView()
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchTextfield.endEditing(true)
        self.view.endEditing(true)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if isSearching {
            return 25
        }
        return 0
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        searchBegin()
        return true
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        searchTextfield.endEditing(true)
    }
}

