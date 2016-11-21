//
//  ExportTableHeader.swift
//  二维码使用
//
//  Created by 张晓珊 on 16/11/14.
//  Copyright © 2016年 张晓珊. All rights reserved.
//

let kExportTableHeaderID = "ExportTableHeaderID"


import UIKit
import SnapKit

class ExportTableHeader: UITableViewHeaderFooterView {
    
    var clickBlock:(() -> ())?
    
    var model: CourseSelectionViewModel? {
        didSet {
            image.transform = model!.isSelected ? CGAffineTransformMakeRotation(CGFloat(M_PI_2)) : CGAffineTransformMakeRotation(0)
            name.text = model?.name
            count.text = "\(model!.models.count)"
        }
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: kExportTableHeaderID)
        contentView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        model!.isSelected = !model!.isSelected
        image.transform = model!.isSelected ? CGAffineTransformMakeRotation(CGFloat(M_PI_2)) : CGAffineTransformMakeRotation(0)
        
        clickBlock?()
    }
    
    private func setUpUI() {
        contentView.addSubview(image)
        contentView.addSubview(name)
        contentView.addSubview(count)
        contentView.addSubview(line)
        
        image.snp_makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.left.equalTo(10)
            make.width.equalTo(7)
        }
        
        count.snp_makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.right.equalTo(contentView).inset(10)
            make.width.equalTo(30)
        }
        
        name.snp_makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.left.equalTo(image.snp_right).offset(10)
            make.right.equalTo(count.snp_left).offset(-10)
        }
        
        line.snp_makeConstraints { (make) in
            make.left.bottom.right.equalTo(contentView)
            make.height.equalTo(1)
        }
    }
    
    private lazy var image: UIImageView = {
        let image = UIImageView(image: UIImage(named: "buddy_header_arrow"))
        image.clipsToBounds = false
        return image
    }()
    
    lazy var name: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGrayColor()
        return label
    }()
    
    lazy var count: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGrayColor()
        label.textAlignment = NSTextAlignment.Right
        label.text = "000"
        return label
    }()
    
    private lazy var line: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor(white: 0.9, alpha: 1)
        return line
    }()
}
