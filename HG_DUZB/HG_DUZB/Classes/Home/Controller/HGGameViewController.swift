//
//  HGGameViewController.swift
//  HG_DUZB
//
//  Created by day-day-Smile on 2018/1/5.
//  Copyright © 2018年 day-day-Smile. All rights reserved.
//

import UIKit
private let kEdgeMargin:CGFloat = 10
private let kItemW:CGFloat = (SCREEN_WIDTH - 2 * kEdgeMargin) / 3
private let kItemH:CGFloat = kItemW*6/5
private let gameCellId = "gameCellId"
private let kHeaderID = "kHeaderID"
private let kHeaderViewH:CGFloat = 50
class HGGameViewController: UIViewController {
    
    fileprivate lazy var gameVM:HGGameViewModel = HGGameViewModel()
    /// MARK: 懒加载属性
    fileprivate lazy var collectionView:UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: kEdgeMargin, bottom: 0, right: kEdgeMargin)
        /// 设置组头
        layout.headerReferenceSize = CGSize(width: SCREEN_WIDTH, height: kHeaderViewH)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.register(UINib.init(nibName: "HGCollectionGameCell", bundle: nil), forCellWithReuseIdentifier: gameCellId)
        collectionView.register(UINib(nibName: "HGCollectionHeaderView", bundle: nil) , forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderID)
        
        collectionView.backgroundColor = UIColor.white
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        collectionView.dataSource = self
        return collectionView
    }()

    
    /// 系统调用函数
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }

}
// MARK: - 设置UI界面
extension HGGameViewController{
    /// 设置UI界面
    fileprivate func setupUI() {
        view.addSubview(collectionView)
    }
}
// MARK: - 设置数据
extension HGGameViewController{
    /// 设置数据
    fileprivate func loadData() {
        gameVM.loadAllGameData {
            self.collectionView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDataSource实现数据源
extension HGGameViewController:UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameVM.gameModels.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: gameCellId, for: indexPath) as? HGCollectionGameCell
        
        cell?.baseGameModel = gameVM.gameModels[indexPath.item]
         
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderID, for: indexPath) as? HGCollectionHeaderView
        
        header?.titleLabel.text = "全部"
        header?.iconImageView.image = UIImage(named: "Img_orange")
        header?.moreLine.isHidden = true
        return header!
    }
}
