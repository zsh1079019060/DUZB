//
//  HGRecommentCycleView.swift
//  HG_DUZB
//
//  Created by day-day-Smile on 2018/1/3.
//  Copyright © 2018年 day-day-Smile. All rights reserved.
//

import UIKit
private let collectionCell = "collectionCell"

class HGRecommentCycleView: UIView {
    
    /// 属性
    var cycleModels : [HGCycelModel]? {
        didSet{
            /// 刷新collectionView数据
            collectionView.reloadData()
            /// 设置pageControl
            pageControl.numberOfPages = cycleModels?.count ?? 0
            
        }
    }

    // MARK: - 属性
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        /// 不随父控件拉伸而拉伸 
        autoresizingMask = .init(rawValue: 0)
        /// 注册cell
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: collectionCell)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        /// 设置collectionViewlayout
        let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.itemSize = collectionView.bounds.size
        layout?.minimumLineSpacing = 0
        layout?.minimumInteritemSpacing = 0
        layout?.scrollDirection = .horizontal
        collectionView.isPagingEnabled = true
        
    }

}

// MARK: - 提供一个快速创建view的类方法 
extension HGRecommentCycleView {
    class func recommentCycleView() -> HGRecommentCycleView{
        return Bundle.main.loadNibNamed("HGRecommentCycleView", owner: nil, options: nil)?.first as! HGRecommentCycleView
    }
}

// MARK: - 实现数据源
extension HGRecommentCycleView :UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cycleModels?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  collectionCell, for: indexPath)
        /// 获取数据
        let cycleModel = cycleModels![indexPath.item]
        
        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.red : UIColor.green
        return cell
    }
}
