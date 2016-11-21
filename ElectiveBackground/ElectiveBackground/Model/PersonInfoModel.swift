//
//  PersonInfoModel.swift
//  二维码使用
//
//  Created by 张晓珊 on 16/11/12.
//  Copyright © 2016年 张晓珊. All rights reserved.
//

import UIKit

class PersonInfoModel: NSObject {
    var name: String?
    
    var phone: String?
    
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forKey key: String) {
        
        if key == "person" {
            name = value as? String
        }
        
        super.setValue(value, forKey: key)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
    }
    
    override var description: String {
        // Tip:在swift中，如果属性为基本数据类型，并且没有默认初始值，如果keys中有该属性，则会报错,且KVC不会对其进行赋值。
        let keys = ["name", "phone"]
        return super.description + dictionaryWithValuesForKeys(keys).description
    }

    
}
