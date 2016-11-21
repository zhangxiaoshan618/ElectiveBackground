//
//  ImportTableViewFooter.swift
//  二维码使用
//
//  Created by 张晓珊 on 16/11/14.
//  Copyright © 2016年 张晓珊. All rights reserved.
//

import UIKit
import SnapKit

class ImportTableViewFooter: UIView {
    
    var importClickBlock: (() -> ())?
    

    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 70))
        backgroundColor = UIColor.whiteColor()
        
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        addSubview(importBtn)
        
        importBtn.snp_makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.height.equalTo(44)
            make.left.right.equalTo(self).inset(25)
        }
    }
    
    @objc private func click() {
        importClickBlock?()
    }
    
    private lazy var importBtn: UIButton = {
        let btn = UIButton(type: UIButtonType.Custom)
        btn.setTitle("提交", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        btn.backgroundColor = UIColor.blueColor()
        btn.addTarget(self, action: #selector(ImportTableViewFooter.click), forControlEvents: UIControlEvents.TouchUpInside)
        btn.layer.cornerRadius = 5
        btn.clipsToBounds = true
        
        return btn
    }()

}
