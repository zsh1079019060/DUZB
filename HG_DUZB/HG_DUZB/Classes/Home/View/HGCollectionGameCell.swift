//
//  HGCollectionGameCell.swift
//  HG_DUZB
//
//  Created by day-day-Smile on 2018/1/5.
//  Copyright © 2018年 day-day-Smile. All rights reserved.
//

import UIKit

class HGCollectionGameCell: UICollectionViewCell {
    
    /// 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var group:HGAnchorGroup?{
        didSet{ 
            titleLabel.text = group?.tag_name
            let url = URL.init(string: group?.icon_url ?? "")

            iconImageView.kf.setImage(with: url, placeholder: UIImage.init(named: "home_more_btn"))
            
        }
    }
    
    override func awakeFromNib() {
        super.layoutSubviews()
        iconImageView.layer.cornerRadius = 22.5
        iconImageView.layer.masksToBounds = true
    }
}
