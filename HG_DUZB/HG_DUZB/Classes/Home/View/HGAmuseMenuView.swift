//
//  HGAmuseMenuView.swift
//  HG_DUZB
//
//  Created by day-day-Smile on 2018/1/14.
//  Copyright © 2018年 day-day-Smile. All rights reserved.
//

import UIKit
private let kAmuseViewCell = "kAmuseViewCell"

class HGAmuseMenuView: UIView {
    // MARK: 定义属性
    var groups:[HGAnchorGroup]?{
        didSet{
            collectionView.reloadData()
        }
    }
    
    // MARK: 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = .init(rawValue: 0)
        
        collectionView.register(UINib.init(nibName: "HGAmuseMenuViewCell", bundle: nil), forCellWithReuseIdentifier: kAmuseViewCell)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        
    }
}

// MARK: - HGAmuseMenuView
extension HGAmuseMenuView {
    class func amuseMenuView() -> HGAmuseMenuView {
        return Bundle.main.loadNibNamed("HGAmuseMenuView", owner: nil, options: nil)?.first as! HGAmuseMenuView
    }
}

// MARK: - UICollectionViewDataSource
extension HGAmuseMenuView:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if groups == nil  {
            return 0
        }
        /// 根据显示个数 计算 页数
        let pageNum = (groups!.count - 1) / 8 + 1
        pageControl.numberOfPages = pageNum
        return pageNum
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let amuseViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: kAmuseViewCell, for: indexPath) as! HGAmuseMenuViewCell
        setupCellDataWithCell(cell: amuseViewCell, indexPath: indexPath)
        return amuseViewCell
    }
    
    func setupCellDataWithCell(cell:HGAmuseMenuViewCell,indexPath:IndexPath) {
        /// 0页：0 ~ 7
        /// 1页：8 ~ 15
        /// 2页：16 ~ 23
        /// 1.取出起始位置&终点位置
        let starIndex = indexPath.item * 8
        var endIndex = (indexPath.item + 1) * 8 - 1
        
        /// 2.判断越界问题
        if endIndex > groups!.count - 1 {
            endIndex = groups!.count - 1
        }
        
        /// 3.取出数据，并且赋值给cell
        cell.groups = Array(groups![starIndex...endIndex])
    }
}


extension HGAmuseMenuView:UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.width)
    }
}
