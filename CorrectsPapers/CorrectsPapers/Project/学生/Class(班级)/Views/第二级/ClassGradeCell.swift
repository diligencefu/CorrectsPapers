//
//  ClassGradeCell.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/6.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class ClassGradeCell: UITableViewCell {

    
    @IBOutlet weak var periodsLabel: UILabel!
    
    @IBOutlet weak var fristGrade: UIImageView!
    @IBOutlet weak var doneGrade: UIImageView!
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        fristGrade.contentMode = .center
        doneGrade.contentMode = .center

        // Initialization code
    }

    
    func is1thCell() {
        fristGrade.alpha = 0
        doneGrade.alpha = 0
        
        label1.isHidden = false
        label2.isHidden = false
        periodsLabel.text = "课时"
    }
    
//    班级详情
    func  setValueForClassGradeCell(index:NSInteger) {
        
        label1.isHidden = true
        label2.isHidden = true
        fristGrade.alpha = 1
        doneGrade.alpha = 1

        periodsLabel.text = "\(index)课时"
        
    }
    
    
    func is1thCellForWorkBook() {
        fristGrade.alpha = 0
        doneGrade.alpha = 0
        
        label1.isHidden = false
        label2.isHidden = false
        periodsLabel.text = "学生姓名"
    }
    
    
    func is1thCellForNonWorkBook() {
        fristGrade.alpha = 0
        doneGrade.alpha = 0
        
        label1.isHidden = false
        label2.isHidden = false
        periodsLabel.text = "日期"
    }
    
    func noDatas() {
        fristGrade.alpha = 0
        doneGrade.alpha = 0
        
        label1.isHidden = false
        label2.isHidden = false
        periodsLabel.text = ""
        label2.text = ""
        label1.text = "暂无成绩"

    }
    
    ///    非练习册详情（学生）
    func  setValueForNonBookGrade(model:NotWorkDetailModel) {
        
        label1.isHidden = true
        label2.isHidden = true
        fristGrade.alpha = 1
        doneGrade.alpha = 1
        
        periodsLabel.text = model.create_date.substring(to: String.Index.init(encodedOffset: 10))
        
        if model.pre_score == "1" {
            fristGrade.image = #imageLiteral(resourceName: "yixing_icon_pressed")
        }else if model.pre_score == "2" {
            fristGrade.image = #imageLiteral(resourceName: "erxing_icon_pressed")
        }else if model.pre_score == "3" {
            fristGrade.image = #imageLiteral(resourceName: "sanxing_icon_pressed")
        }else if model.pre_score == "4" {
            fristGrade.image = #imageLiteral(resourceName: "sixing_icon_pressed")
        }else if model.pre_score == "5" {
            fristGrade.image = #imageLiteral(resourceName: "wuxing_icon_pressed")
            doneGrade.image = #imageLiteral(resourceName: "not_icon_default")
        }
        
        if model.pre_score != "5" {
            if model.upd_score == "1" {
                doneGrade.image = #imageLiteral(resourceName: "yixing_icon_pressed")
            }else if model.upd_score == "2" {
                doneGrade.image = #imageLiteral(resourceName: "erxing_icon_pressed")
            }else if model.upd_score == "3" {
                doneGrade.image = #imageLiteral(resourceName: "sanxing_icon_pressed")
            }else if model.upd_score == "4" {
                doneGrade.image = #imageLiteral(resourceName: "sixing_icon_pressed")
            }else if model.upd_score == "5" {
                doneGrade.image = #imageLiteral(resourceName: "wuxing_icon_pressed")
            }
        }
        
    }
    ///    非练习册详情（老师）
    func  setValueForNonBookGradeTeacher(model:TShowGradeModel) {
        
        label1.isHidden = true
        label2.isHidden = true
        fristGrade.alpha = 1
        doneGrade.alpha = 1
        
        periodsLabel.text = model.user_name
        
        if model.pre_score == "1" {
            fristGrade.image = #imageLiteral(resourceName: "yixing_icon_pressed")
        }else if model.pre_score == "2" {
            fristGrade.image = #imageLiteral(resourceName: "erxing_icon_pressed")
        }else if model.pre_score == "3" {
            fristGrade.image = #imageLiteral(resourceName: "sanxing_icon_pressed")
        }else if model.pre_score == "4" {
            fristGrade.image = #imageLiteral(resourceName: "sixing_icon_pressed")
        }else if model.pre_score == "5" {
            fristGrade.image = #imageLiteral(resourceName: "wuxing_icon_pressed")
            doneGrade.image = #imageLiteral(resourceName: "not_icon_default")
        }
        
        if model.pre_score != "5" {
            if model.upd_score == "1" {
                doneGrade.image = #imageLiteral(resourceName: "yixing_icon_pressed")
            }else if model.upd_score == "2" {
                doneGrade.image = #imageLiteral(resourceName: "erxing_icon_pressed")
            }else if model.upd_score == "3" {
                doneGrade.image = #imageLiteral(resourceName: "sanxing_icon_pressed")
            }else if model.upd_score == "4" {
                doneGrade.image = #imageLiteral(resourceName: "sixing_icon_pressed")
            }else if model.upd_score == "5" {
                doneGrade.image = #imageLiteral(resourceName: "wuxing_icon_pressed")
            }
        }
        
    }

        
//    练习册详情
    func  setValueForBookGrade(model:TShowGradeModel) {
        
        label1.isHidden = true
        label2.isHidden = true
        fristGrade.alpha = 1
        doneGrade.alpha = 1

        periodsLabel.text = model.user_name
        
        if model.scores == "1" {
            fristGrade.image = #imageLiteral(resourceName: "yixing_icon_pressed")
        }else if model.scores == "2" {
            fristGrade.image = #imageLiteral(resourceName: "erxing_icon_pressed")
        }else if model.scores == "3" {
            fristGrade.image = #imageLiteral(resourceName: "sanxing_icon_pressed")
        }else if model.scores == "4" {
            fristGrade.image = #imageLiteral(resourceName: "sixing_icon_pressed")
        }else if model.scores == "5" {
            fristGrade.image = #imageLiteral(resourceName: "wuxing_icon_pressed")
            doneGrade.image = #imageLiteral(resourceName: "not_icon_default")
        }

        if model.scores_next == "1" {
            doneGrade.image = #imageLiteral(resourceName: "yixing_icon_pressed")
        }else if model.scores_next == "2" {
            doneGrade.image = #imageLiteral(resourceName: "erxing_icon_pressed")
        }else if model.scores_next == "3" {
            doneGrade.image = #imageLiteral(resourceName: "sanxing_icon_pressed")
        }else if model.scores_next == "4" {
            doneGrade.image = #imageLiteral(resourceName: "sixing_icon_pressed")
        }else if model.scores_next == "5" {
            doneGrade.image = #imageLiteral(resourceName: "wuxing_icon_pressed")
        }
    }
        
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
