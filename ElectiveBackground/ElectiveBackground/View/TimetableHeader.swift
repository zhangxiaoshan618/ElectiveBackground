//
//  TimetableHeader.swift
//  ElectiveBackground
//
//  Created by 张晓珊 on 16/11/15.
//  Copyright © 2016年 张晓珊. All rights reserved.
//

let kTimetableHeaderID = "TimetableHeaderID"


import UIKit
import SnapKit

class TimetableHeader: UITableViewHeaderFooterView {

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: kTimetableHeaderID)
        contentView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        contentView.addSubview(time)
        contentView.addSubview(line)
        
        time.snp_makeConstraints { (make) in
            make.left.right.equalTo(contentView).inset(10)
            make.centerY.equalTo(contentView)
        }
        
        line.snp_makeConstraints { (make) in
            make.left.bottom.right.equalTo(contentView)
            make.height.equalTo(1)
        }
        
    }

    
    lazy var time: UILabel = {
        let time = UILabel(string: "00:00~00:00", fontSize: 20)
        return time
    }()

    private lazy var line: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor(white: 0.9, alpha: 1)
        return line
    }()
}
