//
//  Non-WorkBookViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/10.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyJSON


class Non_WorkBookViewController: BaseViewController ,UIPickerViewDelegate,UIPickerViewDataSource,HBAlertPasswordViewDelegate{
    
    var typeArr = NSMutableArray()
    var headView = UIView()
    var underLine = UIView()
    
    var currentIndex = 1
    
    var workState = 0
    
    var images = NSMutableArray()
    
    var contents = [Array<String>]()
    var titles = [Array<String>]()
    
    var dateBtn = UIButton()
    
    
    var titleArr1 = ["本节课课程视频","本节课讲义下载","本节课作业下载"]
    var titleArr3 = ["作业视频讲解","作业答案文档下载","文字版答案"]
    
    var currentTitle1 = ""
    var currentTitle2 = ""
    var footBtnView = UIView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBGViewAndPickerView()
        addTimeSelector()
    }
    
    override func leftBarButton() {
        
    }
    
    override func configSubViews() {
        self.navigationItem.title = "非练习册"
        
        titles = [[""],["批改方式","选择老师","悬赏金额"],["练习册科目","适用年纪"]]
        contents = [[""],["悬赏学币","","学币"],["语文","六年级 下册"]]
        
        contents[0][0] = "卧槽"
        
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
        
        let kSpace = CGFloat(kSCREEN_WIDTH - totalWidth)/6
        
        for index in 0...typeArr.count-1{
            
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
        
        //        dateBtn = UIButton.init(frame: CGRect(x: 0, y: 44 , width: kSCREEN_WIDTH, height: 40))
        //        dateBtn.backgroundColor = UIColor.white
        //        dateBtn.setTitle("2017/10/15", for: .normal)
        //        dateBtn.titleLabel?.font = kFont30
        //        dateBtn.setTitleColor(kGaryColor(num: 164), for: .normal)
        //        dateBtn.setImage(#imageLiteral(resourceName: "xiala_icon_default"), for: .normal)
        //        dateBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -35, 0, 0)
        //        dateBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 145, 0, 0)
        //
        //        dateBtn.addTarget(self, action: #selector(chooseDateAction(sender:)), for: .touchUpInside)
        //        headView.addSubview(dateBtn)
        
        let line = UIView.init(frame: CGRect(x: 0, y: 42 , width: kSCREEN_WIDTH, height: 1))
        line.backgroundColor = kGaryColor(num: 223)
        headView.addSubview(line)
        
        //        let line2 = UIView.init(frame: CGRect(x: 0, y: 81 , width: kSCREEN_WIDTH, height: 1))
        //        line2.backgroundColor = kGaryColor(num: 223)
        //        headView.addSubview(line2)
        //
        
        let view = headView.viewWithTag(131) as! UIButton
        view.setTitleColor(kMainColor(), for: .normal)
        underLine = UIView.init(frame: CGRect(x: 0, y: 41, width: getLabWidth(labelStr: "等我粉丝", font: kFont32, height: 1) - 5, height: 2))
        underLine.backgroundColor = kMainColor()
        underLine.layer.cornerRadius = 1
        underLine.clipsToBounds = true
        underLine.center.x = view.center.x
        headView.addSubview(underLine)
        
        headView.backgroundColor = UIColor.white
        self.view.addSubview(headView)
        
        
        mainTableView = UITableView.init(frame: CGRect(x: 0, y: 43, width: kSCREEN_WIDTH, height: kSCREEN_HEIGHT - 64 - 43), style: .plain)
        mainTableView.dataSource = self;
        mainTableView.delegate = self;
        mainTableView.estimatedRowHeight = 342
        mainTableView.tableFooterView = UIView.init()
        
        //        mainTableView.register(AnserImageCell.self, forCellReuseIdentifier: identyfierTable)
        mainTableView.register(UINib(nibName: "AnserImageCell", bundle: nil), forCellReuseIdentifier: identyfierTable)
        mainTableView.register(UINib(nibName: "UpLoadWorkCell", bundle: nil), forCellReuseIdentifier: identyfierTable1)
        mainTableView.register(UINib(nibName: "CheckWorkCell", bundle: nil), forCellReuseIdentifier: identyfierTable2)
        mainTableView.register(UINib(nibName: "AnserVideoCell", bundle: nil), forCellReuseIdentifier: identyfierTable3)
        mainTableView.register(UINib(nibName: "ClassGradeCell", bundle: nil), forCellReuseIdentifier: identyfierTable4)
        mainTableView.register(UINib(nibName: "CreateBookCell", bundle: nil), forCellReuseIdentifier: identyfierTable5)
        
        //        mainTableView.tableHeaderView = headView
        self.view.addSubview(mainTableView)
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
        
        if currentIndex == 2 {
            currentTitle1 = (sender.titleLabel?.text)!
        }else{
            currentTitle2 = (sender.titleLabel?.text)!
        }
    }
    
    
    @objc func chooseDateAction(sender:UIButton) {
        deBugPrint(item: NSDate())
        showDatePickerView()
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
        
        
        if currentIndex == 2 {
            footView(titles: titleArr1)
        }else if currentIndex == 3 {
            footView(titles: titleArr3)
        }else{
            footBtnView.removeFromSuperview()
        }

        
        if currentIndex > 2 {
            mainTableArr = []
        }
        
        mainTableArr = ["性别","年龄","地区","积分","身高","体重"]
        
        mainTableView.reloadData()
    }
    
    
    //MARK:  ******代理 ：UITableViewDataSource,UITableViewDelegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if currentIndex == 4 {
            return 20
        }
        
        
        if currentIndex == 1 {
            
            if workState == 3 || workState == 4 {
                return 2
            }
            
            if workState == 0{
                
                return contents[section].count
                
            }
            
        }
        
        
        if currentIndex == 3 {
            return 3-titleArr3.count
        }

        if currentIndex == 2 {
            return 3-titleArr1.count
        }

        
        return 1
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        if currentIndex == 1 && workState == 0 {
            return contents.count
        }
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if currentIndex == 1 && workState == 0 {
            
            if  indexPath.section == 0 {
                let cell : UpLoadWorkCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable1, for: indexPath) as! UpLoadWorkCell
                cell.upLoadImagesForWorkBook(images: images as! Array<UIImage>)
                cell.chooseImagesAction = {
                    deBugPrint(item: $0)
                    
                    if $0 == "upLoad" {
                        
                        self.uploadWorkImage()
                    }else{
                        
                        self.setupPhoto1(count: 2)
                    }
                }
                
                return cell
            }
            
            let cell : CreateBookCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable5, for: indexPath) as! CreateBookCell
            
            if indexPath.section == 1 && indexPath.row == 2{
                cell.showForCreate(isShow: true, title: titles[indexPath.section][indexPath.row], subTitle: contents[indexPath.section][indexPath.row])
                cell.accessoryType = .none
            }else{
                cell.showForCreate(isShow: false, title: titles[indexPath.section][indexPath.row], subTitle: contents[indexPath.section][indexPath.row])
                cell.accessoryType = .disclosureIndicator
                
            }
            
            cell.selectionStyle = .none
            return cell
        }
        
        if currentIndex == 1 && workState == 1 && indexPath.row == 0{
            let cell : CheckWorkCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable2, for: indexPath) as! CheckWorkCell
            
