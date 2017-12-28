//
//  HGRecommentViewModel.swift
//  HG_DUZB
//
//  Created by day-day-Smile on 2017/12/28.
//  Copyright © 2017年 day-day-Smile. All rights reserved.
//

import UIKit

class HGRecommentViewModel {

}

extension HGRecommentViewModel {
    
    func requestData(){
        
        /// 1.推荐数据
        /// 2.颜值数据
        /// 3.游戏数据
        
        let urlString = "http://httpbin.org/get"
        
        let param = ["name":"way"]
        
        HGNetworkTools.requestData(type: .GET, URLString: urlString, parameters: param) { (response) in
            print(response)
        }
    }
}
