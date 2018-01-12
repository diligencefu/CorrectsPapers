//
//  CreateNotWorkViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/16.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyJSON

protocol refreshDelegate:NSObjectProtocol {
    func beginRefresh()
}


class CreateNotWorkViewController: BaseViewController,UIPickerViewDelegate,UIPickerViewDataSource{

    var delegate : refreshDelegate?
    
    var contents = [Array<String>]()
    var titles = [Array<String>]()
    var images = [UIImage]()
    var model = ApplyModel()
    
    var bookState = 0
    
    var way = "1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBGViewAndPickerView()
        // Do any additional setup after loading the view.
    }
    
    override func requestData() {

    }

    
    override func addHeaderRefresh() {
        
    }
    
    
    override func configSubViews() {
        
        self.navigationItem.title = "创建非练习册"
        titles = [[""],["批改方式","选择老师"],["练习册科目","适用年纪"]]
        contents = [[""],["请好友帮忙",""],["语文","六年级 下册"]]

        mainTableArr =  ["","","","","","",""]
        
        mainTableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: kSCREEN_HEIGHT - 64 ), style: .plain)
        mainTableView.dataSource = self;
        mainTableView.delegate = self;
        mainTableView.estimatedRowHeight = 143 * kSCREEN_SCALE;
        mainTableView.register(UINib(nibName: "UpLoadWorkCell", bundle: nil), forCellReuseIdentifier: identyfierTable)
        mainTableView.register(UINib(nibName: "CreateBookCell", bundle: nil), forCellReuseIdentifier: identyfierTable1)
        mainTableView.tableFooterView = UIView()
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
        return contents[section].count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return contents.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if  indexPath.section == 0 {
            let cell : UpLoadWorkCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable, for: indexPath) as! UpLoadWorkCell
            cell.upLoadImagesForWorkBook(images: images)
            cell.chooseImagesAction = {
                deBugPrint(item: $0)
                
                if $0 == "uploadAction" {
                    
                    self.uploadWorkImage()
                }else{
                    if self.images.count < 2 {
                    }
                    self.setupPhoto1(count: 2, index: Int($0)!-1)

                }
                
            }
            return cell
        }
        
        let cell : CreateBookCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable1, for: indexPath) as! CreateBookCell
        
        if indexPath.section == 1 && indexPath.row == 1 && way == "2"{
            cell.showForCreate(isShow: true, title: titles[indexPath.section][indexPath.row], subTitle: contents[indexPath.section][indexPath.row])
            cell.accessoryType = .none
        }else{
            cell.showForCreate(isShow: false, title: titles[indexPath.section][indexPath.row], subTitle: contents[indexPath.section][indexPath.row])
            cell.accessoryType = .disclosureIndicator
            
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            return
        }
        
        if indexPath.section == 1 && indexPath.row == 1 && way == "1"{
            
            let chooseVC = ChooseTeacherCorrectVC()
            
            chooseVC.chooseMemberBlock = {
                self.way = "1"
                self.model = $0
                self.contents = [[""],["请好友帮忙",self.model.user_name],["语文","六年级 下册"]]
                tableView.reloadData()
            }
            
            self.navigationController?.pushViewController(chooseVC, animated: true)
            return
        }
        
        if indexPath.section == 1 && indexPath.row == 2 {
            return
        }
        
        if indexPath.section == 1 && indexPath.row == 0 {
            currentCount = indexPath.row
            titleLabel.text = "请选择修改方式"
        }
        
        if indexPath.section == 2 {
            
            currentCount = indexPath.row+1
            
            if indexPath.row == 1 {
                
                titleLabel.text = "请选择科目"
            }else{
                
                titleLabel.text = "请练习册版本"
            }
            
        }
        
        pickerView.reloadAllComponents()
        showTheTagView()

    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
