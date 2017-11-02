
//
//  CreateBookCell.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/14.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class CreateBookCell: UITableViewCell {

    @IBOutlet weak var bookTitle: UILabel!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var bookSubTitle: UILabel!
    
    @IBOutlet weak var tagsView: UIView!
    
    @IBOutlet weak var tipMark: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tipMark.layer.cornerRadius = 9
        tipMark.clipsToBounds = true
    }
    
    func showForCreateBook(isShow:Bool,title:String,subTitle:String) {
        tipMark.isHidden = true
        bookTitle.text = title
        bookSubTitle.text = subTitle
        if isShow {
            bookSubTitle.isHidden = true
        }else{
            titleTextField.isHidden = true
        }
        tagsView.isHidden = true
    }
    
    
    func showForRegist(isShow:Bool,title:String,subTitle:String) {
        tipMark.isHidden = true
        bookTitle.text = title
        if isShow {
            bookSubTitle.isHidden = true
            titleTextField.placeholder = subTitle
        }else{
            titleTextField.isHidden = true
            bookSubTitle.text = subTitle
        }
        tagsView.isHidden = true
    }    
    
    
    func showForMessages(count:String,titleStr:String) {
        
        if count == "" || count == "0" {
            tipMark.isHidden = true
        }else{
            tipMark.isHidden = false
        }
        
        tipMark.snp.updateConstraints({ (ls) in
            ls.width.equalTo(getLabWidthForTip(labelStr: count, font: UIFont.systemFont(ofSize: 14), height: 18))
        })
        bookTitle.text = titleStr
        tipMark.text = count
        
        bookSubTitle.isHidden = true
        tagsView.isHidden = false
        titleTextField.isHidden = true

    }
    
    
    func showForCreate(isShow:Bool,title:String,subTitle:String) {
        tipMark.isHidden = true
        bookTitle.text = title
        bookSubTitle.text = subTitle
        tagsView.isHidden = true
        if isShow {
            bookSubTitle.textColor = kGaryColor(num: 149)
            titleTextField.placeholder = "请输入金额"
            titleTextField.keyboardType = .numberPad
            bookSubTitle.text = "学币"
            bookSubTitle.isHidden = false
            titleTextField.isHidden = false
        }else{
            titleTextField.isHidden = true
            bookSubTitle.textColor = kSetRGBColor(r: 0, g: 175, b: 255)
        }
    }
    
    
    //获取字符串的宽度的封装
    func getLabWidthForTip(labelStr:String,font:UIFont,height:CGFloat) -> CGFloat {
        let statusLabelText: NSString = labelStr as NSString
        let size = CGSize(width: 900, height: height)
        let dic = NSDictionary(object: font, forKey: NSAttributedStringKey.font as NSCopying)
        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [NSAttributedStringKey : Any], context:nil).size
        return strSize.width+12
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
