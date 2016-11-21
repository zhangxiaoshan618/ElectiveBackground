//
//  TimeTableCell.swift
//  ElectiveBackground
//
//  Created by 张晓珊 on 16/11/15.
//  Copyright © 2016年 张晓珊. All rights reserved.
//

import UIKit

class TimeTableCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: "ID")
        
        contentView.addSubview(line)
        contentView.addSubview(name)
        
        name.snp_makeConstraints { (make) in
            make.left.right.equalTo(contentView).inset(10)
            make.centerY.equalTo(contentView)
        }
        
        line.snp_makeConstraints { (make) in
            make.left.bottom.right.equalTo(contentView)
            make.height.equalTo(1)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    lazy var name: UILabel = {
        let name = UILabel(string: "语文", fontSize: 17)
        return name
    }()
    
    private lazy var line: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor(white: 0.9, alpha: 1)
        return line
    }()

}