//        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 12))
//        view.backgroundColor
        return UIView()
        
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section != 0{
            return 12
        }
        
        return 0
    }

    
    //MARK: 遮罩和选择器
    var BGView = UIView()
    var currentCount = 1
    var datePickerView = UIView()
    
    var pickerView:UIPickerView!
    var proArr = [String]()
    var gradeArr = [String]()
    var detailArr = [String]()
    var wayArr = [String]()
    var titleLabel = UILabel()
    
    
    func addBGViewAndPickerView() {
        
        
        proArr = ["语文","数学","英语"]
        gradeArr = ["八年级","七年级","六年级"]
        detailArr = ["全册","上册","下册"]
        wayArr = ["悬赏学币","请好友帮忙"]
        
        
        //        弹出视图弹出来之后的背景蒙层
        BGView = UIView.init(frame: self.view.frame)
        BGView.backgroundColor = kSetRGBAColor(r: 5, g: 5, b: 5, a: 0.5)
        BGView.alpha = 0
        //        BGView.isHidden = true
        
        let tapGes1 = UITapGestureRecognizer.init(target: self, action: #selector(showChooseCondi(tap:)))
        tapGes1.numberOfTouchesRequired = 1
        BGView.addGestureRecognizer(tapGes1)
        self.view.addSubview(BGView)
        
        
        
        //MARK:   时间选择器背景
        datePickerView = UIView.init(frame: CGRect(x: 0, y: kSCREEN_HEIGHT, width: kSCREEN_WIDTH, height: DateHeight))
        datePickerView.backgroundColor = UIColor.white
        datePickerView.layer.cornerRadius = 16 * kSCREEN_SCALE
        
        
        pickerView = UIPickerView()
        //将dataSource设置成自己
        pickerView.dataSource = self
        //将delegate设置成自己
        pickerView.delegate = self
        //设置选择框的默认值
        pickerView.selectRow(0,inComponent:0,animated:true)
        pickerView.backgroundColor = UIColor.white
        pickerView.tintColor = kMainColor()
        pickerView.frame = CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: DateHeight-80)
        pickerView.layer.cornerRadius = 16 * kSCREEN_SCALE
        pickerView.isUserInteractionEnabled = true
        datePickerView.addSubview(pickerView)
        
        //MARK:  顶部需要显示三个控件
        let topView = UIView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 100 * kSCREEN_SCALE))
        topView.backgroundColor = kMainColor()
        topView.layer.cornerRadius = 16 * kSCREEN_SCALE
        
        //MARK:  取消按钮
        let cancel = UIButton.init(frame: CGRect(x: 15, y: 20 * kSCREEN_SCALE, width: 45, height: 60 * kSCREEN_SCALE))
        cancel.titleLabel?.font = kFont32
        cancel.setTitle("取消", for: .normal)
        cancel.setTitleColor(UIColor.white, for: .normal)
        cancel.addTarget(self, action: #selector(cancelAction(sender:)), for: .touchUpInside)
        topView.addSubview(cancel)
        
        //MARK:   确定按钮
        let contain = UIButton.init(frame: CGRect(x: kSCREEN_WIDTH - 60, y: 20 * kSCREEN_SCALE, width: 45, height: 60 * kSCREEN_SCALE))
        contain.titleLabel?.font = kFont32
        contain.setTitle("确定", for: .normal)
        contain.setTitleColor(UIColor.white, for: .normal)
        contain.addTarget(self, action: #selector(containAction(sender:)), for: .touchUpInside)
        topView.addSubview(contain)
        
        //MARK:  题目
        titleLabel = UILabel.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH - 120, height: 60 * kSCREEN_SCALE))
        titleLabel.text = "选择日期"
        titleLabel.font = kFont36
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .center
        titleLabel.center = topView.center
        
        topView.addSubview(titleLabel)
        
        datePickerView.addSubview(topView)
        
        //MARK:  因为需要设置圆角 还是只能上面有，所以我又给下面盖了一个。。。
        let theView = UIView.init(frame: CGRect(x: 0, y: 80 * kSCREEN_SCALE, width: kSCREEN_WIDTH, height: 20 * kSCREEN_SCALE))
        theView.backgroundColor = kMainColor()
        datePickerView.addSubview(theView)
        
        self.view.addSubview(datePickerView)
        
    }
    
    
    //MARK:      取消事件
    @objc func cancelAction(sender:UIButton) {
        UIView.animate(withDuration: 0.5) {
            self.datePickerView.transform = .identity
            self.BGView.alpha = 0
        }
    }
    
    @objc func containAction(sender:UIButton) {
        UIView.animate(withDuration: 0.5) {
            self.datePickerView.transform = .identity
            self.BGView.alpha = 0
            
        }
        
        
        if currentCount == 1 {
            deBugPrint(item: proArr[pickerView.selectedRow(inComponent: 0)])
            contents[2][0] = proArr[pickerView.selectedRow(inComponent: 0)]
            mainTableView.reloadSections([2], with: .none)
            
        }
        
        
        if currentCount == 2 {
            deBugPrint(item: gradeArr[pickerView.selectedRow(inComponent: 0)] + " " + detailArr[pickerView.selectedRow(inComponent: 1)])
            contents[2][1] = gradeArr[pickerView.selectedRow(inComponent: 0)] + " " + detailArr[pickerView.selectedRow(inComponent: 1)]
            mainTableView.reloadSections([2], with: .none)
            
        }
        
        
        if currentCount == 0 {
            deBugPrint(item: wayArr[pickerView.selectedRow(inComponent: 0)])
            contents[1][0] = wayArr[pickerView.selectedRow(inComponent: 0)]
            
            if wayArr[pickerView.selectedRow(inComponent: 0)] == "请好友帮忙"{
                way = "1"
                titles = [[""],["批改方式","选择老师"],["练习册科目","适用年纪"]]
                contents = [[""],[wayArr[pickerView.selectedRow(inComponent: 0)],""],["语文","六年级 下册"]]
            }else{
                titles = [[""],["批改方式","悬赏金额"],["练习册科目","适用年纪"]]
                contents = [[""],[wayArr[pickerView.selectedRow(inComponent: 0)],"学币"],["语文","六年级 下册"]]
                way = "2"
            }
            mainTableView.reloadSections([1], with: .none)
        }
    }
    
    
    @objc func showChooseCondi(tap:UITapGestureRecognizer) -> Void {
        if tap.view?.alpha == 1 {
            
            UIView.animate(withDuration: 0.5) {
                tap.view?.alpha = 0
                self.datePickerView.transform = .identity
            }
        }
    }
    
    
    //    弹出视图TagView的出现事件
    
    func showTheTagView() -> Void {
        let y = DateHeight - 40 * kSCREEN_SCALE
        
        UIView.animate(withDuration: 0.5) {
            self.datePickerView.transform = .init(translationX: 0, y: -y)
            self.BGView.alpha = 1
        }
    }
    
    
    //MARK:  ******代理 ：UIPickerViewDelegate,UIPickerViewDataSource
    //设置选择框的列数为3列,继承于UIPickerViewDataSource协议
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if currentCount == 2 {
            return 2
        }
        
        return 1
    }
    
    //设置选择框的行数为9行，继承于UIPickerViewDataSource协议
    func pickerView(_ pickerView: UIPickerView,numberOfRowsInComponent component: Int) -> Int {
        
        if currentCount == 1 {
            return proArr.count
        }
        
        
        if currentCount == 2 {
            
            if component == 0 {
                return gradeArr.count
            }else{
                return detailArr.count
            }
            
        }
        
        return wayArr.count
    }
    
    //设置选择框各选项的内容，继承于UIPickerViewDelegate协议
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int,
                    forComponent component: Int) -> String? {
        
        if currentCount == 1 {
            return proArr[row]
        }
        
        if currentCount == 2 {
            
            if component == 0 {
                return gradeArr[row]
            }else{
                return detailArr[row]
            }
        }
        
        return wayArr[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //将在滑动停止后触发，并打印出选中列和行索引
        deBugPrint(item: component)
        deBugPrint(item: row)
        
        //        contents = [[""],["悬赏学币","学币"],["语文","六年级下册"]]
        
        //        if currentCount == 1 {
        //            print(proArr[row])
        //            contents[2][0] = proArr[row]
        //            mainTableView.reloadSections([2], with: .none)
        //
        //        }
        //
        //        if currentCount == 2 {
        //            print(gradeArr[pickerView.selectedRow(inComponent: 0)] + " " + detailArr[pickerView.selectedRow(inComponent: 1)])
        //            contents[2][1] = gradeArr[pickerView.selectedRow(inComponent: 0)] + " " + detailArr[pickerView.selectedRow(inComponent: 1)]
        //            mainTableView.reloadSections([2], with: .none)
        //
        //        }
        //
        //        if currentCount == 0 {
        //            print(wayArr[row])
        //            contents[1][0] = wayArr[row]
        //            mainTableView.reloadSections([1], with: .none)
        //
        //        }
    }
    
    
    //   MARK: 请求网络上传作业
    func uploadWorkImage() {
        self.view.beginLoading()

        let cell = mainTableView.cellForRow(at: IndexPath.init(row: 1, section: 1)) as! CreateBookCell
        let cell2 = mainTableView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as! UpLoadWorkCell
        
        var params = [String:String]()
        
        if way == "1" {
            if model.userId == nil {
                setToast(str: "请选择好友")
                return
            }
        }
        
        if model.freind_id == nil {
            model.freind_id = "123456"
        }
        
        params = [
            "SESSIONID":SESSIONID,
            "mobileCode":mobileCode,
            "non_exercise_name":cell2.workDescrip.text!,
            "correct_way":way,
            "subject_id":contents[2][0],
            "classes_id":contents[2][1],
            "rewards":cell.titleTextField.text!,
            "freind_id":model.freind_id
        ]
        
        deBugPrint(item: params)
        var nameArr = [String]()
        nameArr.append("pre_photos1")
        nameArr.append("pre_photos2")
        
        netWorkForBulidnon_exercise(params: params, data: images, name: nameArr, success: { (datas) in
            
            let json = JSON(datas)
            
            if json["code"].stringValue == "1" {
                if self.delegate != nil {
                    self.delegate?.beginRefresh()
                    self.navigationController?.popViewController(animated: true)
                }
            }else{
                setToast(str: "上传失败")
            }
            
            self.view.endLoading()
        }) { (error) in
            self.view.endLoading()
        }
        
    }
    
    
    // 异步原图
    private func setupPhoto1(count:NSInteger,index:NSInteger) {
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
                
                if (self?.images.count)! > 2 {
                    self?.images[index] = image
                }else{
                    self?.images.append(image)
                }
                
                self?.mainTableView.reloadData()
                self?.dealImage(imageArr: imageArr, index: index)
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
        super.viewWillDisappear(animated)
        PopViewUtil.share.stopLoading()
    }
    
}
