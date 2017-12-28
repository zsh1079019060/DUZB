
//
//  HGNetworkTools.swift
//  Alamofire的测试
//
//  Created by day-day-Smile on 2017/12/28.
//  Copyright © 2017年 day-day-Smile. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case GET
    case POST
}

/// 如果不用到 NSObject 可以不继承
/// 什么都不继承，更轻量
class HGNetworkTools {

    class func requestData(type:MethodType,URLString:String,parameters:[String:String]? = nil,finishedCallBack:@escaping (_ result:AnyObject)->()) {
        
        /// 1. 获取类型
        let methed = type == .GET ? HTTPMethod.get : HTTPMethod.post
        
        Alamofire.request(URLString, method: methed, parameters: parameters).responseJSON { (response) in
            /// 2.看看有没有值
            guard let result = response.result.value else{
               return
            }
            /// 3. 返回结果
            finishedCallBack(result as AnyObject)
        }
    }
}













