//
//  MyNavigationController.swift
//  startvhelper
//
//  Created by 张晓珊 on 16/2/19.
//  Copyright © 2016年 张晓珊. All rights reserved.
//

import UIKit

class MyNavigationController: UINavigationController, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    /// 自定义返回按钮
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        if childViewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        
        interactivePopGestureRecognizer?.delegate = self
        super.pushViewController(viewController, animated: true)
    }
}
