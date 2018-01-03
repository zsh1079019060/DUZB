//
//  HGRecommendController.swift
//  HG_DUZB
//
//  Created by day-day-Smile on 2017/12/27.
//  Copyright © 2017年 day-day-Smile. All rights reserved.
//

import UIKit

private let kItemMargin:CGFloat = 10
private let kItemW = (SCREEN_WIDTH - kItemMargin * 3)/2
private let KItemH = (kItemW * 3)/4
private let KPrettyItemH = (kItemW * 4)/3
private let kNormalCell = "kNormalCell"
private let kPrettyCell = "kPrettyCell"
/// 组头
private let kHeaderViewH:CGFloat = 50
private let kHeaderView = "kHeaderView"
class HGRecommendController: UIViewController {
    
    private lazy var recommendVM:HGRecommentViewModel = HGRecommentViewModel()
    
    // MARK: - 懒加载
    fileprivate lazy var collectionView:UICollectionView = { [unowned self] in
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
        
        view.backgroundColor = UIColor.purple
        
        setupUI()
        
        /// 2
        loadData()
    }
}

// MARK: - 设置UI界面
extension HGRecommendController {
    fileprivate func setupUI(){
        /// 1. collectionView添加到view上
        view.addSubview(collectionView)
   
    }
}

// MARK: - 请求数据
extension HGRecommendController {
    fileprivate func loadData(){
        recommendVM.requestData {
            self.collectionView.reloadData()
        }
    }
}


// MARK: - 遵守UICollectionViewDataSource协议
extension HGRecommendController:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return  recommendVM.ancherGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = recommendVM.ancherGroups[section]
        
        return group.anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        /// 取出模型
        let group = recommendVM.ancherGroups[indexPath.section]
        /// 取出每个主播的模型
        let anchor = group.anchors[indexPath.item]
        
        var  cell : HGBaseCell?
        
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCell, for: indexPath) as? HGPrettyCell
        }else{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCell, for: indexPath) as? HGCollectionNormalCell
        }
        cell?.anchor = anchor
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        /// 1.取出section的HeaderView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderView, for: indexPath) as? HGCollectionHeaderView
        
        headerView?.group = self.recommendVM.ancherGroups[indexPath.section]
        
        return headerView!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: KPrettyItemH
            )
        }else{
            return CGSize(width: kItemW, height: KItemH)
        }
    }
}
