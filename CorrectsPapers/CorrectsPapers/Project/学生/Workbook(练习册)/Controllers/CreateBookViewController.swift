//
//  CreateBookViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/14.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

let SuccessRefreshNotificationCenter = "SuccessRefreshNotificationCenter"


//protocol SuccessRefreshDelegate:NSObjectProtocol {
//    func beginRefresh()
//}

class CreateBookViewController: BaseViewController ,UIPickerViewDelegate,UIPickerViewDataSource{
//    var delegate : SuccessRefreshDelegate?

    //    背景蒙层
    var BGView = UIView()
    var currentCount = 1
    
    
    var dataArr = [Array<String>]()
     var pickerView:UIPickerView!
    var proArr = [String]()
    var gradeArr = [String]()
    var detailArr = [String]()
    var versionArr = [String]()

    var successfulView = UIView()

    var cover_photo = #imageLiteral(resourceName: "Upload-photos_fengmian")
    var edition_photo = #imageLiteral(resourceName: "Upload-photos_yinshuabanci")

    var images = [UIImage]()

    override func viewDidLoad() {
        super.viewDidLoad()
        rightBarButton()
        addBGViewAndPickerView()
    }
    
    func rightBarButton(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "完成", style: .plain, target: self, action: #selector(pushSearchClass(sender:)))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
    }
    
