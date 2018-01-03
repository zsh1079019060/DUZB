//
//  HGPrettyCell.swift
//  HG_DUZB
//
//  Created by day-day-Smile on 2017/12/28.
//  Copyright © 2017年 day-day-Smile. All rights reserved.
//

import UIKit
import Kingfisher

class HGPrettyCell: HGBaseCell {

    /// MARK: - 定义数据属性
    @IBOutlet weak var cityBtn: UIButton!
    
    /// MARK: - 定义数据模型
   override var anchor:HGAnchorModel? {
        /// 监听属性改变
        didSet{
            // 0. 将属性传给父类
            super.anchor = anchor
            // 3.城市
            cityBtn.setTitle(anchor?.anchor_city, for: .normal)
           
        }
    }

}
