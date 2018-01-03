//
//  HGCycelModel.swift
//  HG_DUZB
//
//  Created by day-day-Smile on 2018/1/3.
//  Copyright © 2018年 day-day-Smile. All rights reserved.
//

import UIKit

class HGCycelModel: NSObject {

    /// 标题
    var title:String = ""
    /// 图片地址
    var pic_url:String = ""
    /// 主播信息对应数据模型对象
    var anchor:HGAnchorModel?
    
    /// 主播信息对应字典
    var room:[String:AnyObject]? {
        didSet{
            guard let room = room else {
                return
            }
            anchor = HGAnchorModel(dict: room)
        }
    }
    
    /// 自定义构造函数
    init(dict:[String:AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}
