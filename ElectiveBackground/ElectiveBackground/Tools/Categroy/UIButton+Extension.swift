//
//  AppDelegate.swift
//  startvhelper
//
//  Created by 张晓珊 on 15/11/9.
//  Copyright © 2015年 张晓珊. All rights reserved.
//

import UIKit

extension UIButton {
    
    convenience init(title: String, fontSize: CGFloat = 14, color: UIColor = UIColor.darkGrayColor(), selectedColor: UIColor = UIColor.orangeColor(), backColor: UIColor = UIColor.whiteColor()) {
        
        self.init()
        
        setTitle(title, forState: UIControlState.Normal)
        setTitleColor(color, forState: UIControlState.Normal)
        setTitleColor(selectedColor, forState: UIControlState.Selected)
        backgroundColor = backColor
        
        
        titleLabel?.font = UIFont.systemFontOfSize(fontSize)
        sizeToFit()
    }
    
    convenience init(title: String, imageName: String, fontSize: CGFloat = 14, color: UIColor = UIColor.darkGrayColor(), alignmentType: NSTextAlignment = NSTextAlignment.Left) {
        
        self.init()
        
        setTitle(title, forState: UIControlState.Normal)
        setImage(UIImage(named: imageName), forState: UIControlState.Normal)
        setTitleColor(color, forState: UIControlState.Normal)
        titleLabel?.font = UIFont.systemFontOfSize(fontSize)
        titleLabel?.textAlignment = alignmentType
        sizeToFit()
    }
    
    convenience init(imageName: String) {
        self.init()
        
        setImage(imageName)
        sizeToFit()
    }
    
    /// 使用图像名设置按钮图像
    func setImage(imageName: String) {
        setImage(UIImage(named: imageName), forState: UIControlState.Normal)
        // 提示：如果高亮图片不存在，不会设置
        setImage(UIImage(named: imageName + "_highlighted"), forState: UIControlState.Highlighted)
        sizeToFit()
    }
}
