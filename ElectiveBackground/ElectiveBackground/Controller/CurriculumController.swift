//
//  CurriculumController.swift
//  二维码使用
//
//  Created by 张晓珊 on 16/11/14.
//  Copyright © 2016年 张晓珊. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import SVProgressHUD
import ReactiveCocoa

class CurriculumController: UIViewController {
    // 400
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = UIColor.whiteColor()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "提交", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(CurriculumController.submitClick))
        
        setUpUI()
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().shouldResignOnTouchOutside = true
    }
    
    private func setUpUI() {
        let part = CurriculumView()
        view.addSubview(part)
        partView = part
        
        part.snp_makeConstraints { (make) in
            make.top.equalTo(snp_topLayoutGuideBottom)
            make.left.right.equalTo(view)
            make.bottom.equalTo(snp_bottomLayoutGuideTop)
        }
        
    }
    
    @objc private func submitClick() {
        SVProgressHUD.show()
        if let subviews = partView?.subviews {
            for view in subviews {
                if view.isKindOfClass(UITextField.self) {
                    if stringLengthIsEqualToZero((view as! UITextField).text) {
                        SVProgressHUD.showInfoWithStatus("请完整填写信息")
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(2 * NSEC_PER_SEC)), dispatch_get_main_queue()) {
                            view.becomeFirstResponder()
                        }
                        
                        return
                    }
                }
            }
            
            SVProgressHUD.showWithStatus("正在上传……")
            uploadClassesInfo()
        }

    }
    
    private func uploadClassesInfo() {
        let time = "\(partView!.beginTime1.text!)~\(partView!.endTime1.text!)"
        let classes = [partView!.course1_1.text!, partView!.course1_2.text!, partView!.course1_3.text!, partView!.course1_4.text!, partView!.course1_5.text!, partView!.course1_6.text!]
        let maxPeopleNumber = (partView!.maxPeopleNumber.text! as NSString).integerValue
        
        ServiceManager.sharedServiceManager.uploadClassTime(time).subscribeNext({[weak self] (result) in
            let resulted = result as! String
            printLog("\(resulted)")
            self?.uploadClassWith(resulted, classes: classes, maxPeopleNumber: maxPeopleNumber)
            }, error: { (error) in
                printLog("\(error)", logError: true)
                let errorCode = error.code
                if -1000 == errorCode {
                    SVProgressHUD.showErrorWithStatus("服务器出错！")
                }else {
                    SVProgressHUD.showErrorWithStatus("网速不给力呀！")
                }
        }){}
    }
    
    
    private func uploadClassWith(id: String, classes: [String], maxPeopleNumber: Int) {
        ServiceManager.sharedServiceManager.uploadClasses(id, classes: classes, maxPeopleNumber: maxPeopleNumber).subscribeNext({[weak self] (result) in
            let resulted = result as! Int
            if 200 == resulted {
                self?.partView?.removeFromSuperview()
                self?.setUpUI()
                SVProgressHUD.showSuccessWithStatus("上传成功！")
            }else if 403 == resulted {
                SVProgressHUD.showErrorWithStatus("不能上传重复数据！")
            }else {
                SVProgressHUD.showErrorWithStatus("出现未知错误！")
            }
            }, error: { (error) in
                printLog("\(error)", logError: true)
                let errorCode = error.code
                if -1000 == errorCode {
                    SVProgressHUD.showErrorWithStatus("服务器出错！")
                }else {
                    SVProgressHUD.showErrorWithStatus("网速不给力呀！")
                }
        }){}
    
    }

    private func stringLengthIsEqualToZero(string: String?) -> Bool {
        let num = string?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
        return (0 == num)
    }
    
    weak var partView: CurriculumView?
}