    @objc func pushSearchClass(sender:UIBarButtonItem) {
        
        let cell1 = mainTableView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as! CreateBookCell

        let params = [
            "SESSIONID":SESSIONID,
            "mobileCode":mobileCode,
            "work_book_name":cell1.titleTextField.text!,
            "subject_id":mainTableArr[0],
            "classes_id":mainTableArr[1],
            "edition_id":mainTableArr[2],
        ] as! [String : String]
        
        var nameArr = [String]()
        
        nameArr.append("cover_photo_1_image")
        nameArr.append("edition_photo_2_image")
        
        netWorkForBulidWrokBook(params: params, data: images, name: nameArr, success: { (success) in
//            if success["code"] as! String == "1" {
//                setToast(str: "创建成功")
//            }
            setToast(str: "创建成功")
            self.createSeccsessful()
//            self.navigationController?.popViewController(animated: true)
            
        }) { (error) in
            
        }
    }

        
    override func configSubViews() {
        
        images.append(cover_photo)
        images.append(edition_photo)

        self.navigationItem.title = "创建练习册"
        
        dataArr =  [["练习册名字"],["练习册科目","适用年级","教材版本"],[]]
        mainTableArr = ["语文","六年级 下册","第一版"]
        
        proArr = ["语文","数学","英语"]
        gradeArr = ["八年级","七年级","六年级"]
        detailArr = ["全册","上册","下册"]
        versionArr = ["人教版","苏教版","北师大版"]
        
        mainTableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: kSCREEN_HEIGHT - 64 ), style: .plain)
        mainTableView.dataSource = self;
        mainTableView.delegate = self;
        mainTableView.estimatedRowHeight = 143 * kSCREEN_SCALE;
        mainTableView.register(UINib(nibName: "CreateBookCell", bundle: nil), forCellReuseIdentifier: identyfierTable)
        mainTableView.register(UINib(nibName: "ChooseImageCell", bundle: nil), forCellReuseIdentifier: identyfierTable1)
        mainTableView.tableFooterView = UIView.init()
        self.view.addSubview(mainTableView)
    }
    
    
    //MARK:  创建成功
    func createSeccsessful() {
        
        successfulView = UIView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: kSCREEN_HEIGHT - 46))
        successfulView.backgroundColor = kBGColor()
        let imageView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: 200 * kSCREEN_SCALE, height: 200 * kSCREEN_SCALE))
        imageView.image = #imageLiteral(resourceName: "Suc_icon_default")
        imageView.center = CGPoint(x: successfulView.centerX, y: successfulView.centerY - 200 * kSCREEN_SCALE)
        successfulView.addSubview(imageView)
        
        let label = UILabel.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 18))
        label.textAlignment = .center
        label.textColor = kSetRGBColor(r: 255, g: 162, b: 0)
        label.center = CGPoint(x: successfulView.centerX, y: successfulView.centerY-40)
        label.font = kFont34
        label.numberOfLines = 2
        label.text = "成功创建练习册"
        successfulView.addSubview(label)
        
        let creatBook = UIButton.init(frame: CGRect(x: 0, y: 0, width: 120, height: 30))
        creatBook.setBackgroundImage(getNavigationIMG(27, fromColor: kSetRGBColor(r: 0, g: 200, b: 255), toColor: kSetRGBColor(r: 0, g: 162, b: 255)), for: .normal)
        creatBook.center = CGPoint(x: successfulView.centerX, y: successfulView.centerY + 10 * kSCREEN_SCALE)
        creatBook.setTitle("返回首页", for: .normal)
        creatBook.layer.cornerRadius = 5
        creatBook.clipsToBounds = true
        creatBook.addTarget(self, action: #selector(createBookDoneAction(sender:)), for: .touchUpInside)
        successfulView.addSubview(creatBook)
        
        self.mainTableView.addSubview(successfulView)
    }
    
    
    @objc func createBookDoneAction(sender:UIButton) {
       
//        通知中心
        NotificationCenter.default.post(name: Notification.Name(rawValue: SuccessRefreshNotificationCenter), object: self, userInfo: ["refresh":"begin"])
        
        self.navigationController?.popToViewController((self.navigationController?.childViewControllers[0])!, animated: true)
    }
    
    
    //MARK:  ******代理 ：UITableViewDataSource,UITableViewDelegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return 3
        }
        return 1
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return mainTableArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 2 {
            let cell : ChooseImageCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable1, for: indexPath) as! ChooseImageCell
            
            cell.selectionStyle = .none
            cell.chooseImagesAction = {
                
                if $0 == "111" {
                    self.setupPhoto1(count: 1, indexImage: 1)
                }else{
                    self.setupPhoto1(count: 1, indexImage: 0)
                }
            }
            
            cell.ChooseImageCellSetImage(image1: images[0] , image2: images[1] )
            return cell

        }else{
            let cell : CreateBookCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable, for: indexPath) as! CreateBookCell
            cell.selectionStyle = .default
            var isShow = false
            
            if indexPath.section == 0  {
                cell.accessoryType = .none
            }
            
            if indexPath.section == 0 {
                isShow = true
            }
            
            cell.showForCreateBook(isShow: isShow, title:  dataArr[indexPath.section][indexPath.row], subTitle: mainTableArr[indexPath.row] as! String)
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 1 {
            
            currentCount = indexPath.row
            pickerView.reloadAllComponents()
            showTheTagView()
            
            if indexPath.row == 0 {
                titleLabel.text = "选择科目"
            }
            
            if indexPath.row == 1 {
                titleLabel.text = "选择适用年级"
            }

            if indexPath.row == 2 {
                titleLabel.text = "选择教材版本"
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 20))
        view.backgroundColor = kGaryColor(num: 244)
        return view
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 20))
        view.backgroundColor = kGaryColor(num: 244)
        return view
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 19
    }
    
    
    var datePickerView = UIView()
    var titleLabel = UILabel()
    
    func addBGViewAndPickerView() {
        
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
    //MARK:      确定事件
    @objc func containAction(sender:UIButton) {
        UIView.animate(withDuration: 0.5) {
            self.datePickerView.transform = .identity
            self.BGView.alpha = 0
            
        }
        
        
        if currentCount == 0 {
            deBugPrint(item: proArr[pickerView.selectedRow(inComponent: 0)])
            mainTableArr[currentCount] = proArr[pickerView.selectedRow(inComponent: 0)]
            
        }
        
        if currentCount == 1 {
            deBugPrint(item: gradeArr[pickerView.selectedRow(inComponent: 0)] + " " + detailArr[pickerView.selectedRow(inComponent: 1)])
            mainTableArr[currentCount] = gradeArr[pickerView.selectedRow(inComponent: 0)] + " " + detailArr[pickerView.selectedRow(inComponent: 1)]
            
        }
        
        if currentCount == 2 {
            deBugPrint(item: versionArr[pickerView.selectedRow(inComponent: 0)])
            mainTableArr[currentCount] = versionArr[pickerView.selectedRow(inComponent: 0)]
            
        }
        mainTableView.reloadSections([1], with: .none)

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
        if currentCount == 1 {
            return 2
        }
        
        return 1
    }
    
    //设置选择框的行数为9行，继承于UIPickerViewDataSource协议
    func pickerView(_ pickerView: UIPickerView,numberOfRowsInComponent component: Int) -> Int {
        
        if currentCount == 0 {
            return proArr.count
        }
        
        
        if currentCount == 1 {
            
            if component == 0 {
                return gradeArr.count
            }else{
                return detailArr.count
            }
            
        }
        
        return versionArr.count
    }
    
    //设置选择框各选项的内容，继承于UIPickerViewDelegate协议
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int,
                    forComponent component: Int) -> String? {
        
        if currentCount == 0 {
            return proArr[row]
        }
        
        if currentCount == 1 {
            
            if component == 0 {
                return gradeArr[row]
            }else{
                return detailArr[row]
            }
            
        }
        
        return versionArr[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //将在滑动停止后触发，并打印出选中列和行索引
        deBugPrint(item: component)
        deBugPrint(item: row)
    }
    
//    //设置列宽
//    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
//        if(0 == component){
//            //第一列变宽
//            return 100
//        }else{
//            //第二、三列变窄
//            return 30
//        }
//    }
//
//    //设置行高
//    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
//        return 50
//    }

    
//    选择框选项的内容，除了可以使字符串类型的，还可以是任意UIView类型的元素。比如我们将选项内容设置为图片：
//    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int,
//                    reusing view: UIView?) -> UIView {
//        let image = UIImage(named:"icon_"+String(row))
//        let imageView = UIImageView()
//        imageView.image = image
//        return imageView
//    }
//
    // 异步原图
    private func setupPhoto1(count:NSInteger,indexImage:NSInteger) {
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
                
                if indexImage == 1 {
                    self?.images[0] = image
                }else{
                    self?.images[1] = image
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
    

}
