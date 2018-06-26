//
//  NetWorkTools.swift
//  AFEFactory
//
//  Created by ilovedxracer on 2018/2/5.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

import UIKit
//枚举定义请求方式
enum HTTPRequestType {
    case GET
    case POST
}
class NetWorkTools: AFHTTPSessionManager {
    //单例
    static let shared = NetWorkTools()
    //   - 封装GET和POST 请求
    //   - Parameters:
    //   - requestType: 请求方式
    //   - urlString: urlString
    //   - parameters: 字典参数
    //   - completion: 回调
    func request(requestType: HTTPRequestType, urlString: String, parameters: [String: AnyObject]?, completion: @escaping (AnyObject?) -> ()) {
        //成功回调
        let success = { (task: URLSessionDataTask, json: Any)->() in
            completion(json as AnyObject?)
        }
        //失败回调
        let failure = { (task: URLSessionDataTask?, error: Error) -> () in
            print("网络请求错误 \(error)")
            completion(nil)
        }
        if requestType == .GET {
            get(urlString, parameters: parameters, progress: nil, success: success, failure: failure)
        } else {
            post(urlString, parameters: parameters, progress: nil, success: success, failure: failure)
        }
    }
    func NSString(str:NSString) -> NSString {
        let string = "http://106.14.249.13:8888/image/dxracerFTP/" + (str as String)
        return string as NSString
    }
    func KURLNSString(str:NSString) -> NSString {
        let string = "http://10.0.0.28:8080/dxracer-factory-web/app/" + (str as String)
        return string as NSString
    }
    func KNSString(str:NSString) -> NSString {
        let string = "http://10.0.0.28:8080/dxracer-factory-web/servlet/equipment/equipment/scan/" + (str as String)
        return string as NSString
    }
}

