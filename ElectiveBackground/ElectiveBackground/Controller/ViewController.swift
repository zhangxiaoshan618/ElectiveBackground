//
//  ViewController.swift
//  二维码使用
//
//  Created by 张晓珊 on 16/11/11.
//  Copyright © 2016年 张晓珊. All rights reserved.
//

import UIKit
import HMQRCodeScanner
import SnapKit
import IQKeyboardManagerSwift
import SVProgressHUD


class ViewController: UIViewController {
    
    private lazy var models: [PersonInfoModel] = [PersonInfoModel]()
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = UIColor.whiteColor()
        automaticallyAdjustsScrollViewInsets = false
        
        navigationItem.title = "共0人"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "扫一扫", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(ViewController.scan))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "添加", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(ViewController.addPersonInfo))
        setUpUI()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().shouldResignOnTouchOutside = true
        
    }
    
    private func setUpUI() {
        view.addSubview(tableView)
        
        tableView.snp_makeConstraints { (make) in
            make.top.equalTo(snp_topLayoutGuideBottom)
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(snp_bottomLayoutGuideTop)
        }
    }
    
    @objc private func scan() {
        let cardName = "天涯刀哥 - 傅红雪"
        let avatar = UIImage(named: "avatar")
        
        let scanner = HMScannerController.scannerWithCardName(cardName, avatar: avatar) {[weak self]  (stringValue) -> Void in
            
            printLog("\(stringValue)")
            SVProgressHUD.showWithStatus("正在努力的加载数据ing……")
            
            let url = NSURL(string: stringValue)
            
            let request = NSURLRequest(URL: url!)
            
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {(response, data, error) in
                
                if let er = error {
                    printLog("\(er)")
                    SVProgressHUD.showErrorWithStatus("网络不给力呀！！！")
                    return
                }
                
                let result = NSString(data: data!, encoding: NSUTF8StringEncoding)
                
                let pattern = "http://active.clewm.net/([a-zA-Z0-9]{1,10})\\?key=([a-zA-Z0-9]{0,100})"
                
                do {
                    let regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpressionOptions.CaseInsensitive)
                    let array = regex.matchesInString( result! as String, options: NSMatchingOptions.ReportCompletion, range: NSRange(location: 0, length: result!.length))
                    
                    printLog("\(array.count)")
                    
                    if array.count == 0 {
                        SVProgressHUD.showErrorWithStatus("数据有误，请联系开发人员！")
                    }
                    
                    printLog("\(result!.substringWithRange(array.last!.range))")
                    
                    self?.loadUser(result!.substringWithRange(array.last!.range))
                    
                } catch {
                    printLog("失败了")
                    
                    SVProgressHUD.showErrorWithStatus("数据有误，请联系开发人员！")
                }
                
            }
            
        }
        
        self.showDetailViewController(scanner, sender: nil)
        
    }
    
    private func loadUser(stringValue: String) {
        
        let url = NSURL(string: stringValue)
        
        let request = NSURLRequest(URL: url!)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {[weak self] (response, data, error) in
            
            if let er = error {
                printLog("\(er)")
                SVProgressHUD.showErrorWithStatus("网络不给力呀！！！")
            }
            
            let result = NSString(data: data!, encoding: NSUTF8StringEncoding)
            
            var infos = [NSString]()
            
            let pattern = "(\"姓名\":\")[\\u4e00-\\u9fa5]{0,10}(\",\"手机号\":)[0-9]{11}"
            
            let pattern2 = "(\"姓名\":\")[\\u4e00-\\u9fa5]{0,10}(\",\"手机号\":\")[0-9]{11}"
            
            do {
                var regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpressionOptions.CaseInsensitive)
                var array = regex.matchesInString( result! as String, options: NSMatchingOptions.ReportCompletion, range: NSRange(location: 0, length: result!.length))
                var str = "\",\"手机号\":"
                
                if array.count == 0 {
                    regex = try NSRegularExpression(pattern: pattern2, options: NSRegularExpressionOptions.CaseInsensitive)
                    array = regex.matchesInString( result! as String, options: NSMatchingOptions.ReportCompletion, range: NSRange(location: 0, length: result!.length))
                    str = "\",\"手机号\":\""
                }
                
                for checkingResult in array {
                    
                    infos.append(result!.substringWithRange(checkingResult.range).stringByReplacingOccurrencesOfString("\"姓名\":\"", withString: "").stringByReplacingOccurrencesOfString(str, withString: "."))
                }
                self?.models.removeAll()
                for info in infos {
                    let array = info.componentsSeparatedByString(".")
                    let model = PersonInfoModel(dict: ["XXX": "000000000000"])
                    model.name = array.first
                    model.phone = array.last
                    self?.models.append(model)
                }
                
                if self?.models.count == 0 {
                    
                    let regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpressionOptions.CaseInsensitive)
                    let array = regex.matchesInString( result! as String, options: NSMatchingOptions.ReportCompletion, range: NSRange(location: 0, length: result!.length))
                    for checkingResult in array {
                        
                        infos.append(result!.substringWithRange(checkingResult.range).stringByReplacingOccurrencesOfString("\"姓名\":\"", withString: "").stringByReplacingOccurrencesOfString("\",\"手机号\":", withString: "."))
                    }
                    self?.models.removeAll()
                    for info in infos {
                        let array = info.componentsSeparatedByString(".")
                        let model = PersonInfoModel(dict: ["XXX": "000000000000"])
                        model.name = array.first
                        model.phone = array.last
                        self?.models.append(model)
                    }
                    
                }
                
                self?.tableView.reloadData()
                self?.navigationItem.title = "共\(self!.models.count)人"
                self?.tableView.tableFooterView = self?.footer
                SVProgressHUD.dismiss()
                
            } catch {
                printLog("失败了")
                
                SVProgressHUD.showErrorWithStatus("数据有误，请联系开发人员！")
            }
            
        }
    
    }
    
    @objc private func addPersonInfo() {
        
        models.append(PersonInfoModel(dict: ["XXX": "000000000000"]))
        navigationItem.title = "共\(models.count)人"
        tableView.reloadData()
        tableView.tableFooterView = footer
        let indexPath = NSIndexPath(forRow: models.count - 1, inSection: 0)
        tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: false)
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! PersonInfoCell
        cell.name.becomeFirstResponder()
    }
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: CGRectZero, style: UITableViewStyle.Plain)
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = UITableViewCellSeparatorStyle.None
        table.rowHeight = 80
        table.registerClass(PersonInfoCell.self, forCellReuseIdentifier: kPersonInfoCellID)
        return table
    }()

    private lazy var footer: ImportTableViewFooter = {
        let footer = ImportTableViewFooter()
        footer.importClickBlock = {[weak self] in
            IQKeyboardManager.sharedManager().resignFirstResponder()
            SVProgressHUD.showWithStatus("正在上传……")
            var array = [[String: AnyObject]]()
            
            for (index, model) in self!.models.enumerate() {
                if !NSString.validateMobile(model.phone) {
                    SVProgressHUD.showErrorWithStatus("第\(index + 1)个手机号码不正确")
                    return
                }
                let dic = model.dictionaryWithValuesForKeys(["name", "phone"])
                array.append(dic)
            }
            ServiceManager.sharedServiceManager.upload(array).subscribeNext({[weak self] (result) in
                let resulted = result as! Int
                if 200 == resulted {
                    self?.models = [PersonInfoModel]()
                    self?.tableView.reloadData()
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
        
        return footer
    }()
    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    // Override to support editing the table view.
    func tableView(tableView: UITableView, willBeginEditingRowAtIndexPath indexPath: NSIndexPath) {
        IQKeyboardManager.sharedManager().resignFirstResponder()
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        models.removeAtIndex(indexPath.row)
        navigationItem.title = "共\(models.count)人"
        
        if editingStyle == .Delete {
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64((25 * NSEC_PER_SEC) / 100)), dispatch_get_main_queue()) {
            self.tableView.reloadData()
        }
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return models.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kPersonInfoCellID, forIndexPath: indexPath) as! PersonInfoCell
        cell.model = models[indexPath.row]
        cell.index.text = "\(indexPath.row + 1)"
        cell.endEdit = {[weak self] (sender) -> () in
            switch sender.tag {
            case 1:
                self?.models[indexPath.row].name = sender.text
            default:
                self?.models[indexPath.row].phone = sender.text
            }
        }
        
        return cell
        
    }
}

