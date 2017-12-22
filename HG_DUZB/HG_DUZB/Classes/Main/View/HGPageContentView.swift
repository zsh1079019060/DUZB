//
//  HGPageContentView.swift
//  HG_DUZB
//
//  Created by day-day-Smile on 2017/12/22.
//  Copyright © 2017年 day-day-Smile. All rights reserved.
//

import UIKit

private let  contentCellId = "contentCellId"

class HGPageContentView: UIView {
    
    /// MARK: - 定义属性
    fileprivate var childVcs:[UIViewController]
    /// 容易形成循环引用 weak 修饰 ？类型
    fileprivate weak var parentViewController:UIViewController?
    
    /// 懒加载
    lazy var collectionView:UICollectionView = { [weak self] in
        /// 设置 collectionView，必须先设置 layout
        let layout = UICollectionViewFlowLayout()
        /// 闭包里面不能用self
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        /// 创建UICollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contentCellId)
        return collectionView
    }()
    
    /// 构造函数
    init(frame: CGRect,childVcs:[UIViewController],parentViewController:UIViewController?) {
        
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        
        super.init(frame: frame)
        
        /// 设置UI
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - 设置UI
extension HGPageContentView{
    
    func setupUI(){
        /// 1.先把所有的自控制添加进来
        for childVc in childVcs {
            parentViewController?.addChildViewController(childVc)
        }
        // 2.用collectionView，用于cell中存放控制器view
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

// MARK: - 遵守UICollectionViewDataSource
extension HGPageContentView:UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        /// 1. 创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCellId, for: indexPath)
        /// 2. 给cell设置内容
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        return cell
    }
}

// MARK: - 实现点击titleLabel 控制器进行滚动 到 对应的界面 
extension HGPageContentView {
    func setCurrentIndex(currentIndex:Int) {
        
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        
        collectionView.setContentOffset(CGPoint.init(x: offsetX, y: 0), animated: false)
        
    }
}
