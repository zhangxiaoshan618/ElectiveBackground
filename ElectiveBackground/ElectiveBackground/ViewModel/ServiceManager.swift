//
//  ServiceManager.swift
//  ElectiveBackground
//
//  Created by 张晓珊 on 16/11/17.
//  Copyright © 2016年 张晓珊. All rights reserved.
//

import UIKit
import ReactiveCocoa

class ServiceManager: NSObject {
    
    static let sharedServiceManager: ServiceManager = ServiceManager()
    
    func loadResult() -> RACSignal {
        return RACSignal.createSignal({ (subscriber) -> RACDisposable! in
            NetworkTools.shardTools.loadResult().subscribeNext({ (result) in
                guard let resulted = result as? [String: AnyObject] else {
                    subscriber.sendError(NSError(domain: "com.startimes.error", code: -1000, userInfo: ["error message": "服务器出错！"]))
                    return
                }
                
                guard let status  = resulted["status"] as? Int else {
                    subscriber.sendError(NSError(domain: "com.startimes.error", code: -1000, userInfo: ["error message": "服务器出错！"]))
                    return
                }
                
                if !(200 == status) {
                    subscriber.sendError(NSError(domain: "com.startimes.error", code: -1000, userInfo: ["error message": "服务器出错！"]))
                    return
                }
                
                let msgs = resulted["msg"] as! [[String: AnyObject]]
                
                var viewModels = [CourseSelectionViewModel]()
                
                for msg in msgs {
                    printLog("\(msg)")
                    if viewModels.count == 0 {
                        let viewModel = CourseSelectionViewModel()
                        viewModel.name = msg["className"] as? String
                        viewModel.models.append(PersonInfoModel(dict: msg))
                        viewModels.append(viewModel)
                    
                    }else{
                        let classNames = (viewModels as NSArray).valueForKeyPath("name") as! [String]
                        printLog("\(classNames)")
                        if let index = classNames.indexOf(msg["className"] as! String) {
                            let personInfoModel = PersonInfoModel(dict: msg)
                            viewModels[index].models.append(personInfoModel)
                        }else {
                            let viewModel = CourseSelectionViewModel()
                            viewModel.name = msg["className"] as? String
                            viewModel.models.append(PersonInfoModel(dict: msg))
                            viewModels.append(viewModel)

                        }
                    }
                }
                
                subscriber.sendNext(viewModels)
                subscriber.sendCompleted()
                

                }, error: { (error) in
                    subscriber.sendError(error)
            })
        })
    }
    
    func uploadClasses(time: String, classes: [String], maxPeopleNumber: Int) -> RACSignal {
        
        return RACSignal.createSignal({ (subscriber) -> RACDisposable! in
            NetworkTools.shardTools.upLoadClasses(time, classes: classes, maxPeopleNumber: maxPeopleNumber).subscribeNext({ (result) in
                guard let resulted = result as? [String: AnyObject] else {
                    subscriber.sendError(NSError(domain: "com.startimes.error", code: -1000, userInfo: ["error message": "服务器出错！"]))
                    return
                }
                
                if let status  = resulted["status"] as? Int {
                    subscriber.sendNext(status)
                    subscriber.sendCompleted()
                    return
                }else if let error = resulted["error"] as? Int {
                    subscriber.sendNext(error)
                    subscriber.sendCompleted()
                    return
                }else {
                    subscriber.sendError(NSError(domain: "com.startimes.error", code: -1000, userInfo: ["error message": "服务器出错！"]))
                    return
                }

                }, error: { (error) in
                    subscriber.sendError(error)
            })
        })
    }
    
    func uploadClassTime(classTime: String) -> RACSignal {
        return RACSignal.createSignal({ (subscriber) -> RACDisposable! in
            NetworkTools.shardTools.uploadClassTime(classTime).subscribeNext({ (result) in
                
                printLog("\(result)")
                guard let resulted = result as? [String: AnyObject] else {
                    subscriber.sendError(NSError(domain: "com.startimes.error", code: -1000, userInfo: ["error message": "服务器出错！"]))
                    return
                }
                
                if let status  = resulted["status"] as? Int where 200 == status {
                    let id = ((resulted["result"] as! [[String: AnyObject]]).last!)["_id"]
                    subscriber.sendNext(id)
                    subscriber.sendCompleted()
                    return
                }else{
                    subscriber.sendError(NSError(domain: "com.startimes.error", code: -1000, userInfo: ["error message": "服务器出错！"]))
                    return
                }
                }, error: { (error) in
                    subscriber.sendError(error)
            })
        })
    }
    
