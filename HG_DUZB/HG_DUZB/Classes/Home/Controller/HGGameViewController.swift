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
private let kItemH:CGFloat = (SCREEN_WIDTH*4)/5
private let gameCellId = "gameCellId"
class HGGameViewController: UIViewController {
    
    /// MARK: 懒加载属性
    fileprivate lazy var collectionView:UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: kEdgeMargin, bottom: 0, right: kEdgeMargin)
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.register(UINib.init(nibName: "HGCollectionGameCell", bundle: nil), forCellWithReuseIdentifier: gameCellId)
        
        collectionView.dataSource = self
        return collectionView
    }()

    
    ///
    override func viewDidLoad() {
        super.viewDidLoad()
       
        view.addSubview(collectionView)
      
    }

}


extension HGGameViewController:UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: gameCellId, for: indexPath)
        cell.backgroundColor = UIColor.randomColor()
        return cell
    }
}
