//
//  HGAmuseViewModel.swift
//  HG_DUZB
//
//  Created by day-day-Smile on 2018/1/12.
//  Copyright © 2018年 day-day-Smile. All rights reserved.
//

import UIKit
/// 不加 NSObject 更轻量级


class HGAmuseViewModel {

    lazy var anchorGroup:[HGAnchorGroup] = [HGAnchorGroup]()
}

extension HGAmuseViewModel {
    func loadAmuseData(finishedCallBack:@escaping ()->()) {
        
        /*
         "http://capi.douyucdn.cn/api/v1/getHotRoom/2"
         没有参数
         */
        HGNetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2") { (result) in
            
            /// 1.对界面进行处理
            guard let resultDist = result as? [String:AnyObject] else { return }
            guard let dictArray = resultDist["data"] as? [[String:AnyObject]] else { return }
            
            /// 2.循环遍历字典数组
            for dict in dictArray {
                self.anchorGroup.append(HGAnchorGroup(dict: dict))
            }
            
            /// 3.完成回调
            finishedCallBack()
        }
    }
}
