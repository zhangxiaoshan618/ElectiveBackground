//
//  CurriculumView.swift
//  ElectiveBackground
//
//  Created by 张晓珊 on 16/11/15.
//  Copyright © 2016年 张晓珊. All rights reserved.
//

import UIKit
import SnapKit

class CurriculumView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.whiteColor()
        
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        
        addSubview(label1)
        addSubview(time1)
        addSubview(beginTime1)
        addSubview(to1)
        addSubview(endTime1)
        addSubview(type1)
        addSubview(course1_1)
        addSubview(course1_2)
        addSubview(course1_3)
        addSubview(course1_4)
        addSubview(course1_5)
        addSubview(course1_6)
        
        addSubview(maxPeopleNumberBefor)
        addSubview(maxPeopleNumber)
        addSubview(maxPeopleNumberAfter)

        label1.snp_makeConstraints { (make) in
            make.left.top.right.equalTo(self)
            make.height.equalTo(40)
        }
        
        time1.snp_makeConstraints { (make) in
            make.left.equalTo(self).inset(10)
            make.top.equalTo(label1.snp_bottom).offset(10)
            make.width.equalTo(50)
        }
        
        to1.snp_makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(time1.snp_bottom).offset(10)
            make.height.equalTo(30)
        }
        
        beginTime1.snp_makeConstraints { (make) in
            make.right.equalTo(to1.snp_left).offset(-10)
            make.top.equalTo(to1)
        }
    
        endTime1.snp_makeConstraints { (make) in
            make.left.equalTo(to1.snp_right).offset(10)
            make.top.equalTo(to1)
        }
        
        type1.snp_makeConstraints { (make) in
            make.left.equalTo(time1)
            make.top.equalTo(endTime1.snp_bottom).offset(20)
            make.width.equalTo(time1)
        }
        
        course1_1.snp_makeConstraints { (make) in
            make.top.equalTo(type1.snp_bottom).offset(10)
            make.left.right.equalTo(self).inset(10)
        }
        
        course1_2.snp_makeConstraints { (make) in
            make.top.equalTo(course1_1.snp_bottom).offset(10)
            make.left.right.equalTo(self).inset(10)
        }
        
        course1_3.snp_makeConstraints { (make) in
            make.top.equalTo(course1_2.snp_bottom).offset(10)
            make.left.right.equalTo(self).inset(10)
        }
        
        course1_4.snp_makeConstraints { (make) in
            make.top.equalTo(course1_3.snp_bottom).offset(10)
            make.left.right.equalTo(self).inset(10)
        }
        
        course1_5.snp_makeConstraints { (make) in
            make.top.equalTo(course1_4.snp_bottom).offset(10)
            make.left.right.equalTo(self).inset(10)
        }
        
        course1_6.snp_makeConstraints { (make) in
            make.top.equalTo(course1_5.snp_bottom).offset(10)
            make.left.right.equalTo(self).inset(10)
        }
        
        maxPeopleNumberBefor.snp_makeConstraints { (make) in
            make.top.equalTo(course1_6.snp_bottom).offset(20)
            make.left.equalTo(self).inset(10)
        }
        
        maxPeopleNumber.snp_makeConstraints { (make) in
            make.left.equalTo(maxPeopleNumberBefor.snp_right).offset(5)
            make.centerY.equalTo(maxPeopleNumberBefor)
            make.width.equalTo(40)
        }
        
        maxPeopleNumberAfter.snp_makeConstraints { (make) in
            make.left.equalTo(maxPeopleNumber.snp_right).offset(5)
            make.centerY.equalTo(maxPeopleNumberBefor)
        }
    
    }
    

    lazy var label1: UILabel = {
        let label = UILabel(string: "请填写一个时间段内的课程", color: UIColor.darkGrayColor(), fontSize: 20, alignmentType: NSTextAlignment.Center)
        label.backgroundColor = UIColor(white: 0.9, alpha: 1)
        return label
    }()
    
    private lazy var time1: UILabel = {
        let label = UILabel(string: "时间：", fontSize: 15)
        return label
    }()
    
    lazy var beginTime1: UITextField = {
        let text = UITextField(placeholder: "请输入上课时间", textAlignment: NSTextAlignment.Center, fontSize: 15)
        return text
    }()
    
    private lazy var to1: UILabel = {
        let label = UILabel(string: "~", fontSize: 15)
        return label
    }()
    
    lazy var endTime1: UITextField = {
        let text = UITextField(placeholder: "请输入下课时间", textAlignment: NSTextAlignment.Center, fontSize: 15)
        return text
    }()
    
    private lazy var type1: UILabel = {
        let label = UILabel(string: "课程：", fontSize: 15)
        return label
    }()
    
    lazy var course1_1: UITextField = {
        let text = UITextField(placeholder: "请输入课程名称", textAlignment: NSTextAlignment.Left, fontSize: 15)
        return text
    }()
    
    lazy var course1_2: UITextField = {
        let text = UITextField(placeholder: "请输入课程名称", textAlignment: NSTextAlignment.Left, fontSize: 15)
        return text
    }()
    
    lazy var course1_3: UITextField = {
        let text = UITextField(placeholder: "请输入课程名称", textAlignment: NSTextAlignment.Left, fontSize: 15)
        return text
    }()
    
    lazy var course1_4: UITextField = {
        let text = UITextField(placeholder: "请输入课程名称", textAlignment: NSTextAlignment.Left, fontSize: 15)
        return text
    }()
    
    lazy var course1_5: UITextField = {
        let text = UITextField(placeholder: "请输入课程名称", textAlignment: NSTextAlignment.Left, fontSize: 15)
        return text
    }()
    
    lazy var course1_6: UITextField = {
        let text = UITextField(placeholder: "请输入课程名称", textAlignment: NSTextAlignment.Left, fontSize: 15)
        return text
    }()
    
    private lazy var maxPeopleNumberBefor: UILabel = {
        let label = UILabel(string: "每门课最多有", fontSize: 15)
        return label
    }()

    lazy var maxPeopleNumber: UITextField = {
        let text = UITextField(placeholder: "00", textAlignment: NSTextAlignment.Center, fontSize: 15)
        return text
    }()

    private lazy var maxPeopleNumberAfter: UILabel = {
        let label = UILabel(string: "人参加。", fontSize: 15)
        return label
    }()
}
