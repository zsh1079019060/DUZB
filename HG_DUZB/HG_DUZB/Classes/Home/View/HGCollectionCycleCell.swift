//
//  HGCollectionCycleCell.swift
//  HG_DUZB
//
//  Created by day-day-Smile on 2018/1/3.
//  Copyright © 2018年 day-day-Smile. All rights reserved.
//

import UIKit
import Kingfisher

class HGCollectionCycleCell: UICollectionViewCell {
    
    // MARK: 属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var cycleModel:HGCycelModel?{
        didSet{
            
            titleLabel.text = cycleModel?.title
            
            let url = URL.init(string: cycleModel?.pic_url ?? "")
            iconImageView.kf.setImage(with: url)
            
        }
    }

}
