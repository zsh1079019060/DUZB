//
//  HGFunnyViewController.swift
//  HG_DUZB
//
//  Created by day-day-Smile on 2018/1/14.
//  Copyright © 2018年 day-day-Smile. All rights reserved.
//

import UIKit
private let kTopMargin : CGFloat = 8

class HGFunnyViewController: HGBaseViewController {

    override func setupUI() {
        super.setupUI()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize.zero
        collectionView.contentInset = UIEdgeInsets(top: kTopMargin, left: 0, bottom: 0, right: 0)
        
    }
}

// MARK: - <#Description#>
extension HGFunnyViewController{
    
}
