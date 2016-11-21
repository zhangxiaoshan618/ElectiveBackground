//
//  AppDelegate.swift
//  startvhelper
//
//  Created by 张晓珊 on 15/11/9.
//  Copyright © 2015年 张晓珊. All rights reserved.
//

import UIKit

// 扩展中，只能提供便利的构造函数
extension UILabel {
    
    convenience init(color: UIColor, fontSize: CGFloat) {
        self.init()
        
        textColor = color
        font = UIFont.systemFontOfSize(fontSize)
        sizeToFit()
    }
    
    convenience init(string: String, color: UIColor = UIColor.darkGrayColor(), fontSize: CGFloat, alignmentType: NSTextAlignment = NSTextAlignment.Left) {
        self.init()
        
        text = string
        textColor = color
        font = UIFont.systemFontOfSize(fontSize)
        textAlignment = alignmentType
        sizeToFit()
    }
}
