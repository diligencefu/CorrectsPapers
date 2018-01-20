//
//  ShowFileCell.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/11/10.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class ShowFileCell: UITableViewCell {
    
    var url = ""
    
    var mainModel = UrlModel()
    
    
    @IBOutlet weak var fileTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setValues(model:UrlModel) {
        
        mainModel = model
        url = model.answard_res
        fileTitle.text = model.title
        
    }
    
    @IBAction func viewTheFile(_ sender: UIButton) {
        let webView = WebViewController()
//        webView.webUrl = mainModel.answard_res.substring(from: mainModel.answard_res.index(mainModel.answard_res.startIndex, offsetBy: 27))
        webView.webUrl = mainModel.answard_res
        webView.theTitle = mainModel.title
        viewController()?.navigationController?.pushViewController(webView, animated: true)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
