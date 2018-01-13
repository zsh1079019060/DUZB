//
//  HGAmuseViewModel.swift
//  HG_DUZB
//
//  Created by day-day-Smile on 2018/1/12.
//  Copyright © 2018年 day-day-Smile. All rights reserved.
//

import UIKit
/// 不加 NSObject 更轻量级


class HGAmuseViewModel : HGBaseViewModel {

   
}

extension HGAmuseViewModel {
    func loadAmuseData(finishedCallBack:@escaping ()->()) {
        /*
         "http://capi.douyucdn.cn/api/v1/getHotRoom/2"
         没有参数
         */
        loadAnchorData(URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", finishedCallBack: finishedCallBack)

    }
}
