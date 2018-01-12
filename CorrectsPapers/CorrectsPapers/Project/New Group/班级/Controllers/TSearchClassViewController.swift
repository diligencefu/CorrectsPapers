//
//  TSearchClassViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/20.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class TSearchClassViewController: BaseViewController,UITextFieldDelegate,UIAlertViewDelegate{
    var emptyView = UIView()
    var isSearching = false
    var searchTextfield = UITextField()
    
    let cancelTitle = "取消"
    let certainTitle = "确定"
    
    var nameTextfield = UITextField()
    
    var class_id = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetTitleView()
        addImageWhenEmpty()
        addTagsView()
    }
    
    override func addHeaderRefresh() {
        
    }
    
    
    override func configSubViews() {
                
        mainTableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: kSCREEN_HEIGHT - 64 ), style: .grouped)
        mainTableView.dataSource = self;
        mainTableView.delegate = self;
        mainTableView.estimatedRowHeight = 143 * kSCREEN_SCALE;
        mainTableView.register(UINib(nibName: "ClassCell", bundle: nil), forCellReuseIdentifier: identyfierTable)
        self.view.addSubview(mainTableView)
    }
    
    
    override func leftBarButton() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image:#imageLiteral(resourceName: "back_icon_default"), style: .done, target: self, action: #selector(backAction(sender:)))
        //        返回手势
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title:"搜索", style: .done, target: self, action: #selector(searchBegin))
        
    }
    
    
    func resetTitleView() {
        
        //        密码
        searchTextfield.frame = CGRect(x: 30, y: 150, width: kSCREEN_WIDTH - 110, height: 32)
        searchTextfield.borderStyle = .roundedRect
        searchTextfield.leftViewRect(forBounds: CGRect(x: 0, y: 0, width: 26, height: 17))
        searchTextfield.placeholder = "搜索班级"
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
        label.text = "未搜索到此班级"
        emptyView.addSubview(label)
        
        let creatBook = UIButton.init(frame: CGRect(x: 0, y: 0, width: 120, height: 30))
        creatBook.setBackgroundImage(getNavigationIMG(27, fromColor: kSetRGBColor(r: 0, g: 200, b: 255), toColor: kSetRGBColor(r: 0, g: 162, b: 255)), for: .normal)
        creatBook.center = CGPoint(x: emptyView.centerX, y: emptyView.centerY + 10 * kSCREEN_SCALE)
        creatBook.setTitle("创建练习册", for: .normal)
        creatBook.layer.cornerRadius = 5
        creatBook.clipsToBounds = true
        creatBook.addTarget(self, action: #selector(createBookAction(sender:)), for: .touchUpInside)
    }
    
    
    @objc func createBookAction(sender:UIButton) {
        let createBook = CreateBookViewController()
        self.navigationController?.pushViewController(createBook, animated: true)
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
        cell.classCellSetValue(model: model, isSearch: true)
        cell.addClassBlock = {
            
            deBugPrint(item: $0)
            self.showTheChooseTypeView()
            self.class_id = model.classes_id
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        searchTextfield.endEditing(true)
//        mainTableArr = []
//        tableView.reloadData()
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
    
    @objc func searchBegin() {
//        setToast(str: "开始搜索")
        isSearching = true
//        mainTableView.reloadData()
        searchTextfield.endEditing(true)

        let params = [
            "SESSIONID":SESSIONIDT,
            "class_name":searchTextfield.text!,
            "mobileCode":mobileCodeT,
            "type":"2"
            ] as [String : Any]
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
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchBegin()
        return true
    }
    
    
    var BGView = UIView()
    var chooseType = ShowTagsView()
    
    
    @objc func showChooseCondi(tap:UITapGestureRecognizer) -> Void {
        if tap.view?.alpha == 1 {
            
            UIView.animate(withDuration: 0.5) {
                tap.view?.alpha = 0
                self.chooseType.transform = .identity
            }
        }
    }
    
    func hiddenViews() {
        UIView.animate(withDuration: 0.5) {
            self.BGView.alpha = 0
            self.chooseType.transform = .identity
        }
        
    }
    
    
    //    视图TagView
    func addTagsView() {
        //        弹出视图弹出来之后的背景蒙层
        BGView = UIView.init(frame: self.view.frame)
        BGView.backgroundColor = kSetRGBAColor(r: 5, g: 5, b: 5, a: 0.5)
        BGView.alpha = 0
        //        BGView.isHidden = true
        
        let tapGes1 = UITapGestureRecognizer.init(target: self, action: #selector(showChooseCondi(tap:)))
        tapGes1.numberOfTouchesRequired = 1
        BGView.addGestureRecognizer(tapGes1)
        self.view.addSubview(BGView)
        
        
        chooseType = UINib(nibName:"ShowTagsView",bundle:nil).instantiate(withOwner: self, options: nil).first as! ShowTagsView
        chooseType.ShowTagsViewForChooseEdu(title: "", index: 10001)
        chooseType.frame =  CGRect(x: 0, y: kSCREEN_HEIGHT, width: kSCREEN_WIDTH, height: 190+206*kSCREEN_SCALE)
        chooseType.layer.cornerRadius = 24*kSCREEN_SCALE
        chooseType.selectBlock = {
            if !$1 {
                let params = [
                    "SESSIONID":SESSIONIDT,
                    "classes_id":self.class_id,
                    "type":$0,
                    "mobileCode":mobileCodeT
                    ] as [String : Any]
                
                NetWorkTeacherTeacherAddToClasses(params: params, callBack: { (flag) in
                    if flag {
                        self.searchBegin()
                    }
                })

            }
            self.hiddenViews()
        }
        chooseType.clipsToBounds = true
        self.view.addSubview(chooseType)
    }
    
    
    func showTheChooseTypeView() -> Void {
        let y = 180+206*kSCREEN_SCALE
        
        UIView.animate(withDuration: 0.5) {
            self.chooseType.transform = .init(translationX: 0, y: -y)
            self.BGView.alpha = 1
        }
        
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        searchTextfield.endEditing(true)
    }
}

