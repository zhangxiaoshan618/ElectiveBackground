//
//  NetworkTools.swift
//  startvhelper
//
//  Created by 张晓珊 on 15/11/9.
//  Copyright © 2015年 张晓珊. All rights reserved.
//
/// 放在这儿的理由
/// 1、有好多复用的接口（播放鉴权）

import Foundation
import AFNetworking
import ReactiveCocoa

enum RequestMethod: String {
    case GET = "GET"
    case POST = "POST"
}

class NetworkTools: AFHTTPSessionManager {
    
    /// 单例
    static let shardTools: NetworkTools = {
        var config = NSURLSessionConfiguration.defaultSessionConfiguration()
        var instance = NetworkTools(baseURL:NSURL(string: "http://119.254.209.148:6001/app/"), sessionConfiguration: config)
        // 设置请求参数转为JSON数据格式
        instance.requestSerializer = AFJSONRequestSerializer()
        // 设置反序列化支持的格式
        instance.responseSerializer.acceptableContentTypes?.insert("text/plain")
        instance.responseSerializer.acceptableContentTypes?.insert("text/html")
        return instance
    }()
    
    func loadResult() -> RACSignal {
        return request(.GET, URLString: "get/result/", parameters: nil)
    }
    
    func loadAllUsers() -> RACSignal {
        return request(.GET, URLString: "get/users/", parameters: nil)
    }
    
    func uploadClassTime(classTime: String) -> RACSignal {
        let parameters = ["times": [["time": classTime]]]
        
        return request(.POST, URLString: "upload/classTime", parameters: parameters)
    }
    
    func upLoadClasses(time: String, classes: [String], maxPeopleNumber: Int) -> RACSignal {
        var classesDic = [[String: AnyObject]]()
        for str in classes {
            classesDic.append(["name": str])
        }
        printLog("\(time)")
        
        let parameters: [String: AnyObject] = ["time": time, "maxPicked": maxPeopleNumber, "classes": classesDic]
        printLog("\(parameters)")
        
        return request(.POST, URLString: "upload/class", parameters: parameters)
    }
    
    func removeAllClasses() -> RACSignal {
        return request(.POST, URLString: "remove/allClass", parameters: nil)
    }
    
    // remove/allUsers
    func removeAllUsers() -> RACSignal {
        return request(.POST, URLString: "remove/allUsers/", parameters: nil)
    }
    
    func upload(users: [[String: AnyObject]]) -> RACSignal {
        let parameters = ["users": users]
        return request(.POST, URLString: "upload/users", parameters: parameters)
    }

    /// 网络请求方法(对 AFN 的 GET & POST 进行了封装)
    ///
    /// - parameter method:     method
    /// - parameter URLString:  URLString
    /// - parameter parameters: 参数字典
    /// - parameter withToken:  是否包含 accessToken，默认带 token 访问
    ///
    /// - returns: RAC Signal
    
    func request(method: RequestMethod, URLString: String, parameters: [String: AnyObject]?) -> RACSignal {
        
        return RACSignal.createSignal({ (subscriber) -> RACDisposable! in
            
            // 1. 成功的回调闭包
            let successCallBack = { (task: NSURLSessionDataTask, result: AnyObject?) -> Void in
                // 将结果发送给订阅者
                subscriber.sendNext(result)
                // 完成
                subscriber.sendCompleted()
            }
            
            // 2. 失败的回调闭包
            let failureCallBack = { (task: NSURLSessionDataTask?, error: NSError?) -> Void in
                // 即使应用程序已经发布，在网络访问中，如果出现错误，仍然要输出日志，属于严重级别的错误
                printLog(error, logError: true)
                
                subscriber.sendError(error)
            }
            
            // 3. 根据方法，选择调用不同的网络方法
            if method == .GET {
                self.GET(URLString, parameters: parameters, progress: nil, success: successCallBack, failure: failureCallBack)
            } else {
                self.POST(URLString, parameters: parameters, progress: nil, success: successCallBack, failure: failureCallBack)
            }
            
            return nil
        })
    }
}
