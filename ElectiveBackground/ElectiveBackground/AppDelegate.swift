//
//  AppDelegate.swift
//  二维码使用
//
//  Created by 张晓珊 on 16/11/11.
//  Copyright © 2016年 张晓珊. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import SVProgressHUD

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        setUpSVProgressHUD()
        
        window = UIWindow()
        window?.rootViewController = MainViewController()
        window?.makeKeyAndVisible()
        return true
    }
    
    ///  设置SVProgressHUD的样式
    private func setUpSVProgressHUD() {
        SVProgressHUD.setMinimumDismissTimeInterval(2)
        SVProgressHUD.setDefaultMaskType(.Gradient)
        SVProgressHUD.setDefaultStyle(.Light)
    }

    
}

