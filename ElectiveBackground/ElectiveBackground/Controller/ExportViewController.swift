//
//  ExportViewController.swift
//  二维码使用
//
//  Created by 张晓珊 on 16/11/14.
//  Copyright © 2016年 张晓珊. All rights reserved.
//

import UIKit
import SVProgressHUD
import ReactiveCocoa
import WebKit

class ExportViewController: UIViewController {
    
    private lazy var models:[CourseSelectionViewModel] = [CourseSelectionViewModel]()
//    private lazy var timetableModels: [TimetableViewModel] = [TimetableViewModel]()
    private lazy var personViewModels: [PersonInfoModel] = [PersonInfoModel]()
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = UIColor.whiteColor()
        automaticallyAdjustsScrollViewInsets = false
        navigationItem.titleView = segment
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "清空", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(ExportViewController.cleare))

        setUpUI()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func loadAllUsers() {
        SVProgressHUD.showWithStatus("正在努力加载数据ing……")
        ServiceManager.sharedServiceManager.loadAllUsers().subscribeNext({[weak self] (result) in
            
            let resulted = result as! [PersonInfoModel]
            self?.personViewModels = resulted
            self?.tableView.reloadData()
            SVProgressHUD.dismiss()
            }, error: { (error) in
                printLog("\(error)", logError: true)
                let errorCode = error.code
                if -1000 == errorCode {
                    SVProgressHUD.showErrorWithStatus("服务器出错！")
                }else {
                    SVProgressHUD.showErrorWithStatus("网速不给力呀！")
                }

            }) {}
    }
    
    @objc private func cleare() {
        switch segment.selectedSegmentIndex {
        case 0:
            SVProgressHUD.showWithStatus("正在删除……")
            clearAllCleasses()
        case 1:
            SVProgressHUD.showWithStatus("正在删除……")
            clearAllUsers()
        default:
            return
        }
    }
    

    @objc private func shardToQQ() {
        
        var result:String = "课程,姓名,联系方式\r\n"
        
        for model in models {
            for personals in model.models {
                result = result + (model.name ?? "未知课程") + "," + (personals.name ?? "张晓珊") + "," + (personals.phone ?? "13737737470") + "\r\n"
            }
        }
        
        writeToFiler(result.dataUsingEncoding(NSUTF8StringEncoding)!, path: ExportViewController.resultPath)
        SVProgressHUD.showSuccessWithStatus("导出成功！")
    }
    
    private func loadResult() {
        SVProgressHUD.showWithStatus("正在努力加载数据ing……")
        ServiceManager.sharedServiceManager.loadResult().subscribeNext({[weak self] (result) in
            self?.models = result as! [CourseSelectionViewModel]
            self?.tableView.reloadData()
            SVProgressHUD.dismiss()
            }, error: { (error) in
                printLog("\(error)", logError: true)
                let errorCode = error.code
                if -1000 == errorCode {
                    SVProgressHUD.showErrorWithStatus("服务器出错！")
                }else {
                    SVProgressHUD.showErrorWithStatus("网速不给力呀！")
                }

            }) {}
    }

    
    private func clearAllCleasses() {
        ServiceManager.sharedServiceManager.removeAllClasses().subscribeNext({ (result) in
            let resulted = result as! Int
            if 200 == resulted {
                SVProgressHUD.showSuccessWithStatus("删除成功！")
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
    
    private func clearAllUsers() {
        ServiceManager.sharedServiceManager.removeAllUsers().subscribeNext({[weak self]  (result) in
            let resulted = result as! Int
            if 200 == resulted {
                self?.personViewModels = [PersonInfoModel]()
                self?.tableView.reloadData()
                SVProgressHUD.showSuccessWithStatus("删除成功！")
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
    
    private func setUpUI() {
        view.addSubview(tableView)
        view.addSubview(webView)
        
        
        tableView.snp_makeConstraints { (make) in
            make.top.equalTo(snp_topLayoutGuideBottom)
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(snp_bottomLayoutGuideTop)
        }
        webView.snp_makeConstraints { (make) in
            make.top.equalTo(snp_topLayoutGuideBottom)
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(snp_bottomLayoutGuideTop)
        }
    }
    
    @objc private func segmentClick() {
        switch segment.selectedSegmentIndex {
        case 0:
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "清空", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(ExportViewController.cleare))
            webView.hidden = false
            tableView.hidden = true
        case 1:
            personViewModels = [PersonInfoModel]()
            tableView.reloadData()
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "清空", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(ExportViewController.cleare))
            loadAllUsers()
            webView.hidden = true
            tableView.hidden = false
        default:
            models = [CourseSelectionViewModel]()
            tableView.reloadData()
           navigationItem.rightBarButtonItem = UIBarButtonItem(title: "导出", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(ExportViewController.shardToQQ))
           loadResult()
           webView.hidden = true
           tableView.hidden = false
        }
    }
  
    static let resultPath = (NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).last! as NSString).stringByAppendingPathComponent("result.csv")
    
    /// 写入本地文件plist文件
    ///
    /// - parameter array: 需要写入的数组
    /// - parameter path:  文件路径
    
    private func writeToFiler(data: NSData, path: String) {
        data.writeToFile(path, atomically: true)
    }
    
    
    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.backgroundColor = UIColor(white: 0.9, alpha: 1)
        let request = NSURLRequest(URL: NSURL(string: "http://119.254.209.148:6001/login")!)
        webView.loadRequest(request)
        return webView
    }()
    
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: CGRectZero, style: UITableViewStyle.Plain)
        table.hidden = true
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = UITableViewCellSeparatorStyle.None
        table.registerClass(ExportTableHeader.self, forHeaderFooterViewReuseIdentifier: kExportTableHeaderID)
        table.registerClass(PersonInfoCell.self, forCellReuseIdentifier: kPersonInfoCellID)
        table.registerClass(TimetableHeader.self, forHeaderFooterViewReuseIdentifier: kTimetableHeaderID)
        table.registerClass(TimeTableCell.self, forCellReuseIdentifier: "ID")
        return table
    }()
    
    
    private lazy var segment: UISegmentedControl = {
        let segment = UISegmentedControl(items: ["课表", "名单", "结果"])
        segment.selectedSegmentIndex = 0
        segment.addTarget(self, action: #selector(ExportViewController.segmentClick), forControlEvents: UIControlEvents.ValueChanged)
        return segment
    }()
    
}


extension ExportViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        switch segment.selectedSegmentIndex {
        case 1:
            return 1
        default:
            return models.count
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        
        switch segment.selectedSegmentIndex {
        case 1:
             return UIView()
        default:
            let header = tableView.dequeueReusableHeaderFooterViewWithIdentifier(kExportTableHeaderID) as! ExportTableHeader
            header.model = models[section]
            header.clickBlock = {
                tableView.reloadData()
            }
            return header
        }
    }

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch segment.selectedSegmentIndex {
        case 2:
            return 50
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segment.selectedSegmentIndex {
        case 1:
            return personViewModels.count
        default:
            let isSelected = models[section].isSelected
            
            return isSelected ? models[section].models.count : 0
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch segment.selectedSegmentIndex {
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier(kPersonInfoCellID, forIndexPath: indexPath) as! PersonInfoCell
            cell.model = personViewModels[indexPath.row]
            cell.index.text = "\(indexPath.row + 1)"
        
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier(kPersonInfoCellID, forIndexPath: indexPath) as! PersonInfoCell
            
            cell.model = models[indexPath.section].models[indexPath.row]
            cell.index.text = "\(indexPath.row + 1)"
            return cell
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
            return 80
    }
}
