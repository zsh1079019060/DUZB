//
//  HGAmuseViewController.swift
//  HG_DUZB
//
//  Created by day-day-Smile on 2018/1/12.
//  Copyright © 2018年 day-day-Smile. All rights reserved.
//

import UIKit
private let kMenuViewH : CGFloat = 200
class HGAmuseViewController: HGBaseViewController {
    
    /// MARK: 懒加载
    fileprivate lazy var amuseVM:HGAmuseViewModel = HGAmuseViewModel()
    fileprivate lazy var menuView:HGAmuseMenuView = {
        let menuView = HGAmuseMenuView.amuseMenuView()
        menuView.frame = CGRect(x: 0, y: -kMenuViewH, width: SCREEN_WIDTH, height: kMenuViewH)
        menuView.backgroundColor = UIColor.randomColor()
        return menuView
    }()

    // MARK: - 请求数据
    override func loadData() {
        baseVM = amuseVM
        amuseVM.loadAmuseData {
            self.collectionView.reloadData()
        }
    }
    override func setupUI() {
        super.setupUI()
        collectionView.addSubview(menuView)
        collectionView.contentInset = UIEdgeInsets(top: kMenuViewH, left: 0, bottom: 0, right: 0)
    }
}




