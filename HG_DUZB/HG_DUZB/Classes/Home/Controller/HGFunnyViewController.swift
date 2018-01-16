//
//  HGFunnyViewController.swift
//  HG_DUZB
//
//  Created by day-day-Smile on 2018/1/14.
//  Copyright © 2018年 day-day-Smile. All rights reserved.
//

import UIKit
private let kTopMargin : CGFloat = 8

class HGFunnyViewController: HGBaseAnchorViewController {
    
    // MARK: 懒加载
    fileprivate lazy var funnyVM:HGFunnyViewModel = HGFunnyViewModel()

    override func setupUI() {
        super.setupUI()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize.zero
        collectionView.contentInset = UIEdgeInsets(top: kTopMargin, left: 0, bottom: 0, right: 0)
        
    }
    override func loadData() {
        /// 给父类中的viewModel进行赋值
        baseVM = funnyVM
        
        
        funnyVM.loadFunnyData {
            /// 1.刷新表格
            self.collectionView.reloadData()
            /// 2.数据请求完成
            self.loadDataFinished()
        }
    }
}
