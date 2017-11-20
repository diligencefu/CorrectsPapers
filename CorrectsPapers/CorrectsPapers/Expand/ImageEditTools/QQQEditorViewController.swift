//
//  QQQEditorViewController.swift
//  testDemoSwift
//
//  Created by 陈亮陈亮 on 2017/5/22.
//  Copyright © 2017年 陈亮陈亮. All rights reserved.
//

import UIKit

class QQQEditorViewController: UIViewController {
    
    // 模式
    @IBOutlet weak var typeLable: UILabel!
    // 画笔
    @IBOutlet weak var pencilBtn: UIButton!
    // 橡皮擦
    @IBOutlet weak var eraserBtn: UIButton!
    // 设置view
    @IBOutlet weak var settingView: UIView!
    // 需要编辑的图片
    var editorImage: UIImage!
    
    var scrollView: UIScrollView!
    // 画板
    var drawBoardImageView: DrawBoard!
    
    // 涂鸦的背景样式
    @IBOutlet weak var pencilImage: UIImageView!
    // 控制画笔的粗细
    @IBOutlet weak var slideView: UISlider!
    // 撤回
    @IBOutlet weak var backBtn: UIButton!
    // 前进
    @IBOutlet weak var forwardBtn: UIButton!
    // 还原
    @IBOutlet weak var returnBtn: UIButton!
    
    @IBOutlet weak var editBtn: UIButton!
    
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userNum: UILabel!
    @IBOutlet weak var backView: UIView!
    
    var images = [UIImage]()
    var currentIndex = 0
    
    var theName = ""
    var theNum = ""
    var bookid = ""
    var bookState = ""
    var doneImages = [UIImage]()
    
    
    
    var markView = GiveMarkView()
    var BGView = UIView()

    
    
    var lastScaleFactor : CGFloat! = 1  //放大、缩小
    
    lazy var choosePencilView: PencilChooseView = {
        let chooseView = PencilChooseView.init(frame: CGRect(x: 0, y: KScreenHeight, width: KScreenWidth, height: 40))
        chooseView.clickPencilImage = {[weak self] (img:UIImage) in
            self?.drawBoardImageView.strokeColor = UIColor(patternImage: img)
            self?.pencilImage.image = img
            self?.choosePencilViewDismiss()
            
            // 先判断是不是文本，如果是文本，直接设置文本的颜色
            if self?.drawBoardImageView.brush?.classForKeyedArchiver == InputBrush.classForCoder() {
                return
            }
            
            // 马赛克
            if img == UIImage(named: "11") {
                self?.drawBoardImageView?.brush = RectangleBrush()
            } else if img == UIImage(named: "12") {  // 高斯模糊
                self?.drawBoardImageView?.brush = GaussianBlurBrush()
            } else {
                self?.drawBoardImageView?.brush = PencilBrush()
            }
            self?.pencilBtn.isSelected = true
            self?.eraserBtn.isSelected = false
        }
        return chooseView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.navigationController?.navigationBar.isHidden = true
        typeLable.textColor = kMainColor()
        backView.clipsToBounds = true
        backView.layer.cornerRadius = 20
        
        userNum.text = theNum
        userName.text = theName
        
        initView()
        addMarkView()
    }
    
    
    func initView() {
        pencilBtn.setTitleColor(kMainColor(), for: .selected)
        pencilBtn.setTitleColor(UIColor.black, for: .normal)
        eraserBtn.setTitleColor(kMainColor(), for: .selected)
        eraserBtn.setTitleColor(UIColor.black, for: .normal)
        editBtn.setTitleColor(kMainColor(), for: .selected)
        editBtn.setTitleColor(UIColor.black, for: .normal)

        backBtn.isEnabled = false
        forwardBtn.isEnabled = false
        
//        slideView.setThumbImage(UIImage(named:"dian"), for: .normal)
        
        slideView.thumbTintColor = kMainColor()
        slideView.value = 0.3
        
        pencilImage.layer.cornerRadius = 4
        pencilImage.layer.masksToBounds = true
        pencilImage.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(QQQEditorViewController.clickPencilImageView)))
                
        scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: 0, width: KScreenWidth, height: KScreenHeight-50-40)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 10
