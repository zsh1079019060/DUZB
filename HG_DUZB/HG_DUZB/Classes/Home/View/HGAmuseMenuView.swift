//
//  HGAmuseMenuView.swift
//  HG_DUZB
//
//  Created by day-day-Smile on 2018/1/14.
//  Copyright © 2018年 day-day-Smile. All rights reserved.
//

import UIKit

class HGAmuseMenuView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = .init(rawValue: 0)
    }
}

extension HGAmuseMenuView {
    class func amuseMenuView() -> HGAmuseMenuView {
        return Bundle.main.loadNibNamed("HGAmuseMenuView", owner: nil, options: nil)?.first as! HGAmuseMenuView
    }
}
