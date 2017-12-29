//
//  HGAnchorModel.swift
//  HG_DUZB
//
//  Created by day-day-Smile on 2017/12/29.
//  Copyright © 2017年 day-day-Smile. All rights reserved.
//

import UIKit

class HGAnchorModel: NSObject {

    /// 房间号
    @objc var room_id:String = ""
    /// 房间图片对应的url
    @objc var vertical_src:String = ""
    
    /// 0 代表手机直播 1 代表电脑直播
    @objc var isVertical:Int = 0
    
    /// 房间名称
    @objc var room_name:String = ""
    
    /// 主播名称
    @objc var nickname:String = ""
    
    /// 观看人数
    @objc var online:String = ""
    
    init(dict:[String:AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}
