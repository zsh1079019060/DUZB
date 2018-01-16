//
//  HGBaseViewModel.swift
//  HG_DUZB
//
//  Created by day-day-Smile on 2018/1/13.
//  Copyright © 2018年 day-day-Smile. All rights reserved.
//

import UIKit

class HGBaseViewModel {
 
    lazy var ancherGroups:[HGAnchorGroup] = [HGAnchorGroup]()
}

extension HGBaseViewModel{
    
    func loadAnchorData(isGroup:Bool,URLString:String,pararmters:[String:AnyObject]? = nil,finishedCallBack:@escaping ()->()) {
        
        HGNetworkTools.requestData(type: .GET, URLString: URLString,parameters: pararmters as? [String : String]) { (result) in
            
            /// 1.对界面进行处理
            guard let resultDist = result as? [String:AnyObject] else { return }
            guard let dictArray = resultDist["data"] as? [[String:AnyObject]] else { return }
            
            if isGroup {
                /// 2.循环遍历字典数组
                for dict in dictArray {
                    self.ancherGroups.append(HGAnchorGroup(dict: dict))
                }
            }else{
                /// 创建组
                let group = HGAnchorGroup()
                
                /// 遍历dataArray的所有字典
                for dict in dictArray {
                    group.anchors.append(HGAnchorModel(dict: dict))
                    /// 添加group到self.ancherGroups
                    self.ancherGroups.append(group)
                }
                
            }
                
            
            
            /// 3.完成回调
            finishedCallBack()
        }
    }
}
