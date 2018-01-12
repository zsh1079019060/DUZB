//
//  HGAmuseViewController.swift
//  HG_DUZB
//
//  Created by day-day-Smile on 2018/1/12.
//  Copyright © 2018年 day-day-Smile. All rights reserved.
//

import UIKit

private let kItemMargin:CGFloat = 10
private let kItemW = (SCREEN_WIDTH - kItemMargin * 3)/2
private let KItemH = (kItemW * 3)/4
private let KPrettyItemH = (kItemW * 4)/3
private let kNormalCell = "kNormalCell"
private let kPrettyCell = "kPrettyCell"
private let kCycleViewH = SCREEN_WIDTH * 3 / 8
private let kGameViewH: CGFloat = 90
/// 组头
private let kHeaderViewH:CGFloat = 50
private let kHeaderView = "kHeaderView"

class HGAmuseViewController: UIViewController {
    
    
    fileprivate lazy var amuseVM:HGAmuseViewModel = HGAmuseViewModel()
    /// MARK : 懒加载
    fileprivate lazy var collectionView:UICollectionView = { [unowned self] in
        /// 1. 创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: KItemH)
        ///
        layout.minimumLineSpacing = 0
        /// item 之间的间距
        layout.minimumInteritemSpacing = kItemMargin
        
        /// 设置组头
        layout.headerReferenceSize = CGSize(width: SCREEN_WIDTH, height: kHeaderViewH)
        
        /// 设置内边距
        layout.sectionInset = UIEdgeInsetsMake(0, kItemMargin, 0, kItemMargin)
        /// 2. 创建collectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        /// 设置 collectionView 内边距拉伸 (滚动到最后显示不全 )
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        collectionView.backgroundColor = UIColor.white
        /// 注册cellID
        collectionView.register(UINib(nibName: "HGCollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCell)
        collectionView.register(UINib(nibName: "HGPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCell)
        
        /// 注册头部id
        collectionView.register(UINib(nibName: "HGCollectionHeaderView", bundle: nil) , forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderView)
        
        return collectionView
    }()
    
    /// MARK : 构造函数
    override func viewDidLoad() {
        super.viewDidLoad()
        /// 设置UI
        setupUI()
        loadData()
    }

}

// MARK: - 设置UI界面
extension HGAmuseViewController{
    func setupUI() {
        view.addSubview(collectionView)
    }
}

// MARK: - 请求数据
extension HGAmuseViewController{
    fileprivate func loadData() {
        amuseVM.loadAmuseData {
            self.collectionView.reloadData()
        }
    }
}

// MARK: -UICollectionViewDelegate和UICollectionViewDataSource实现方法
extension HGAmuseViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return amuseVM.anchorGroup.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return amuseVM.anchorGroup[section].anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCell, for: indexPath) as! HGCollectionNormalCell
        
        cell.anchor = amuseVM.anchorGroup[indexPath.section].anchors[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        /// 取出headerView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderView, for: indexPath) as! HGCollectionHeaderView
        /// 给headerView设置 数据
        headerView.group = amuseVM.anchorGroup[indexPath.section]
        
        return headerView
    }
}


