//
//  ShowTagsView.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/25.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class ShowTagsView: UIView ,UIPickerViewDelegate,UIPickerViewDataSource{


    @IBOutlet weak var cancelBtn: UIButton!
    
    @IBOutlet weak var viewTitle: UILabel!
    
    @IBOutlet weak var certainBtn: UIButton!
    
    @IBOutlet weak var tagsView: UIView!
    
    @IBOutlet weak var tipLabel: UILabel!
    
    
    let kSpace = CGFloat(37*kSCREEN_SCALE)
    let kHeight = CGFloat(44*kSCREEN_SCALE)
    
    var selectProArr = [String]()
    var selectGreadeArr = [String]()

    var pickerView:UIPickerView!

    var educArr = [String]()
    var workTimeArr = [String]()
    var reasonArr = [String]()
    var teacherType = [String]()
    var academicArr = [String]()

    
    var worksCircle = [String]()
    var workDeadLine = [String]()
    

    var currentCount = 1

    var which = 0
    
    var selectStr = ""
    
    var totalNum = 0
    
    var selectBlock:((_ content:String,_ isCancel:Bool)->())?  //声明闭包

    
    override func awakeFromNib() {

        educArr = ["武汉市","黄石市","襄樊市","十堰市","荆州市","宜昌市","荆门市","鄂州市","孝感市","黄冈市","咸宁市","恩施市","仙桃市","潜江市","天门市","神农架林区"]
        workTimeArr = ["14:00-18:00","18:00-22:00"]
        reasonArr = ["字迹不清","图片模糊","上传错误"]
        teacherType = ["上课老师","助教老师"]
        academicArr = ["大专","本科","硕士","博士"]

        worksCircle = ["每天","每周一","每周二","每周三","每周四","每周五","每周六","每周日"]
        workDeadLine = ["12:00前","13:00前","14:00前","15:00前","16:00前","17:00前","18:00前","19:00前","20:00前"]
        _ = tagsView.subviews.map {
            $0.removeFromSuperview()
        }

    }
    
    func ShowTagsViewForProjects(title:String) {

        viewTitle.text =  title
        
        which = 0
        
        let tags = ["语文","数学","英语","物理","化学","历史","生物","地理","政治","科学"]
        let kWidth = (tagsView.frame.size.width-kSpace*3)/4
        
        let lines = 4
        for index in 0...tags.count - 1{
            let row =  CGFloat(index%lines)
            let tagBtn = UIButton.init(frame: CGRect(x:(kWidth + kSpace) * row, y:(kSpace+kHeight)*CGFloat(index/lines), width: kWidth, height: kHeight))
            tagBtn.tag = 10 + index
            tagBtn.titleLabel?.font = kFont24
            tagBtn.layer.cornerRadius = 22*kSCREEN_SCALE
            tagBtn.setTitleColor(kGaryColor(num: 117), for: .normal)
            tagBtn.setTitle(tags[index], for: .normal)
            tagBtn.layer.borderColor = kGaryColor(num: 185).cgColor
            tagBtn.layer.borderWidth = 1
            tagBtn.clipsToBounds = true
            tagBtn.addTarget(self, action: #selector(chooseProjects(sender:)), for: .touchUpInside)
            tagsView.addSubview(tagBtn)
        }
        
        let viewHeight = kHeight * 4 + kSpace * 3
        
        deBugPrint(item: viewHeight)
    }
    
    func ShowTagsViewForGrades(title:String,total:NSInteger) {
        
        totalNum = total
        
        if total == 1 {
            tipLabel.text = "最多选择一个"
        }else{
            tipLabel.text = "最多选择三个"
        }
        
        which = 1
        
        viewTitle.text =  title

        _ = tagsView.subviews.map {
            $0.removeFromSuperview()
        }
        let tags = ["一年级","二年级","三年级","四年级","五年级","六年级","七年级","八年级","九年级","高一","高二","高三","高中必修","高中选修"]

        let kWidth = (tagsView.frame.size.width-kSpace*3)/4

        let lines = 4
        for index in 0...tags.count - 1{
            let row =  CGFloat(index%lines)
            let tagBtn = UIButton.init(frame: CGRect(x:(kWidth + kSpace) * row, y:(kSpace+kHeight)*CGFloat(index/lines), width: kWidth, height: kHeight))
            tagBtn.tag = 50 + index
            tagBtn.titleLabel?.font = kFont24
            tagBtn.setTitleColor(kGaryColor(num: 117), for: .normal)
            tagBtn.layer.cornerRadius = 22*kSCREEN_SCALE
            tagBtn.setTitle(tags[index], for: .normal)
            tagBtn.layer.borderColor = kGaryColor(num: 185).cgColor
            tagBtn.layer.borderWidth = 1
            tagBtn.clipsToBounds = true
            tagBtn.addTarget(self, action: #selector(chooseGrades(sender:)), for: .touchUpInside)
            tagsView.addSubview(tagBtn)
        }
        
        let viewHeight = kHeight * 3 + kSpace * 2
        deBugPrint(item: viewHeight)
    }
    
    func ShowTagsViewForChooseEdu(title:String,index:NSInteger) {

        currentCount = index
        
        if index == 0 {
            which = 2
            viewTitle.text = "选择地区"
        }else if index == 1000{
            which = 4
            viewTitle.text = "退回理由"
        }else if index == 10001{
    
            which = 5
            viewTitle.text = "选择类型"
        }else if index == 10002{
            
            which = 6
            viewTitle.text = "选择学历"
        }else if index == 10003{
            
            which = 7
            viewTitle.text = "选择周期"
        }else if index == 10004{
            
            which = 8
            viewTitle.text = "选择截止时间"
        }
        else{
            which = 3
            viewTitle.text = "选择工作时间"
        }
        
        var height = 300 * kSCREEN_SCALE
        
        if index == 1 {
            height = 220 * kSCREEN_SCALE
        }
        
        //MARK:   时间选择器
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
        pickerView.frame = CGRect(x: 0, y: 0, width: tagsView.width, height: height)
        tagsView.addSubview(pickerView)

        tipLabel.isHidden = true
    }
    
    
    @objc func chooseProjects(sender:UIButton) {
        
        if selectProArr.contains((sender.titleLabel?.text)!) {
            
            selectProArr.remove(at: selectProArr.index(of: (sender.titleLabel?.text)!)!)
            sender.backgroundColor = UIColor.white
            sender.setTitleColor(kGaryColor(num: 117), for: .normal)
            sender.layer.borderColor = kGaryColor(num: 185).cgColor
            sender.layer.borderWidth = 1

        }else{
          
            if selectProArr.count<3 {
                selectProArr.append((sender.titleLabel?.text)!)
                sender.backgroundColor = kMainColor()
                sender.setTitleColor(kGaryColor(num: 255), for: .normal)
                sender.layer.borderColor = kGaryColor(num: 185).cgColor
                sender.layer.borderWidth = 0

            }else{
                setToast(str: "已经三个了")
            }
        }
    }
    
    
    @objc func chooseGrades(sender:UIButton) {
        
        if selectGreadeArr.contains((sender.titleLabel?.text)!) {
            
            selectGreadeArr.remove(at: selectGreadeArr.index(of: (sender.titleLabel?.text)!)!)
            sender.backgroundColor = UIColor.white
            sender.setTitleColor(kGaryColor(num: 117), for: .normal)
            sender.layer.borderColor = kGaryColor(num: 185).cgColor
            sender.layer.borderWidth = 1

        }else{
            
            if selectGreadeArr.count<totalNum {
                selectGreadeArr.append((sender.titleLabel?.text)!)
                sender.backgroundColor = kMainColor()
                sender.setTitleColor(kGaryColor(num: 255), for: .normal)
                sender.layer.borderColor = kGaryColor(num: 185).cgColor
                sender.layer.borderWidth = 0

            }else{
                
                if totalNum > 1 {
                    setToast(str: "已经三个了")
                }else{
                    setToast(str: "只能选择一个")
                }
                
            }
        }
        
    }
    
    
    //MARK:  ******代理 ：UIPickerViewDelegate,UIPickerViewDataSource
    //设置选择框的列数为3列,继承于UIPickerViewDataSource协议
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    //设置选择框的行数为9行，继承于UIPickerViewDataSource协议
    func pickerView(_ pickerView: UIPickerView,numberOfRowsInComponent component: Int) -> Int {
        
        if currentCount == 0 {
            return educArr.count
        }
        
        if currentCount == 1000 {
            return reasonArr.count
        }
        
        if currentCount == 10001 {
            return teacherType.count
        }
        
        if currentCount == 10002 {
            return academicArr.count
        }
        
        if currentCount == 10003 {
            return worksCircle.count
        }
        
        if currentCount == 10004 {
            return workDeadLine.count
        }

        return workTimeArr.count
    }
    
    //设置选择框各选项的内容，继承于UIPickerViewDelegate协议
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int,
                    forComponent component: Int) -> String? {
        
        if currentCount == 0 {
            return educArr[row]
        }
        
        if currentCount == 1000 {
            return reasonArr[row]
        }
        
        if currentCount == 10001 {
            return teacherType[row]
        }
        
        if currentCount == 10002 {
            return academicArr[row]
        }
        
        if currentCount == 10003 {
            return worksCircle[row]
        }
        
        if currentCount == 10004 {
            return workDeadLine[row]
        }

        return workTimeArr[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //将在滑动停止后触发，并打印出选中列和行索引
        
        if currentCount == 0 {
            selectStr = educArr[row]
        }else if currentCount == 1000 {
            selectStr = reasonArr[row]
        }else if currentCount == 10001 {
            if teacherType[row] == "上课老师" {
                selectStr = "1"
            }else{
                selectStr = "2"
            }
        }else if currentCount == 10002 {
            
            selectStr = academicArr[row]
        }else if currentCount == 10003 {
            
            selectStr = worksCircle[row]
        }else if currentCount == 10004 {
            
            selectStr = workDeadLine[row]
        }else{
            
            selectStr = workTimeArr[row]
        }
        
    }
    
    @IBAction func certainAction(_ sender: UIButton) {
        
        if selectBlock != nil {
            
            switch which {
            case 0:
                
                var str = ""
                for index in 0..<selectProArr.count {
                    var dian = ","
                    if index == selectProArr.count-1 {
                        dian = ""
                    }
                    str.append(selectProArr[index]+dian)
                }
                selectBlock!(str,false)

            case 1:
                
                var str = ""
                for index in 0..<selectGreadeArr.count {
                    var dian = ","
                    if index == selectGreadeArr.count-1 {
                        dian = ""
                    }
                    str.append(selectGreadeArr[index]+dian)
                }
                
                selectBlock!(str,false)
            case 2:
                if selectStr == ""{
                    selectStr = "武汉市"
                }
                selectBlock!(selectStr,false)
            case 3:
                if selectStr == ""{
                    selectStr = "14:00-18:00"
                }
                selectBlock!(selectStr,false)
            case 4:
                
                if selectStr == "" {
                    selectStr = "字迹不清"
                }
                selectBlock!(selectStr,false)
                
            case 5:
                
                if selectStr == "" {
                    selectStr = "1"
                }
                
                selectBlock!(selectStr,false)
            case 6:
                
                if selectStr == "" {
                    selectStr = "大专"
                }
                
                selectBlock!(selectStr,false)
            case 7:
                
                if selectStr == "" {
                    selectStr = "每天"
                }
                
                selectBlock!(selectStr,false)
            case 8:
                
                if selectStr == "" {
                    selectStr = "18:00前"
                }
                
                selectBlock!(selectStr,false)

            default:
                break
            }
            
        }
        
    }
    
    
    @IBAction func cancelAction(_ sender: UIButton) {
        
        if selectBlock != nil {
            selectBlock!("",true)
        }
        
    }    
    
}
