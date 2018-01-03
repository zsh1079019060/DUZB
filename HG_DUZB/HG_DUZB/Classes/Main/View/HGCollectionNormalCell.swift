//
//  HGCollectionNormalCell.swift
//  HG_DUZB
//
//  Created by day-day-Smile on 2017/12/27.
//  Copyright © 2017年 day-day-Smile. All rights reserved.
//

import UIKit

class HGCollectionNormalCell: HGBaseCell {

    /// MARK: - 定义数据属性
    @IBOutlet weak var roomLabel: UILabel!
    
    /// MARK: - 定义数据模型
    override var anchor:HGAnchorModel? {
        /// 监听属性改变
        didSet{
            // 0. 将属性传给父类
            super.anchor = anchor
            
            // 4.房间 
            roomLabel.text = anchor?.room_name
        }
    }
    

}
