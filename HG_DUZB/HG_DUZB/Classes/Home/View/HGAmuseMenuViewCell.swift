//
//  HGAmuseMenuViewCell.swift
//  HG_DUZB
//
//  Created by day-day-Smile on 2018/1/14.
//  Copyright © 2018年 day-day-Smile. All rights reserved.
//

import UIKit
private let kGameCellID = "kGameCellID"

class HGAmuseMenuViewCell: UICollectionViewCell {

    // MARK: 数组模型
    var groups:[HGAnchorGroup]?
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(UINib.init(nibName: "HGCollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = collectionView.collectionViewLayout  as! UICollectionViewFlowLayout
        let itemW = collectionView.bounds.width / 4
        let itemH = collectionView.bounds.height / 2
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: itemW, height: itemH)
        
    }

}


extension HGAmuseMenuViewCell:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! HGCollectionGameCell
        cell.clipsToBounds = true
        cell.baseGameModel = groups?[indexPath.item]
        return cell
    }
}
