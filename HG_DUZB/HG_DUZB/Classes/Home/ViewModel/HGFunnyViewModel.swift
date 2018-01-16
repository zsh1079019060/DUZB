//
//  HGFunnyViewModel.swift
//  HG_DUZB
//
//  Created by day-day-Smile on 2018/1/16.
//  Copyright © 2018年 day-day-Smile. All rights reserved.
//

import UIKit

class HGFunnyViewModel:HGBaseViewModel {

}
extension HGFunnyViewModel{
    
    func loadFunnyData(finishedCallBack:@escaping ()->()) {
        /*
        "http://capi.douyucdn.cn/api/v1/getColumnRoom/3"
         参数:
         limit：请求的个数
         offset：数据偏移量
        */
        let param = ["limit":"30","offset":"0"] as [String:AnyObject]
        
        loadAnchorData(isGroup: false, URLString: "http://capi.douyucdn.cn/api/v1/getColumnRoom/3", pararmters:param) {
            finishedCallBack()
        }
    }
} 
