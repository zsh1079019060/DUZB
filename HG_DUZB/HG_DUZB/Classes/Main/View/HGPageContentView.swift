//
//  HGPageContentView.swift
//  HG_DUZB
//
//  Created by day-day-Smile on 2017/12/22.
//  Copyright © 2017年 day-day-Smile. All rights reserved.
//

import UIKit

private let  contentCellId = "contentCellId"

protocol HGPageContentViewDelegate : class {
    func pageContentView(contentView:HGPageContentView,progress:CGFloat,sourceIndex:Int,targetIndex:Int)
}

class HGPageContentView: UIView {
    
    /// MARK: - 定义属性
    fileprivate var childVcs:[UIViewController]
    /// 容易形成循环引用 weak 修饰 ？类型
    fileprivate weak var parentViewController:UIViewController?
    /// 获取当前偏移量
    fileprivate var startOffsetX:CGFloat = 0
    /// 判断是否点击滚动
    fileprivate var isForbidScorllDelegate:Bool = false
    
    weak var delegate:HGPageContentViewDelegate?
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
        collectionView.delegate = self
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

// MARK: - 遵守UICollectionViewDelegate
extension HGPageContentView:UICollectionViewDelegate {
    /// 0.首先拿到当前要拖拽的那一个item
    /// 开始拖拽
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        isForbidScorllDelegate = false
        
        startOffsetX = scrollView.contentOffset.x
        
    }
    
    /// 实现scrollView滚动方法
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        /// 判断是否是点击事件 
        if isForbidScorllDelegate {return}
        
        /// 1.获取需要的数据
        /// 获取滚动的 - 进度
        var progress:CGFloat = 0
        /// 获取源title - 源来的下标
        var sourceIndex:Int = 0
        /// 获取目标title - 当前下标
        var targetIndex:Int = 0
        
        /// 判断是左滑还是右滑
        /// 如果获取的偏移量大就是  右滑
        let currentOffset = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        
        /// 滚动的偏移量大于之前的偏移量 - 右滑
        if currentOffset > startOffsetX {
            /// FIXMI: - 警告
            /// 1. 进度 - floor(x) 即取不大于x的最大整数
            progress = currentOffset / scrollViewW - floor(currentOffset / scrollViewW)
            /// 2. 源 sourceIndex
            sourceIndex = Int(currentOffset / scrollViewW)
            /// 3. 目标 targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            
            /// 4. 如果完全滑过去
            if currentOffset - startOffsetX == scrollViewW{
                progress = 1
                targetIndex = sourceIndex
            }
            /// 或者 - 左滑
        }else{
            progress = 1 - (currentOffset / scrollViewW - floor(currentOffset / scrollViewW))
            
            targetIndex = Int(currentOffset / scrollViewW)
            
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count - 1
            }
        }
        
        /// 将 progress、targetIndex、sourceIndex传递给titleView
        print("progress\(progress)---targetIndex\(targetIndex)--sourceIndex\(sourceIndex)")
        
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
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
        
        /// 记录需要进行执行代理方法
        isForbidScorllDelegate = true
        
        ///
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        
        collectionView.setContentOffset(CGPoint.init(x: offsetX, y: 0), animated: false)
        
    }
}