//            cell.checkWorkCellSetValues1()
            return cell
            
        }
        
        if currentIndex == 1 && workState == 2 {
            
            if indexPath.row == 0 {
                let cell : CheckWorkCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable2, for: indexPath) as! CheckWorkCell
//                cell.checkWorkCellSetValues2()
                return cell
                
            }
            
        }
        
        if currentIndex == 1 && workState == 3 {
            
            if  indexPath.row == 0 {
                let cell : CheckWorkCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable2, for: indexPath) as! CheckWorkCell
//                cell.checkWorkCellSetValues3()
                return cell
                
            }
            
            let cell : UpLoadWorkCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable1, for: indexPath) as! UpLoadWorkCell
            cell.upLoadImagesForResubmit(images: images as! Array<UIImage>)
            
            cell.chooseImagesAction = {
                deBugPrint(item: $0)
                
                self.setupPhoto1(count: 2)
            }
            
            return cell
        }
        
        if currentIndex == 1 && workState == 4 {
            
            if  indexPath.row == 0 {
                let cell : CheckWorkCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable2, for: indexPath) as! CheckWorkCell
                
//                cell.checkWorkCellSetValues3()
                return cell
                
            }
            
            let cell : CheckWorkCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable2, for: indexPath) as! CheckWorkCell
            