    func loadAllUsers() -> RACSignal {
        return RACSignal.createSignal({ (subscriber) -> RACDisposable! in
            NetworkTools.shardTools.loadAllUsers().subscribeNext({ (result) in
                guard let resulted = result as? [String: AnyObject] else {
                    subscriber.sendError(NSError(domain: "com.startimes.error", code: -1000, userInfo: ["error message": "服务器出错！"]))
                    return
                }
                
                guard let status  = resulted["status"] as? Int else {
                    subscriber.sendError(NSError(domain: "com.startimes.error", code: -1000, userInfo: ["error message": "服务器出错！"]))
                    return
                }
                
                if !(200 == status) {
                    subscriber.sendError(NSError(domain: "com.startimes.error", code: -1000, userInfo: ["error message": "服务器出错！"]))
                    return
                }
                
                let msgs = resulted["msg"] as! [[String: AnyObject]]
                
                var models = [PersonInfoModel]()
                
                for msg in msgs {
                    let profile = msg["profile"] as! [String: AnyObject]
                    let model = PersonInfoModel(dict: profile)
                    models.append(model)
                }
                
                subscriber.sendNext(models)
                subscriber.sendCompleted()
                
                }, error: { (error) in
                    subscriber.sendError(error)
            })
        })
    }
    
    func removeAllClasses() -> RACSignal {
        return RACSignal.createSignal({ (subscriber) -> RACDisposable! in
            NetworkTools.shardTools.removeAllClasses().subscribeNext({ (result) in
                guard let resulted = result as? [String: AnyObject] else {
                    subscriber.sendError(NSError(domain: "com.startimes.error", code: -1000, userInfo: ["error message": "服务器出错！"]))
                    return
                }
                
                guard let status  = resulted["status"] as? Int else {
                    subscriber.sendError(NSError(domain: "com.startimes.error", code: -1000, userInfo: ["error message": "服务器出错！"]))
                    return
                }
                
                subscriber.sendNext(status)
                subscriber.sendCompleted()
                }, error: { (error) in
                    subscriber.sendError(error)
            })
        })
    }

    
    func removeAllUsers() -> RACSignal {
        return RACSignal.createSignal({ (subscriber) -> RACDisposable! in
            NetworkTools.shardTools.removeAllUsers().subscribeNext({ (result) in
                guard let resulted = result as? [String: AnyObject] else {
                    subscriber.sendError(NSError(domain: "com.startimes.error", code: -1000, userInfo: ["error message": "服务器出错！"]))
                    return
                }
                
                guard let status  = resulted["status"] as? Int else {
                    subscriber.sendError(NSError(domain: "com.startimes.error", code: -1000, userInfo: ["error message": "服务器出错！"]))
                    return
                }
                
                subscriber.sendNext(status)
                subscriber.sendCompleted()
                }, error: { (error) in
                    subscriber.sendError(error)
            })
        })
    }
    
    /// 上传用户操作
    ///
    /// - Parameter users: 用户数组 [["name": "XXX", "phone": "1121313131"]]
    /// - Returns: RAC信号量
    func upload(users: [[String: AnyObject]]) -> RACSignal {
        return RACSignal.createSignal({ (subscriber) -> RACDisposable! in
            NetworkTools.shardTools.upload(users).subscribeNext({ (result) in
                guard let resulted = result as? [String: AnyObject] else {
                    subscriber.sendError(NSError(domain: "com.startimes.error", code: -1000, userInfo: ["error message": "服务器出错！"]))
                    return
                }
                
                if let status  = resulted["status"] as? Int {
                    subscriber.sendNext(status)
                    subscriber.sendCompleted()
                    return
                }else if let error = resulted["error"] as? Int {
                    subscriber.sendNext(error)
                    subscriber.sendCompleted()
                    return
                }else {
                    subscriber.sendError(NSError(domain: "com.startimes.error", code: -1000, userInfo: ["error message": "服务器出错！"]))
                    return
                }
                
                }, error: { (error) in
                    subscriber.sendError(error)
                }){}
        })
    }

}
