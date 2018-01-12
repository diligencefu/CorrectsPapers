//
//  ChooseCityView.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/12/16.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class ChooseCityView: UIView ,UIPickerViewDelegate,UIPickerViewDataSource{

    @IBOutlet weak var cityPicker: UIPickerView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var provinces = NSMutableArray()
    var citys = NSMutableArray()
    var districts = NSMutableArray()

    var provinceStr = "北京"
    var cityStr = "北京市"
    var districtStr = "东城区"

    var selectBlock:((_ content:String,_ isCancel:Bool)->())?  //声明闭包
    
    override func awakeFromNib() {
        
        cityPicker.delegate = self
        cityPicker.dataSource = self
//        cityPicker
        
        
        let addressDic = NSDictionary.init(contentsOfFile: Bundle.main.path(forResource: "address", ofType: "plist")!)
        
        provinces = addressDic?.object(forKey: "address") as! NSMutableArray
        
        let cityDic = provinces.object(at: 0) as! NSDictionary
        citys = cityDic.object(forKey: "sub") as! NSMutableArray
        
        let districtDic = citys.object(at: 0) as! NSDictionary
        districts = districtDic.object(forKey: "sub") as! NSMutableArray

        deBugPrint(item: addressDic!)
    }
    
    //    #MARK: - 选择器的数据源代理

    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return kSCREEN_WIDTH/3
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if component == 0 {
            return provinces.count
        }else if component == 1 {
            return citys.count
        }else{
            return districts.count
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            let cityDic = provinces.object(at: row) as! NSDictionary
            return cityDic.object(forKey: "name") as? String
        }else if component == 1 {
            let cityDic = citys.object(at: row) as! NSDictionary
            return cityDic.object(forKey: "name") as? String
        }else{
            return districts[row] as? String
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            let mainDic = provinces.object(at: row) as! NSDictionary
            citys = mainDic.object(forKey: "sub") as! NSMutableArray
            
            if citys.count > 0{
                let cityDic = citys.object(at: 0) as! NSDictionary
                districts = cityDic.object(forKey: "sub") as! NSMutableArray
            }else{
                districts = citys
            }
            
            let proDic = provinces.object(at: row) as! NSDictionary
            provinceStr = proDic.object(forKey: "name") as! String
            let cityDic = citys.object(at: 0) as! NSDictionary
            cityStr = cityDic.object(forKey: "name") as! String
            districtStr = districts.object(at: 0) as! String
            
            cityPicker.selectRow(0, inComponent: 1, animated: true)
            cityPicker.selectRow(0, inComponent: 2, animated: true)

            cityPicker.reloadComponent(1)
            cityPicker.reloadComponent(2)
        }else if component == 1 {
            
            if citys.count > 0{
                let cityDic = citys.object(at: row) as! NSDictionary
                districts = cityDic.object(forKey: "sub") as! NSMutableArray
            }
            
            let cityDic = citys.object(at: row) as! NSDictionary
            cityStr = cityDic.object(forKey: "name") as! String
            districtStr = districts.object(at: 0) as! String

            cityPicker.selectRow(0, inComponent: 2, animated: true)
            cityPicker.reloadComponent(2)

        }else{
            districtStr = districts.object(at: row) as! String
        }
        
    }
    
    @IBAction func certainAction(_ sender: UIButton) {
        
        deBugPrint(item: provinceStr+" "+cityStr+" "+districtStr)
        
        if selectBlock != nil {
            selectBlock!(provinceStr+" "+cityStr+" "+districtStr,true)
        }
        
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        
        if selectBlock != nil {
            selectBlock!("",false)
        }
    }
    
}
