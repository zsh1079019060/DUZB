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
    /// 定时器
    var timer:Timer?
    
    /// 属性
    var cycleModels : [HGCycelModel]? {
        didSet{
            /// 刷新collectionView数据
            collectionView.reloadData()
            /// 设置pageControl
            pageControl.numberOfPages = cycleModels?.count ?? 0
            
            /// 默认滚到中间某个位置
            let indexPath = NSIndexPath.init(item: (cycleModels?.count ?? 0)*10, section: 0)
            collectionView.scrollToItem(at: indexPath as IndexPath, at: .left, animated: false)
            
            /// 移除定时器
            removeTimer()
            setTimer()
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
        collectionView.register(UINib.init(nibName: "HGCollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: collectionCell)
        
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
        return (cycleModels?.count ?? 0)*10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  collectionCell, for: indexPath) as? HGCollectionCycleCell
        /// 获取数据
        cell?.cycleModel = cycleModels![indexPath.item % (cycleModels?.count)!]
        
        return cell!
    }
}

// MARK: - 实现代理方法
extension HGRecommentCycleView:UICollectionViewDelegate{
 
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        /// 获取偏移量
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        /// 计算pageControl.currentPage
        self.pageControl.currentPage = Int(offsetX / scrollView.bounds.width) % (cycleModels?.count ?? 1)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeTimer()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        setTimer()
    }
}

// MARK: - 定时器
extension HGRecommentCycleView {
    fileprivate func setTimer(){
        timer = Timer(timeInterval: 3.0, target: self, selector: #selector(scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .commonModes)
        
    }
    
    fileprivate func removeTimer(){
        timer?.invalidate()
        timer = nil
    }
    
    @objc func scrollToNext(){
        /// 获取滚动的偏移量
        let currenOffsetX = collectionView.contentOffset.x
        let offsetX = currenOffsetX + collectionView.bounds.width
        
        /// 滚动的位置
        collectionView.setContentOffset(CGPoint.init(x: offsetX, y: 0), animated: true)
        
        
    }
}
