//
//  HGGameViewModel.swift
//  HG_DUZB
//
//  Created by day-day-Smile on 2018/1/5.
//  Copyright © 2018年 day-day-Smile. All rights reserved.
//

import UIKit

class HGGameViewModel {
    /// 游戏模型数组
    lazy var gameModels:[HGGameModel] = [HGGameModel]()
}

extension HGGameViewModel{
    
    func loadAllGameData(finishedCallBlock:@escaping ()->()) {
        
        /*
         全部数据
         "http://capi.douyucdn.cn/api/v1/getColumnDetail?shortName=game"
         "shortName":"game"
         
         */
        HGNetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: ["shortName":"game"]) { (result) in
            print(result)
            /// 获取数据
            guard let resultDict = result as? [String:AnyObject] else { return }
            /// 获取字典数组
            guard let dictArray = resultDict["data"] as? [[String:AnyObject]] else { return }
            
            /// 循环遍历
            for dict in dictArray {
                /// 字典转模型
                self.gameModels.append(HGGameModel.init(dict: dict))
            }
            /// 完成回调
            finishedCallBlock()
        }
    }
}
