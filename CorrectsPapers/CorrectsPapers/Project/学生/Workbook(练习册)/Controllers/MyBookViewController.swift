//
//  MyBookViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/13.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit

class MyBookViewController: BaseViewController{
    var emptyView = UIView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configSubViews() {
        
        self.navigationItem.title = "我的练习册"
        
        mainTableArr =  ["最近天气真的好热呀，出门就像","Swift 中随机数的使用总结在我们开发的过程中，时不时地需要产生一些随机数。这里我们总结一下Swift中常用的一些随机数生成函数。这里我们将在Playground中来做些示例演示。","在我们开发的过程中，时不时地需要产生一些随机数。这里我们总结一下Swift中常用的一些随机数生成函数。这里我们将在Playground中来做些示例演示。整型随机数","在大部分应用中，上","这个函数使用ARC4加密的随机数来填充该函数第二个参数指定的长度的缓存区域。因此，如果我们传入的是sizeof(UInt64)，该函数便会生成一个随机数来填充8个字节的区域，并返回给r。那么64位的随机数生成方法便可以如下实现：","其实如果翻看一下Swift中关于C函数的API，发现还有许多跟随机数相关的函数，如arc4random_addrandom，erand48等。上面的只是我们经常用到的一些函数，这几个函数基本上够用了。当然，不同场景有不同的需求，我们需要根据实际的需求来选择合适的函数。","在Swift中使用随机数 在我们的开发过程中,有时需要产生一些随机数.而Swift中并没有像JAVA中一样提供一个专门的Random类来集中的生成随机数. 在Swift中,提供了几个全局的函数来生...","大叔：这是因为我们国家经济宏观调控，第四代领导核心英明神武（没错他原词说的就是英明神武），房地产市场连带其他市场欣欣向荣，世界经济崩溃，唯独中国形势一片大好。。。。（五分钟新闻联播，还是番外版）","大三宿舍卫生不搞，把垃圾放在门口害我们整个宿舍被通报取消评奖评优资格。有时候门禁过了还不回宿舍，发消息问她回不回来永远是没有回复，回宿舍以后打开手电筒照醒我们所有人。夏天实在闷热睡不着觉，也因为她不能开窗透气，只要他发现，第二天肯定会说自己感冒头疼，","一个好朋友吃饭她也要来，来就来咯"]
        
        mainTableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: kSCREEN_HEIGHT - 64 ), style: .plain)
        mainTableView.dataSource = self;
        mainTableView.delegate = self;
        mainTableView.estimatedRowHeight = 143 * kSCREEN_SCALE;
        mainTableView.register(UINib(nibName: "MyBookCell", bundle: nil), forCellReuseIdentifier: identyfierTable)
        mainTableView.tableFooterView = UIView.init()
        self.view.addSubview(mainTableView)
        
    }
    
    
    //    当数据为空的时候，显示提示
    
    func addImageWhenEmpty() {
        
        func addImageWhenEmpty() {
            emptyView = UIView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: kSCREEN_HEIGHT - 46))
            emptyView.backgroundColor = kBGColor()
            let imageView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: 200 * kSCREEN_SCALE, height: 200 * kSCREEN_SCALE))
            imageView.image = #imageLiteral(resourceName: "404_icon_default")
            imageView.center = CGPoint(x: emptyView.centerX, y: emptyView.centerY - 200 * kSCREEN_SCALE)
            emptyView.addSubview(imageView)
            
            let label = UILabel.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 18))
            label.textAlignment = .center
            label.textColor = kGaryColor(num: 163)
            label.center = CGPoint(x: emptyView.centerX, y: emptyView.centerY-40)
            label.font = kFont34
            label.numberOfLines = 2
            label.text = "暂时没有练习册"
            emptyView.addSubview(label)
                        
            self.mainTableView.addSubview(emptyView)
            
        }    }
    
    
    //MARK:  ******代理 ：UITableViewDataSource,UITableViewDelegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if mainTableArr.count == 0 {
            addImageWhenEmpty()
        }else{
            emptyView.removeFromSuperview()
        }
        
        return mainTableArr.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : MyBookCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable, for: indexPath) as! MyBookCell
        cell.selectionStyle = .default
        cell.MyBookCellSetValue(index: indexPath.row)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            mainTableArr.removeObject(at: indexPath.row)
            tableView.reloadData()
            print("删除了---\(indexPath.section)分区-\(indexPath.row)行")
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        
        return "删除此作业"
    }
}

