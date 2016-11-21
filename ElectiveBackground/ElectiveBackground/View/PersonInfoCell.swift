//
//  PersonInfoCell.swift
//  二维码使用
//
//  Created by 张晓珊 on 16/11/12.
//  Copyright © 2016年 张晓珊. All rights reserved.
//

let kPersonInfoCellID = "PersonInfoCellID"


import UIKit

class PersonInfoCell: UITableViewCell {
    
    var model: PersonInfoModel? {
        didSet {
            name.text = model?.name
            phoneNumber.text = model?.phone
        }
    }
    
    var endEdit: ((text: UITextField) -> ())?
    

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: kPersonInfoCellID)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        contentView.addSubview(index)
        contentView.addSubview(nameLabel)
        contentView.addSubview(name)
        contentView.addSubview(phoneLable)
        contentView.addSubview(phoneNumber)
        contentView.addSubview(line)
        
        index.snp_makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.left.equalTo(contentView).inset(10)
            make.width.equalTo(50)
        }
        
        nameLabel.snp_makeConstraints { (make) in
            make.top.equalTo(contentView)
            make.width.equalTo(90)
            make.bottom.equalTo(contentView.snp_centerY)
            make.left.equalTo(index.snp_right).offset(10)

        }
        
        name.snp_makeConstraints { (make) in
            make.top.right.equalTo(contentView)
            make.bottom.equalTo(contentView.snp_centerY)
            make.left.equalTo(nameLabel.snp_right)
        }
        
        phoneLable.snp_makeConstraints { (make) in
            make.top.equalTo(name.snp_bottom)
            make.left.equalTo(index.snp_right).offset(10)
            make.bottom.equalTo(contentView)
            make.width.equalTo(90)
        }
        
        phoneNumber.snp_makeConstraints { (make) in
            make.top.equalTo(name.snp_bottom)
            make.left.equalTo(phoneLable.snp_right)
            make.bottom.right.equalTo(contentView)
        }
        
        line.snp_makeConstraints { (make) in
            make.left.bottom.right.equalTo(contentView)
            make.height.equalTo(1)
        }
        
    }
    
    @objc private func textChange(sender: UITextField) {
        endEdit?(text: sender)
    }
    
    
    lazy var index: UILabel = {
        let label = UILabel()
        label.text = "000"
        label.textColor = UIColor.darkGrayColor()
        label.textAlignment = NSTextAlignment.Center
        label.sizeToFit()
        return label
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "姓名："
        label.textColor = UIColor.darkGrayColor()
        label.textAlignment = NSTextAlignment.Center
        label.layer.borderColor = UIColor(white: 0.9, alpha: 1).CGColor
        label.layer.borderWidth = 1
        label.sizeToFit()
        return label
    }()
    
    lazy var name: UITextField = {
        let text = UITextField()
        text.tag = 1
        text.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
        text.leftViewMode = UITextFieldViewMode.Always
        text.clearButtonMode = UITextFieldViewMode.WhileEditing
        
        text.textColor = UIColor.darkGrayColor()
        text.textAlignment = NSTextAlignment.Left
        text.layer.borderColor = UIColor(white: 0.9, alpha: 1).CGColor
        text.layer.borderWidth = 1
        text.placeholder = "请输入姓名"
        
        text.addTarget(self, action: #selector(PersonInfoCell.textChange), forControlEvents: UIControlEvents.EditingDidEnd)
        return text
    }()
    
    lazy var phoneLable: UILabel = {
        let label = UILabel()
        label.text = "手机号："
        label.textColor = UIColor.darkGrayColor()
        label.textAlignment = NSTextAlignment.Center
        label.layer.borderColor = UIColor(white: 0.9, alpha: 1).CGColor
        label.layer.borderWidth = 1
        label.sizeToFit()
        return label
    }()
    
    lazy var phoneNumber: UITextField = {
        let text = UITextField()
        text.tag = 2
        text.placeholder = "请输入联系方式"
        text.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
        text.leftViewMode = UITextFieldViewMode.Always
        text.clearButtonMode = UITextFieldViewMode.WhileEditing
        text.textColor = UIColor.darkGrayColor()
        text.textAlignment = NSTextAlignment.Left
        text.layer.borderColor = UIColor(white: 0.9, alpha: 1).CGColor
        text.layer.borderWidth = 1
        text.addTarget(self, action: #selector(PersonInfoCell.textChange), forControlEvents: UIControlEvents.EditingDidEnd)
        
        return text
    }()
    
    private lazy var line: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.9, alpha: 1)
        return view
    }()

}
