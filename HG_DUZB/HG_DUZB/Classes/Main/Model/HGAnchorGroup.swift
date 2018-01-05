//
//  HGAnchorGroup.swift
//  HG_DUZB
//
//  Created by day-day-Smile on 2017/12/28.
//  Copyright © 2017年 day-day-Smile. All rights reserved.
//

import UIKit

class HGAnchorGroup: NSObject {

    /// 该组中对应的房间信息 - 字典数组
    /// 第二种方法
    @objc var room_list:[[String:AnyObject]]?{
        didSet{
            guard let room_list = room_list else {
                return
            }
            for dict in room_list {
                anchors.append(HGAnchorModel.init(dict: dict))
            }
        }
    }
    
    @objc var tag_id:Int = 0
    
    /// 组显示的标题
    @objc var tag_name:String?
    
    /// 组头标
    @objc var icon_name:String = "home_header_normal"
    
    /// 游戏对应图标
    @objc var icon_url:String?
    
    /// 懒加载主播模型对象数组 
    lazy var anchors:[HGAnchorModel] = [HGAnchorModel]()
    
    /// 构造函数
    override init() {
        
    }
    
    init(dict:[String : AnyObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }

    /*
     第一种方法
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "room_list" {
            if let dictArray = value as? [[String:AnyObject]] {
                for dict in dictArray  {
                    anchorModel?.append(HGAnchorModel.init(dict: dict))
                }
            }
        }
    }
     */
    /// 重写这个方法  是为了防止 有的参数没有用到，程序运行报错 
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    

}
