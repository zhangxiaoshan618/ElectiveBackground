//
//  UITextField+Extension.swift
//  startvhelper
//
//  Created by 张晓珊 on 16/2/25.
//  Copyright © 2016年 张晓珊. All rights reserved.
//

import Foundation

extension UITextField {
    
    convenience init(placeholder: String, textAlignment: NSTextAlignment = NSTextAlignment.Center, fontSize: CGFloat = 14) {
        self.init()
        self.backgroundColor = UIColor.whiteColor()
        self.font = UIFont.systemFontOfSize(fontSize)
        self.placeholder = placeholder
        self.borderStyle = UITextBorderStyle.RoundedRect
        self.textAlignment = textAlignment
    }
}


