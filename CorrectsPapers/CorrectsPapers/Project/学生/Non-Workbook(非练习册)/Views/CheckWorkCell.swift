//
//  CheckWorkCell.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/16.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift


class CheckWorkCell: UITableViewCell {

    @IBOutlet weak var no_check: UILabel!
    
    @IBOutlet weak var complain: UIButton!
    @IBOutlet weak var resubmit: UIButton!
    
    
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var scoreImage: UIImageView!
    
    
    @IBOutlet weak var correctTime: UILabel!
    
    @IBOutlet weak var workDescrip: UILabel!
    
    
    @IBOutlet weak var workImage1: UIButton!
    @IBOutlet weak var workImage2: UIButton!
    
    @IBOutlet weak var teachermark: UILabel!
    
    @IBOutlet weak var remark: UITextView!
    
    
    @IBOutlet weak var label1: UILabel!
    
    
    @IBOutlet weak var doneMark: UILabel!
    
    var complainAction:(()->())?  //声明闭包

    
    override func awakeFromNib() {
        super.awakeFromNib()

        complain.layer.cornerRadius = 5
        complain.clipsToBounds = true
        complain.layer.borderColor = kMainColor().cgColor
        complain.layer.borderWidth = 1
        
        resubmit.layer.cornerRadius = 5
        resubmit.clipsToBounds = true

        
        
        resubmit.setBackgroundImage(getNavigationIMG(64, fromColor: kSetRGBColor(r: 0, g: 200, b: 255), toColor: kSetRGBColor(r: 0, g: 160, b: 255)), for: .normal)
        
    }
    
//    未批改
    func checkWorkCellSetValues1() {
        label1.isHidden = true
        teachermark.isHidden = true
        remark.isHidden = true
        doneMark.isHidden = true
        score.isHidden = true
        scoreImage.isHidden = true
        workImage1.snp.updateConstraints { (make) in
            make.bottom.equalToSuperview().offset(-6.5)
        }
        
        resubmit.isHidden = true
        complain.isHidden = true

    }
    
//    退回
    func checkWorkCellSetValues2() {
        label1.isHidden = true
        teachermark.isHidden = true
        remark.isHidden = true
        doneMark.isHidden = true
        score.isHidden = true
        scoreImage.isHidden = true
        
        no_check.text = "退回-照片模糊"
        no_check.textColor = kSetRGBColor(r: 255, g: 78, b: 78)
        
        workImage1.snp.updateConstraints { (make) in
            make.bottom.equalToSuperview().offset(-6.5)
        }
    }

//    批改，等待改正
    func checkWorkCellSetValues3() {
        remark.text = "状态3：已批改后显示等待更正错题如果成绩为满分则不出现更正错题页面等待更等待更等待更等待更等待更等待更等待更等待更等待更"
        resubmit.snp.updateConstraints { (make) in
            make.width.equalTo(0)
        }
        no_check.snp.updateConstraints { (make) in
            make.width.equalTo(0)
        }

        no_check.isHidden = true
        resubmit.isHidden = true
        doneMark.isHidden = true
    }

//    都完成
    func checkWorkCellSetValues4() {
        remark.text = "状态3：已批改后显示等待更正错题如果成绩为满分则不出现更正错题页面等待更等待更等待更等待更等待更等待更等待更等待更等待更"
        complain.isHidden = true
        resubmit.isHidden = true
        no_check.snp.updateConstraints { (make) in
            make.width.equalTo(0)
        }

    }
    
    
    
    @IBAction func complainAction(_ sender: UIButton) {
        
        if complainAction != nil {
            complainAction!()
        }
        
        let complainVC = ComplaintViewController()
        
        viewController()?.navigationController?.pushViewController(complainVC, animated: true)
        
    }
    
    @IBAction func resubmitAction(_ sender: UIButton) {        
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
