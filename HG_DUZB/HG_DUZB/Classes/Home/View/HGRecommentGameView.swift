//
//  HGRecommentGameView.swift
//  HG_DUZB
//
//  Created by day-day-Smile on 2018/1/5.
//  Copyright © 2018年 day-day-Smile. All rights reserved.
//

import UIKit
private let gameCellId = "gameCellId"

class HGRecommentGameView: UIView {
    
    /// 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    
    /// 系统回调函数
    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = .init(rawValue: 0)
        
        ///
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: gameCellId)
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
        return 6
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "gameCellId", for: indexPath)
        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.red : UIColor.gray
        return cell
    }
}
