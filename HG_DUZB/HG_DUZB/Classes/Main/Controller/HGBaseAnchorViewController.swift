//
//  HGBaseViewController.swift
//  HG_DUZB
//
//  Created by day-day-Smile on 2018/1/13.
//  Copyright © 2018年 day-day-Smile. All rights reserved.
//

import UIKit
 let kItemMargin:CGFloat = 10
 let kItemW = (SCREEN_WIDTH - kItemMargin * 3)/2
 let KItemH = (kItemW * 3)/4
 let KPrettyItemH = (kItemW * 4)/3
 let kNormalCell = "kNormalCell"
 let kPrettyCell = "kPrettyCell"
 let kCycleViewH = SCREEN_WIDTH * 3 / 8
 let kGameViewH: CGFloat = 90
/// 组头
 let kHeaderViewH:CGFloat = 50
 let kHeaderView = "kHeaderView"

class HGBaseAnchorViewController: HGBaseViewController {

    // MARK:懒加载
    var baseVM:HGBaseViewModel!
    /// MARK : 懒加载
    lazy var collectionView:UICollectionView = { [unowned self] in
        /// 1. 创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: KItemH)
        ///
        layout.minimumLineSpacing = 0
        /// item 之间的间距
        layout.minimumInteritemSpacing = kItemMargin
        
        /// 设置组头
        layout.headerReferenceSize = CGSize(width: SCREEN_WIDTH, height: kHeaderViewH)
        
        /// 设置内边距
        layout.sectionInset = UIEdgeInsetsMake(0, kItemMargin, 0, kItemMargin)
        /// 2. 创建collectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        /// 设置 collectionView 内边距拉伸 (滚动到最后显示不全 )
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        collectionView.backgroundColor = UIColor.white
        /// 注册cellID
        collectionView.register(UINib(nibName: "HGCollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCell)
        collectionView.register(UINib(nibName: "HGPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCell)
        
        /// 注册头部id
        collectionView.register(UINib(nibName: "HGCollectionHeaderView", bundle: nil) , forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderView)
        
        return collectionView
        }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
    // MARK: - 设置UI界面
   override func setupUI() {
    /// 1.给父类中内容view的引用进行赋值
    content = collectionView
    /// 2.添加collectionview
    view.addSubview(collectionView)
    /// 3.调用super.setupUI()
    super.setupUI()
    
    }
    // MARK: - 请求数据
    func loadData() {
        
    }
    
}

// MARK: -UICollectionViewDelegate和UICollectionViewDataSource实现方法
extension HGBaseAnchorViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return baseVM.ancherGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return baseVM.ancherGroups[section].anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCell, for: indexPath) as! HGCollectionNormalCell
        
        cell.anchor = baseVM.ancherGroups[indexPath.section].anchors[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        /// 取出headerView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderView, for: indexPath) as! HGCollectionHeaderView
        
        /// 给headerView设置 数据
        headerView.group = baseVM.ancherGroups[indexPath.section]
        
        return headerView
    }

    // MARK: 点击事件
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        /// 取出对应的主播信息
        let anchor = baseVM.ancherGroups[indexPath.section].anchors[indexPath.item]
        
        /// 判断是否是秀场还是普通房间
        anchor.isVertical == 0 ?  pushNormalRoomVC() : presntShowRoomVC()
        
    }
    
    private func presntShowRoomVC(){
        /// 创建ShowRoomVC
        let showRoomVC = HGRoomShowViewController()
        /// 以Model方式弹出
        present(showRoomVC, animated: true, completion: nil)
        
    }
    private func pushNormalRoomVC(){
        /// 创建NormalRoomVC
        let normalRoomVc = HGRoomNormalViewController()
        /// 
        navigationController?.pushViewController(normalRoomVc, animated: true)
        
    }
}
