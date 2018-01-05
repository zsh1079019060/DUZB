//
//  HGBaseGameModel.swift
//  HG_DUZB
//
//  Created by day-day-Smile on 2018/1/5.
//  Copyright © 2018年 day-day-Smile. All rights reserved.
//

import UIKit

class HGBaseGameModel: NSObject {
    
    // MARK: 模型属性
    @objc var tag_name:String = ""
    @objc var icon_url:String = ""
    
    /// MARK: 自定义构造函数
    /// 构造函数
    override init() {
        
    }

    init(dict:[String:AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    /// 重写这个方法  是为了防止 有的参数没有用到，程序运行报错
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
