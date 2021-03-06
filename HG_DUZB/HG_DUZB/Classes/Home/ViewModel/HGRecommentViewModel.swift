//
//  HGRecommentViewModel.swift
//  HG_DUZB
//
//  Created by day-day-Smile on 2017/12/28.
//  Copyright © 2017年 day-day-Smile. All rights reserved.
//

import UIKit

class HGRecommentViewModel:HGBaseViewModel{

    /// 把 最热 和 颜值 添加到最前面 所以  把数据全部请求完，在进行添加 
    /// 最热
    fileprivate lazy var prettyGroups:HGAnchorGroup = HGAnchorGroup()
    /// 颜值
    fileprivate lazy var bigDataGroups:HGAnchorGroup = HGAnchorGroup()
    /// 轮播数据
    lazy var cycleModel:[HGCycelModel] = [HGCycelModel]()
}

extension HGRecommentViewModel {
    /// MARK: - 请求推荐数据
    func requestData(finishCallBack:@escaping ()->() ){
        
        /// 1.推荐数据
        /// 2.颜值数据
        /// 3.游戏数据
        /*
         热门
         "http://capi.douyucdn.cn/api/v1/getbigDataRoom"
         "time"
         
         2 - 12
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
        
        let param = ["limit":"4","offset":"0","time":Date.getCurrentTime()]
        /// 热门
        /// 创建组
        let enterGroup = DispatchGroup.init()
        /// 进组
        enterGroup.enter()
        HGNetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time":Date.getCurrentTime()]) { (result) in
            // print("========\(result)")
            /// 将result 转换成 字典类型
            guard let resuteDict = result as? [String:AnyObject] else { return }
            
            /// 将字典类型 转换成 数组
            guard let resultArr = resuteDict["data"] as? [[String:AnyObject]] else { return }
            
            /// 3.创建组 - 通过组来添加到模型数组中
            /// 3.1设置属性
            self.bigDataGroups.tag_name = "热门"
            
            self.bigDataGroups.icon_name = "home_header_hot"
            /// 3.3 获取主播数据
            for dict in resultArr {
                
                let anchor = HGAnchorModel(dict: dict)
                
                self.bigDataGroups.anchors.append(anchor)
            }
            /// 出组
            enterGroup.leave()
        }
        
        /// 颜值
        enterGroup.enter()
        HGNetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: param) { (result) in
            
            // print("--------\(result)")
            /// 将result 转换成 字典类型
            guard let resuteDict = result as? [String:AnyObject] else { return }
            
            /// 将字典类型 转换成 数组
            guard let resultArr = resuteDict["data"] as? [[String:AnyObject]] else { return }
            
            /// 3.创建组 - 通过组来添加到模型数组中
            /// 3.1设置属性
            self.prettyGroups.tag_name = "颜值"
            self.prettyGroups.icon_name = "home_header_phone"
            /// 3.3 获取主播数据
            for dict in resultArr {
                
                let anchor = HGAnchorModel.init(dict: dict)
                
                self.prettyGroups.anchors.append(anchor)
            }
            /// 出组
            enterGroup.leave()
            
        }
        
        /// 2 - 12的数据
        enterGroup.enter()
        loadAnchorData(isGroup: true, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate",pararmters: param as [String : AnyObject]) {
            /// 出组
            enterGroup.leave()
        }

        /// 主线程监听，只有当队列组中没有任务，才会执行闭包。如果多次调用该方法，每次都会去检查队列组中是否有任务，如果没有任务才执行
        enterGroup.notify(queue: DispatchQueue.main) {
            
            self.ancherGroups.insert(self.prettyGroups, at: 0)
            self.ancherGroups.insert(self.bigDataGroups, at: 0)
            
            /// 加载完成后 返回
            finishCallBack()
        }
    }
    /// MARK: - 请求轮播数据
    func requeseCycleData(finishCallBack:@escaping ()->()) {
        /*
         热门
         "http://www.douyutv.com/api/v1/slide/6?version=2.300"
         "version" : "2.300"
         */
        HGNetworkTools.requestData(type: .GET, URLString: "http://www.douyutv.com/api/v1/slide/6", parameters: ["version" : "2.300"]) { (result) in
            print(result)
            /// 获取整体字典数据
            guard let resultDict = result as? [String:AnyObject] else {
                return
            }
            /// 获取 data 数据数组
            guard let dataArray = resultDict["data"] as? [[String:AnyObject]] else {
                return
            }
            // 字典转模型
            for dict in dataArray {
                self.cycleModel.append(HGCycelModel(dict: dict))
            }
            
            finishCallBack()
        }
    }
}
