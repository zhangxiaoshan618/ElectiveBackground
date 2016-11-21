//
//  MainViewController.swift
//  startvhelper
//
//  Created by 张晓珊 on 15/11/9.
//  Copyright © 2015年 张晓珊. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    
    override class func initialize() {
        let tabBar = UITabBar.appearance()
        tabBar.barTintColor = UIColor.whiteColor()
        let tabbarItem = UITabBarItem.appearance()
        tabbarItem.setTitleTextAttributes([NSFontAttributeName: UIFont.systemFontOfSize(13)], forState: UIControlState.Normal)
    }
    
    // MARK: - 控制器的生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 添加子控制器
        addChildViewControllers()
    }
    
    
    /// 陕广电的tabBar
    private func addChildViewControllers() {
        // 设置渲染色
        addChildViewController(CurriculumController(), title: "课程", imageName: "wj_tabbar_info")
        addChildViewController(ViewController(), title: "名单", imageName: "tabbar_profile")
        addChildViewController(ExportViewController(), title: "查询", imageName: "tabbar_discover")
    }
    
    /// 添加子控制器
    ///
    /// - parameter vc:        控制器
    /// - parameter title:     控制器的标题
    /// - parameter imageName: tabbarButton对应的图片
    private func addChildViewController(vc: UIViewController, title: String, imageName: String) {

        vc.title = title
        
        vc.tabBarItem.image = UIImage(named: imageName)

        let nav = MyNavigationController(rootViewController: vc)
        addChildViewController(nav)
    }
    
}
