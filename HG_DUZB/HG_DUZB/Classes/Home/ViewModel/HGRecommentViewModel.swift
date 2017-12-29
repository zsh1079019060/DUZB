//
//  HGRecommentViewModel.swift
//  HG_DUZB
//
//  Created by day-day-Smile on 2017/12/28.
//  Copyright © 2017年 day-day-Smile. All rights reserved.
//

import UIKit

class HGRecommentViewModel {
    /// 懒加载
    fileprivate lazy var ancherGroups:[HGAnchorGroup] = [HGAnchorGroup]()
}

extension HGRecommentViewModel {
    
    func requestData(){
        
        /// 1.推荐数据
        /// 2.颜值数据
        /// 3.游戏数据
        /*
         热门
        "http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=1514469899"
        "time"
        "limit"
        "offset"
         颜值
         "http://capi.douyucdn.cn/api/v1/getVerticalRoom"
         "time"
         "limit"
         "offset"
        */
        let urlString = "http://capi.douyucdn.cn/api/v1/getHotCate"
        
        let param = ["limit":"4","offset":"0","time":NSDate.getCurrentTime()]
        
        HGNetworkTools.requestData(type: .GET, URLString: urlString, parameters: param) { (result) in

            /// 将result 转换成 字典类型
            guard let resuteDict = result as? [String:AnyObject] else { return }
            
            /// 将字典类型 转换成 数组
            guard let resultArr = resuteDict["data"] as? [[String:AnyObject]] else { return }
            
            /// 遍历数组 ，将数组中的字典转模型
            for dict in resultArr {
                
                let group = HGAnchorGroup.init(dict: dict)
                
                self.ancherGroups.append(group)
                
            }
            
            for group in self.ancherGroups {
                /// 打印是否可以取值
                for anchor in group.anchorModel{
                    print(anchor.nickname)
                }
            }
            
            
        }
    }
}