//            cell.checkWorkCellSetValues4(model: )
            return cell
        }
        
        if currentIndex == 2 {
            
            let cell : AnserVideoCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable3, for: indexPath) as! AnserVideoCell
            return cell
            
        }else if currentIndex == 3 {
            
            let cell : AnserImageCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable, for: indexPath) as! AnserImageCell
            return cell
            
        }
        let cell : ClassGradeCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable4, for: indexPath) as! ClassGradeCell
        
        if indexPath.row == 0 {
            cell.is1thCell()
        }else{
            cell.setValueForClassGradeCell(index: 10-indexPath.row)
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if currentIndex == 1 && workState == 0 && indexPath.section != 0{
            
            if indexPath.section == 1 && indexPath.row == 1 {
                
                let chooseVC = ChooseTeacherCorrectVC()
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
        
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 && currentIndex == 1{
            dateBtn = UIButton.init(frame: CGRect(x: 0, y: 44 , width: kSCREEN_WIDTH, height: 40))
            dateBtn.backgroundColor = UIColor.white
            dateBtn.setTitle("2017/10/15", for: .normal)
            dateBtn.titleLabel?.font = kFont30
            dateBtn.setTitleColor(kGaryColor(num: 164), for: .normal)
            dateBtn.setImage(#imageLiteral(resourceName: "xiala_icon_default"), for: .normal)
            dateBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -35, 0, 0)
            dateBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 145, 0, 0)
            
            dateBtn.addTarget(self, action: #selector(chooseDateAction(sender:)), for: .touchUpInside)
            
            let line2 = UIView.init(frame: CGRect(x: 0, y: 43 , width: kSCREEN_WIDTH, height: 1))
            line2.backgroundColor = kGaryColor(num: 223)
            dateBtn.addSubview(line2)
            
            return dateBtn
        }
        
        return UIView()
        
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 && currentIndex == 1 {
            return 44
        }
        
        return 0
    }
    
    
    
    // 异步原图
    private func setupPhoto1(count:NSInteger) {
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
                
                self?.images.add(image)
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
                titles = [[""],["批改方式","选择好友","悬赏金额"],["练习册科目","适用年纪"]]
            }else{
                titles = [[""],["批改方式","选择老师","悬赏金额"],["练习册科目","适用年纪"]]
            }
            mainTableView.reloadSections([1], with: .none)
        }
    }
    
    
    @objc func showChooseCondi(tap:UITapGestureRecognizer) -> Void {
        if tap.view?.alpha == 1 {
            
            UIView.animate(withDuration: 0.5) {
                tap.view?.alpha = 0
                self.datePickerView.transform = .identity
                self.datePickerBGView.transform = .identity
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
    
    
    var datePickerBGView = UIView()
    var datePicker = UIDatePicker()
    
    func addTimeSelector() {
        
        //MARK:   时间选择器背景
        datePickerBGView = UIView.init(frame: CGRect(x: 0, y: kSCREEN_HEIGHT, width: kSCREEN_WIDTH, height: DateHeight))
        datePickerBGView.backgroundColor = UIColor.white
        datePickerBGView.layer.cornerRadius = 16 * kSCREEN_SCALE
        
        //MARK:  把datapicker的背景设为透明，这个selecView可以模拟选择栏
        let selectView = UIView.init(frame: CGRect(x: 0, y: DateHeight/2-17, width: kSCREEN_WIDTH, height: 34))
        selectView.backgroundColor = kSetRGBColor(r: 255, g: 138, b: 146)
        //        selectView.center = datePickerView.center
        datePickerBGView.addSubview(selectView)
        
        
        //创建日期选择器
        datePicker = UIDatePicker(frame: CGRect(x:0, y: 0, width:kSCREEN_WIDTH, height:DateHeight))
        //将日期选择器区域设置为中文，则选择器日期显示为中文
        datePicker.locale = Locale(identifier: "zh_CN")
        
        datePicker.addTarget(self, action: #selector(dateChanged),
                             for: .valueChanged)
        datePicker.backgroundColor = UIColor.clear
        datePicker.datePickerMode = .date
        datePicker.maximumDate = NSDate.init(timeIntervalSinceNow: 0) as Date
        datePicker.minimumDate = NSDate.init(timeIntervalSinceNow: -1296000) as Date
        datePickerBGView.addSubview(datePicker)
        
        //MARK:  顶部需要显示三个控件
        let topView = UIView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 100 * kSCREEN_SCALE))
        topView.backgroundColor = kMainColor()
        topView.layer.cornerRadius = 16 * kSCREEN_SCALE
        
        //MARK:  取消按钮
        let cancel = UIButton.init(frame: CGRect(x: 15, y: 20 * kSCREEN_SCALE, width: 45, height: 60 * kSCREEN_SCALE))
        cancel.titleLabel?.font = kFont32
        cancel.setTitle("取消", for: .normal)
        cancel.setTitleColor(UIColor.white, for: .normal)
        cancel.addTarget(self, action: #selector(cancelActionDate(sender:)), for: .touchUpInside)
        topView.addSubview(cancel)
        
        //MARK:   确定按钮
        let contain = UIButton.init(frame: CGRect(x: kSCREEN_WIDTH - 60, y: 20 * kSCREEN_SCALE, width: 45, height: 60 * kSCREEN_SCALE))
        contain.titleLabel?.font = kFont32
        contain.setTitle("确定", for: .normal)
        contain.setTitleColor(UIColor.white, for: .normal)
        contain.addTarget(self, action: #selector(containActionDate(sender:)), for: .touchUpInside)
        topView.addSubview(contain)
        
        //MARK:  题目
        let titleLabel = UILabel.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH - 120, height: 60 * kSCREEN_SCALE))
        titleLabel.text = "选择日期"
        titleLabel.font = kFont36
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .center
        titleLabel.center = topView.center
        
        topView.addSubview(titleLabel)
        
        datePickerBGView.addSubview(topView)
        
        //MARK:  因为需要设置圆角 还是只能上面有，所以我又给下面盖了一个。。。
        let theView = UIView.init(frame: CGRect(x: 0, y: 80 * kSCREEN_SCALE, width: kSCREEN_WIDTH, height: 20 * kSCREEN_SCALE))
        theView.backgroundColor = kMainColor()
        datePickerBGView.addSubview(theView)
        self.view.addSubview(datePickerBGView)
        
    }
    
    
    //MARK: 模拟蒙层的点击事件 隐藏
    @objc func showChooseCondition(tap:UITapGestureRecognizer) -> Void {
        if tap.view?.alpha == 1 {
            
            UIView.animate(withDuration: 0.5) {
                tap.view?.alpha = 0
                self.datePickerBGView.transform = .identity
                
            }
        }
    }
    
    //MARK://日期选择器响应方法
    @objc func dateChanged(datePicker : UIDatePicker){
        //更新提醒时间文本框
        let formatter = DateFormatter()
        //日期样式
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        
        deBugPrint(item: formatter.string(from: datePicker.date))
    }
    
    
    //MARK:      取消事件
    @objc func cancelActionDate(sender:UIButton) {
        UIView.animate(withDuration: 0.5) {
            self.datePickerBGView.transform = .identity
            self.BGView.alpha = 0
        }
    }
    
    @objc func containActionDate(sender:UIButton) {
        UIView.animate(withDuration: 0.5) {
            self.datePickerBGView.transform = .identity
            self.BGView.alpha = 0
            
            let formatter = DateFormatter()
            //日期样式
            formatter.dateFormat = "yyyy/MM/dd"
            deBugPrint(item: formatter.string(from: self.datePicker.date))
            self.dateBtn.setTitle(formatter.string(from: self.datePicker.date), for: .normal)
        }
    }
    
    //MARK:   弹出视图DatePicker的出现事件
    func showDatePickerView() -> Void {
        
        //        let y = DateHeight - 80 * kSCREEN_SCALE
        
        UIView.animate(withDuration: 0.5) {
            self.datePickerBGView.transform = .init(translationX: 0, y: -DateHeight)
            self.BGView.alpha = 1
        }
        
    }
    
    
    //   MARK: 请求网络上传作业
    func uploadWorkImage() {
        
        let cell = mainTableView.cellForRow(at: IndexPath.init(row: 1, section: 1)) as! CreateBookCell
        let cell2 = mainTableView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as! UpLoadWorkCell

        let params =
            [
                "SESSIONID":SESSIONID,
                "mobileCode":mobileCode,
                "non_exercise_name":cell2.workDescrip.text!,
//                "correct_way":contents[1][0],
//                "subject_id":contents[2][0],
//                "classes_id":contents[2][1],
                "correct_way":"1",
                "subject_id":"1",
                "classes_id":"1",
                "rewards":cell.titleTextField.text!,
                "freind_id":"1"
                ]
        
        deBugPrint(item: params)
        var imgArr = [UIImage]()
        var nameArr = [String]()
        
        imgArr.append(cell2.image2.image!)
        imgArr.append(cell2.image3.image!)

        nameArr.append("User_headImage1")
        nameArr.append("User_headImage2")
        
        netWorkForBulidnon_exercise(params: params, data: imgArr, name: nameArr, success: { (datas) in
            
        }) { (error) in
            
        }
        
    }
    
    //    HBAlertPasswordViewDelegate 密码弹框代理
    func sureAction(with alertPasswordView: HBAlertPasswordView!, password: String!) {
        alertPasswordView.removeFromSuperview()
        setToast(str: "输入的密码为:"+password)
        if currentIndex == 1 {
            
            titleArr1.remove(at: titleArr1.index(of: currentTitle1)!)
            footView(titles: titleArr1)
            mainTableView.reloadData()
        }else{
            
            titleArr3.remove(at: titleArr3.index(of: currentTitle2)!)
            footView(titles: titleArr3)
            mainTableView.reloadData()
        }
    }

    
    
    override func viewWillDisappear(_ animated: Bool) {
        PopViewUtil.share.stopLoading()
    }
}
