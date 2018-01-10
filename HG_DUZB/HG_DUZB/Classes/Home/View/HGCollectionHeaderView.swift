//
//  HGCollectionHeaderView.swift
//  HG_DUZB
//
//  Created by day-day-Smile on 2017/12/27.
//  Copyright © 2017年 day-day-Smile. All rights reserved.
//

import UIKit

class HGCollectionHeaderView: UICollectionReusableView {

    //MARK:- 设置属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var moreLine: UIButton!
    //MARK:- 定义模型属性
    var group:HGAnchorGroup? {
        didSet{
           
            titleLabel.text = group?.tag_name
        
            iconImageView.image = UIImage(named:group?.icon_name ?? "home_header_normal")
        }
    }
}

extension HGCollectionHeaderView {
    class func collectionHeaderView() -> HGCollectionHeaderView {
        return Bundle.main.loadNibNamed("HGCollectionHeaderView", owner: nil, options: nil)?.first as! HGCollectionHeaderView
    }
}
