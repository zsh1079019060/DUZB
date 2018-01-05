//
//  HGRecommentGameView.swift
//  HG_DUZB
//
//  Created by day-day-Smile on 2018/1/5.
//  Copyright © 2018年 day-day-Smile. All rights reserved.
//

import UIKit
private let gameCellId = "gameCellId"
private let kEdgeInsetsMargin :CGFloat = 10
class HGRecommentGameView: UIView {
    
    /// 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    
    var groups:[HGAnchorGroup]? {
        didSet{
            /// 不需要钱两组数据，移除
            groups?.remove(at: 0)
            groups?.remove(at: 0)

            /// 添加更多
            let moreGroups = HGAnchorGroup()
            moreGroups.tag_name = "更多"
            groups?.append(moreGroups)
            
            
            collectionView.reloadData()
        }
    }
    
    /// 系统回调函数
    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = .init(rawValue: 0)
        
        ///
        collectionView.register(UINib.init(nibName: "HGCollectionGameCell", bundle: nil), forCellWithReuseIdentifier: gameCellId)
        
        /// 内边距
        collectionView.contentInset = UIEdgeInsets(top: 0, left: kEdgeInsetsMargin, bottom: 0, right: kEdgeInsetsMargin)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.itemSize = CGSize(width: 80, height: 90)
        layout?.minimumLineSpacing = 0
        layout?.minimumInteritemSpacing = 0
        layout?.scrollDirection = .horizontal
    }

}

// MARK: - 快速创建方法
extension HGRecommentGameView{
    class func recommentGameView() -> HGRecommentGameView{
        return Bundle.main.loadNibNamed("HGRecommentGameView", owner: nil, options: nil)?.first as! HGRecommentGameView
    }
}

// MARK: - UICollectionViewDataSource数据源实现
extension HGRecommentGameView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "gameCellId", for: indexPath) as! HGCollectionGameCell
        
        cell.group = groups![indexPath.item]
        
//        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.red : UIColor.gray
        return cell
    }
}
