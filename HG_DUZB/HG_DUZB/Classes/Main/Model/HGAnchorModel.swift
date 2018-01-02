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
    var room_id:String = ""
    /// 房间图片对应的url
    var vertical_src:String = ""
    
    /// 0 代表手机直播 1 代表电脑直播
    var isVertical:Int = 0
    
    /// 房间名称
    var room_name:String = ""
    
    /// 主播名称
    var nickname:String = ""
    
    /// 观看人数
    var online:String = ""
    
    /// 所在城市
    var anchor_city:String = ""
    
    init(dict:[String : AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
         print(value ?? "",key)
    }
    
}
