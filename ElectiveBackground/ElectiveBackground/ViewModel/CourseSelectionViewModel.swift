//
//  CourseSelectionViewModel.swift
//  二维码使用
//
//  Created by 张晓珊 on 16/11/14.
//  Copyright © 2016年 张晓珊. All rights reserved.
//

import UIKit

class CourseSelectionViewModel: NSObject {
    
    var name: String?
    var isSelected: Bool = false
    
    lazy var models: [PersonInfoModel] = [PersonInfoModel]()
}
