//
//  AppDelegate.swift
//  startvhelper
//
//  Created by 张晓珊 on 15/11/9.
//  Copyright © 2015年 张晓珊. All rights reserved.
//

import Foundation

extension NSDate {
    
    class func currentTimeString() -> String {
        let date = NSDate()
        let df = NSDateFormatter()
        df.locale = NSLocale(localeIdentifier: "en")
        df.dateFormat = "yyyyMMddHHmmss"
        let str = df.stringFromDate(date)
        return str
    }
    
    /// 距离6天前过去了多少天
    ///
    /// - parameter time: 从1970年到某个时间点过去的秒数（s）
    ///
    /// - returns: 给定时间相对于6天前过去了多少天
    class func differenceToSixDaysAgo(time: NSTimeInterval) -> NSInteger {
        let date = NSDate()
        
        let df = NSDateFormatter()
        df.locale = NSLocale(localeIdentifier: "en")
        df.dateFormat = "yyyy-MM-dd"
        let str = df.stringFromDate(date)
        let zone = df.dateFromString(str)
        let zoneTime: NSTimeInterval = zone!.timeIntervalSince1970 - (6 * 24 * 60 * 60)

        return NSInteger((time - zoneTime) / (24 * 60 * 60))
    }
    
    class func timeToDateWith(time: NSTimeInterval) -> String {
        let date = NSDate(timeIntervalSince1970: time)
        let df = NSDateFormatter()
        df.locale = NSLocale(localeIdentifier: "en")
        df.dateFormat = "HH:mm"
        return df.stringFromDate(date)
    }
    
    class func timeToDetailDateWith(time: NSTimeInterval) -> String {
        let date = NSDate(timeIntervalSince1970: time)
        let df = NSDateFormatter()
        df.locale = NSLocale(localeIdentifier: "en")
        df.dateFormat = ("yyyy-MM-dd HH:mm:ss")
        return df.stringFromDate(date)
    }
    
    class func stringMMddWith(date: NSDate) -> String {
        let df = NSDateFormatter()
        df.locale = NSLocale(localeIdentifier: "en")
        df.dateFormat = "MM-dd"
        return df.stringFromDate(date)
    }
    
    /// 将新浪的日期字符串转换成日期
    class func sinaDate(string: String) -> NSDate? {
        
        // 转换成日期
        let df = NSDateFormatter()
        // 提示：地区一定要指定，否则真机运行会有问题，统一用 en 即可
        df.locale = NSLocale(localeIdentifier: "en")
        
        // 日期格式字符串
        df.dateFormat = "EEE MMM dd HH:mm:ss zzz yyyy"
        // 转换成日期
        return df.dateFromString(string)
    }
    
    /**
        刚刚(一分钟内)
        X分钟前(一小时内)
        X小时前(当天)
        昨天 HH:mm(昨天)
        MM-dd HH:mm(一年内)
        yyyy-MM-dd HH:mm(更早期)
    */
    var dateDesctiption: String {
        
        // 日历类，提供了非常丰富的日期转换函数
        // 1. 取出当前的日期
        let cal = NSCalendar.currentCalendar()
        
        // 2. 判断是否是今天
        if cal.isDateInToday(self) {
            // 使用日期和当前的系统时间进行比较，判断相差的秒数
            let delta = Int(NSDate().timeIntervalSinceDate(self))
            
            if delta < 60 {
                return "刚刚"
            }
            if delta < 3600 {
                return "\(delta / 60) 分钟前"
            }
            return "\(delta / 3600) 小时前"
        }
        
        /// 日期格式字符串
        var fmtString = " HH:mm"
        // 3. 判断是否是昨天
        if cal.isDateInYesterday(self) {
            fmtString = "昨天" + fmtString
        } else {
            
            fmtString = "MM-dd" + fmtString
            // 4. 判断年度
            // 单纯获取年数
            // print(cal.components(NSCalendarUnit.Year, fromDate: self))
            // 比较函数，能够比较一个完整的自然年
            let coms = cal.components(NSCalendarUnit.Year, fromDate: self, toDate: NSDate(), options: NSCalendarOptions(rawValue: 0))

            if coms.year > 0 {
                fmtString = "yyyy-" + fmtString
            }
        }
        
        let df = NSDateFormatter()
        df.locale = NSLocale(localeIdentifier: "en")
        df.dateFormat = fmtString
        
        return df.stringFromDate(self)
    }
}