//        self.view.addSubview(scrollView!)
        self.view.insertSubview(scrollView!, at: 0)
        
        drawBoardImageView = DrawBoard.init(frame:scrollView.bounds)
        drawBoardImageView.isUserInteractionEnabled = true
        // 对长图压缩处理
        let scaleImage = UIImage.scaleImage(image: images[currentIndex])
        drawBoardImageView.backgroundColor = UIColor(patternImage: scaleImage)
        drawBoardImageView.currentImage = scaleImage
        drawBoardImageView.masicImage = UIImage.trans(toMosaicImage: images[currentIndex], blockLevel: 20)
        scrollView?.addSubview(drawBoardImageView)
        drawBoardImageView.beginDraw = {[weak self]() in
            self?.backBtn.isEnabled = true
        }
        drawBoardImageView.unableDraw = {[weak self]() in
            self?.backBtn.isEnabled = false
        }
        drawBoardImageView.reableDraw = {[weak self]() in
            self?.forwardBtn.isEnabled = false
        }
        
        // 默认的画笔
        self.drawBoardImageView.strokeColor = UIColor(patternImage: UIImage(named: "clr_black")!)
        self.pencilImage.image = UIImage(named: "clr_black")!
        self.typeLable.text = "拖动模式"
    }

    
    //MARK: - 选择画笔颜色
    @objc func clickPencilImageView(){
        self.view.addSubview(self.choosePencilView)
        self.view.bringSubview(toFront: self.settingView)
        self.choosePencilView.cl_y = self.settingView.cl_y
        UIView.animate(withDuration: 0.3) {
            self.choosePencilView.cl_y = self.settingView.cl_y-40
        }
    }
    //MARK: - 选择画笔结束
    func choosePencilViewDismiss() {
        UIView.animate(withDuration: 0.3, animations: {
            self.choosePencilView.cl_y = self.settingView.cl_y
        }) { (true) in
            self.choosePencilView.removeFromSuperview()
        }
    }
    
    
    //MARK: - 编辑,文本输入
    @IBAction func editingAction(_ sender: UIButton) {
        
        if  self.typeLable.text == "编辑模式" {
            self.scrollView.isScrollEnabled = true
            drawBoardImageView?.brush = nil
            self.typeLable.text = "拖动模式"
            self.editBtn.isSelected = false
            kHiddenTextView = 11151635
        }else{
            self.typeLable.text = "编辑模式"
            self.scrollView.isScrollEnabled = false
            self.pencilBtn.isSelected = false
            self.eraserBtn.isSelected = false
            self.drawBoardImageView.brush = InputBrush()
            self.editBtn.isSelected = true
            kHiddenTextView = 11111
        }
    }
    
    
    //MARK: - 改变画笔大小
    @IBAction func clickSlide(_ sender: Any) {
        // 先判断是不是文本，如果是文本，直接设置文本的颜色
        if self.drawBoardImageView.brush?.classForKeyedArchiver == InputBrush.classForCoder() {
            drawBoardImageView.textFont = UIFont.systemFont(ofSize: CGFloat(self.slideView.value*35+8))
            return
        }
        drawBoardImageView.strokeWidth = CGFloat(self.slideView.value*15)
        
//        kFontSize = Int(self.slideView.value*15+12)
//        print(kFontSize)
    }
    //MARK: - 点击了画笔
    @IBAction func clickPencilBtn(_ sender: Any) {
        
        self.pencilBtn?.isSelected = !(self.pencilBtn?.isSelected)!
        if (self.pencilBtn?.isSelected)! {
            self.scrollView.isScrollEnabled = false
            self.pencilBtn?.isSelected = true
            self.eraserBtn?.isSelected = false
            self.editBtn.isSelected = false
            self.typeLable.text = "画笔模式"
            
            // 先判断是不是模糊矩形
            if self.pencilImage.image == UIImage(named: "11") {
                drawBoardImageView?.brush = RectangleBrush()
            } else if self.pencilImage.image == UIImage(named: "12") {  // 高斯模糊
                drawBoardImageView?.brush = GaussianBlurBrush()
            } else {
                drawBoardImageView?.brush = PencilBrush()
            }
        } else {
            self.scrollView.isScrollEnabled = true
            self.pencilBtn?.isSelected = false
            self.typeLable.text = "拖动模式"
            drawBoardImageView?.brush = nil
        }
    }
    //MARK: - 点击了橡皮擦
    @IBAction func clickEraserBtn(_ sender: Any) {
        self.eraserBtn?.isSelected = !(self.eraserBtn?.isSelected)!
        if (self.eraserBtn?.isSelected)! {
            
            self.typeLable.text = "橡皮擦模式"
            
            self.scrollView.isScrollEnabled = false
            self.pencilBtn?.isSelected = false
            self.eraserBtn?.isSelected = true
            self.editBtn.isSelected = false
            drawBoardImageView?.brush = EraserBrush()
        } else {
            self.scrollView.isScrollEnabled = true
            self.pencilBtn?.isSelected = false
            drawBoardImageView?.brush = nil
            self.typeLable.text = "拖动模式"
        }
    }
    //MARK: - 撤回
    @IBAction func clickBackBtn(_ sender: Any) {
        if self.drawBoardImageView.canBack() {
            self.backBtn.isEnabled = true
            self.forwardBtn.isEnabled = true
            drawBoardImageView?.undo()
        } else {
            self.backBtn.isEnabled = false
        }
    }
    //MARK: - 向前
    @IBAction func clickForWardBtn(_ sender: Any) {
        if self.drawBoardImageView.canForward() {
            self.forwardBtn.isEnabled = true
            self.backBtn.isEnabled = true
            drawBoardImageView?.redo()
        } else {
            self.forwardBtn.isEnabled = false
        }
    }
    //MARK: - 还原
    @IBAction func ClickReturnBtn(_ sender: Any) {
        
        let alertController = UIAlertController(title: "提示",message: "您确定要还原图片吗？", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "确定", style: .default, handler: {
            action in
            self.drawBoardImageView?.retureAction()
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    @IBAction func popAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func changeToNextImage(_ sender: UIButton) {
        setToast(str: "换图")
        currentIndex = currentIndex+1
        
        if currentIndex < images.count+1 {
            let doneImage = self.drawBoardImageView.takeImage()
            self.doneImages.append(doneImage)
            print(doneImage)
        }
        
        if currentIndex < images.count {
            drawBoardImageView.removeFromSuperview()

//            编辑后的图片
            editorImage = images[currentIndex]
            // 对长图压缩处理
            let scaleImage = UIImage.scaleImage(image: self.editorImage)
            drawBoardImageView.backgroundColor = UIColor(patternImage: scaleImage)
            drawBoardImageView.currentImage = scaleImage
            drawBoardImageView.masicImage = UIImage.trans(toMosaicImage: self.editorImage, blockLevel: 20)
            scrollView?.addSubview(drawBoardImageView)
            drawBoardImageView.beginDraw = {[weak self]() in
                self?.backBtn.isEnabled = true
            }
            
            drawBoardImageView.unableDraw = {[weak self]() in
                self?.backBtn.isEnabled = false
            }
            
            drawBoardImageView.reableDraw = {[weak self]() in
                self?.forwardBtn.isEnabled = false
            }
            
            self.drawBoardImageView?.retureAction()
            scrollView.zoomScale = 1
        }else{
            showTheMarkView()
            setToast(str: "This is the last one.")
        }
    }
    
    
    func  addMarkView() {
        
        //        弹出视图弹出来之后的背景蒙层
        BGView = UIView.init(frame: self.view.frame)
        BGView.backgroundColor = kSetRGBAColor(r: 5, g: 5, b: 5, a: 0.5)
        BGView.alpha = 0
        //        BGView.isHidden = true
        
        let tapGes1 = UITapGestureRecognizer.init(target: self, action: #selector(showChooseCondi(tap:)))
        tapGes1.numberOfTouchesRequired = 1
        BGView.addGestureRecognizer(tapGes1)
        self.view.addSubview(BGView)
        
        markView = UINib(nibName:"GiveMarkView",bundle:nil).instantiate(withOwner: self, options: nil).first as! GiveMarkView
        markView.frame =  CGRect(x: 0, y: kSCREEN_HEIGHT, width: kSCREEN_WIDTH, height: 236)
        markView.layer.cornerRadius = 24*kSCREEN_SCALE
        markView.selectBlock = {
            if $1 {
                print($0)
                print($2)
                
                if self.bookState == "2" {
//                    第一次
                }else if self.bookState == "5" {
//                    第二次
                }
                self.dismiss(animated: true, completion: nil)
            }
            self.hiddenViews()
        }
        markView.clipsToBounds = true
        self.view.addSubview(markView)
    }
    
    
    @objc func showChooseCondi(tap:UITapGestureRecognizer) -> Void {
        
        if tap.view?.alpha == 1 {
            UIView.animate(withDuration: 0.5) {
                tap.view?.alpha = 0
                self.markView.transform = .identity
            }
        }
    }
    
    
    func hiddenViews() {
        
        UIView.animate(withDuration: 0.5) {
            self.BGView.alpha = 0
            self.markView.transform = .identity
        }
    }
    
    func showTheMarkView() -> Void {
        
        let y = 225
        UIView.animate(withDuration: 0.5) {
            self.markView.transform = .init(translationX: 0, y: CGFloat(-y))
            self.BGView.alpha = 1
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        kHiddenTextView = 11151635
    }
    
}


extension QQQEditorViewController:UIScrollViewDelegate{
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return drawBoardImageView
    }
    
    
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        drawBoardImageView?.brush = nil
        self.pencilBtn?.isSelected = false
        self.eraserBtn?.isSelected = false
        self.scrollView.isScrollEnabled = true
    }
}
