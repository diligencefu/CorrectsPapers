//
//  ShowFridensCell.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/17.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class ShowFridensCell: UITableViewCell {
    
    @IBOutlet weak var userIcon: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var userId: UILabel!
    
    @IBOutlet weak var addBtn: UIButton!
    
    
    @IBOutlet weak var selectMark: UIImageView!
    
    
    var addFriendsBlock:((String)->())?  //声明闭包
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userIcon.layer.cornerRadius = 5
        userIcon.clipsToBounds = true
        
        addBtn.layer.cornerRadius = 5
        addBtn.clipsToBounds = true
        addBtn.setBackgroundImage(getNavigationIMG(27, fromColor: kSetRGBColor(r: 0, g: 200, b: 255), toColor: kSetRGBColor(r: 0, g: 162, b: 255)), for: .normal)
        
        selectMark.layer.cornerRadius = selectMark.width/2
        selectMark.clipsToBounds = true
        selectMark.layer.borderColor = kGaryColor(num: 221).cgColor
        selectMark.layer.borderWidth = 1
    }
    
    
    
    func ShowFridensCellForChooseMembers(model:ApplyModel,isSelected:Bool) {
        addBtn.isHidden = true
        selectMark.isHidden = false
        
        if isSelected {
            selectMark.image = #imageLiteral(resourceName: "photo_sel_photoPicker")
        }else{
            selectMark.image = nil
        }
        
        userIcon.kf.setImage(with:  URL(string:model.user_photo), placeholder: #imageLiteral(resourceName: "UserHead_64_default"), options: nil, progressBlock: nil, completionHandler: nil)
        userId.text = model.user_num
        userName.text = model.user_name
        
        if model.user_type == "2" {
            userId.text = "学号"+model.user_num
        }else{
            userId.text = "工号"+model.user_num
        }

    }
    
    
    func ShowFridensCellForShowFriend(model:ApplyModel) {
        
        addBtn.isHidden = true
        selectMark.isHidden = true
        userIcon.kf.setImage(with:  URL(string:model.user_photo), placeholder: #imageLiteral(resourceName: "UserHead_64_default"), options: nil, progressBlock: nil, completionHandler: nil)
        
        if model.user_type == "1" {
            userId.text = "学号"+model.user_num
        }else{
            userId.text = "工号"+model.user_num
        }
        userName.text = model.user_name
    }
    
    
    
    
    func ShowFridensCellForCreateClass(model:ApplyModel) {
        
        addBtn.isHidden = true
        selectMark.isHidden = true
        userIcon.kf.setImage(with:  URL(string:model.user_photo), placeholder: #imageLiteral(resourceName: "UserHead_64_default"), options: nil, progressBlock: nil, completionHandler: nil)
        userId.text = model.user_num
        userName.text = model.user_name
    }

    
    
    func ShowFridensCellForAddFriend(model:FriendsModel) {
        
        selectMark.isHidden = true
        
        userIcon.kf.setImage(with:  URL(string:model.user_photo), placeholder: #imageLiteral(resourceName: "UserHead_64_default"), options: nil, progressBlock: nil, completionHandler: nil)
        
        if model.user_type == "1" {
            userId.text = "学号" + model.user_num
        }else{
            userId.text = "工号" + model.user_num
        }
        
        userName.text = model.user_name
        
        if model.isSent! {
            addBtn.isEnabled = false
            addBtn.setBackgroundImage(getNavigationIMG(27, fromColor: kGaryColor(num: 117), toColor: kGaryColor(num: 117)), for: .normal)
            addBtn.setTitle("已发送请求", for: .normal)
        }
    }
    
    
    @IBAction func addFriendAction(_ sender: UIButton) {
        
        if addFriendsBlock != nil {
            addFriendsBlock!("")
        }
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

