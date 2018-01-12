//
//  UIView+Frame.swift
//  CLKuGou_Swift
//
//  Created by Darren on 16/8/6.
//  Copyright © 2016年 darren. All rights reserved.
//
import UIKit

extension UIView {
    
    /// 裁剪 view 的圆角
    func clipRectCorner(_ direction: UIRectCorner, cornerRadius: CGFloat) {
        let cornerSize = CGSize(width: cornerRadius, height: cornerRadius)
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: direction, cornerRadii: cornerSize)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        layer.addSublayer(maskLayer)
        layer.mask = maskLayer
    }
    
   /// 设置view圆角
    func CLViewsBorder(view:UIView, borderWidth:CGFloat, borderColor:UIColor,cornerRadius:CGFloat){
        view.layer.borderWidth = 1;
        view.layer.borderColor = borderColor.cgColor
        view.layer.cornerRadius = cornerRadius
        view.layer.masksToBounds = true
    }
    
  
    
}
