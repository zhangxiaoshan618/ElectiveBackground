//
//  AppDelegate.swift
//  startvhelper
//
//  Created by 张晓珊 on 15/11/9.
//  Copyright © 2015年 张晓珊. All rights reserved.
//

import Foundation

extension String {
    
    /// 提起字符串中的 href 链接内容
    /// 元组，能够保证一次返回多个值
    func hrefLink() -> (link: String?, text: String?) {
        let pattern = "<a href=\"(.*?)\".*?>(.*?)</a>"
        let regex = try! NSRegularExpression(pattern: pattern, options: NSRegularExpressionOptions.DotMatchesLineSeparators)
        
        // 开始匹配
        if let result = regex.firstMatchInString(self, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count)) {
            
            let r1 = result.rangeAtIndex(1)
            let r2 = result.rangeAtIndex(2)
            
            let link = (self as NSString).substringWithRange(r1)
            let text = (self as NSString).substringWithRange(r2)
            
            return (link, text)
        }
        
        return (nil, nil)
    }
}
