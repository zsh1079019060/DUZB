//
//  HGBaseCell.swift
//  HG_DUZB
//
//  Created by day-day-Smile on 2018/1/3.
//  Copyright © 2018年 day-day-Smile. All rights reserved.
//

import UIKit

class HGBaseCell: UICollectionViewCell {
    
    /// MARK: - 定义数据属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var nickNameLabel: UILabel!
    /// MARK: - 定义数据模型
    var anchor:HGAnchorModel?{
        didSet{
            // 0. 交验 anchor 是否有值
            guard let anchor = anchor else {return}
            // 1.判断是否大于 10000
            var onlineStr:String = ""
            
            if anchor.online >= 10000 {
                onlineStr = "\(anchor.online / 10000)万在线"
            }else{
                onlineStr = "\(anchor.online)在线"
            }
            onlineBtn.setTitle(onlineStr, for: .normal)
            // 2.昵称显示
            nickNameLabel.text = anchor.nickname
            // 3.图片
            let iconUrl = URL.init(string: anchor.vertical_src)
            iconImageView.kf.setImage(with: iconUrl)
            
        }
    }
}
