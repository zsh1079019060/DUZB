//
//  HGGameViewController.swift
//  HG_DUZB
//
//  Created by day-day-Smile on 2018/1/5.
//  Copyright © 2018年 day-day-Smile. All rights reserved.
//

import UIKit
private let kEdgeMargin:CGFloat = 10
private let hgItemW:CGFloat = (SCREEN_WIDTH - 2 * kEdgeMargin) / 3
private let kItemH:CGFloat = hgItemW*6/5
private let gameCellId = "gameCellId"
private let kHeaderID = "kHeaderID"
class HGGameViewController: UIViewController {
    
    fileprivate lazy var gameVM:HGGameViewModel = HGGameViewModel()
    /// MARK: 懒加载属性
    fileprivate lazy var collectionView:UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: hgItemW, height: kItemH)
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

    fileprivate lazy var topHeaderView : HGCollectionHeaderView = {
        let topHeaderView  = HGCollectionHeaderView.collectionHeaderView()
        topHeaderView.frame = CGRect(x: 0, y: -(kHeaderViewH+kGameViewH), width: SCREEN_WIDTH, height: kHeaderViewH)
        topHeaderView.iconImageView.image = UIImage(named: "Img_orange")
        topHeaderView.titleLabel.text = "常见"
        topHeaderView.moreLine.isHidden = true
        return topHeaderView
    }()
    
    fileprivate lazy var recommentView:HGRecommentGameView = {
        let recommentView = HGRecommentGameView.recommentGameView()
        recommentView.frame = CGRect(x: 0, y: -kGameViewH, width: SCREEN_WIDTH, height: kGameViewH)
        return recommentView
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
        /// 1.添加UICollectinView
        view.addSubview(collectionView)
        /// 2.添加顶部的HeaderView
        collectionView.addSubview(topHeaderView)
        
        collectionView.addSubview(recommentView)
        
        /// 3.设置CollectionView 的内边距 
        collectionView.contentInset = UIEdgeInsetsMake(kHeaderViewH+kGameViewH, 0, 0, 0)
        
    }
}
// MARK: - 设置数据
extension HGGameViewController{
    /// 设置数据
    fileprivate func loadData() {
        gameVM.loadAllGameData {
            self.collectionView.reloadData()
            
            var games = [HGBaseGameModel]()
            for i in 0..<6 {
                games.append(self.gameVM.gameModels[i])
            }
            
            self.recommentView.groups = games
            
            /// 简单方法
            /// self.recommentView.groups = Array(self.gameVM.gameModels[0..<10])
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
