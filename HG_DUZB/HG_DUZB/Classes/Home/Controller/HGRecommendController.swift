//
//  HGRecommendController.swift
//  HG_DUZB
//
//  Created by day-day-Smile on 2017/12/27.
//  Copyright © 2017年 day-day-Smile. All rights reserved.
//

import UIKit

class HGRecommendController: HGBaseAnchorViewController {
    
    private lazy var recommendVM:HGRecommentViewModel = HGRecommentViewModel()
    
    // MARK: - 懒加载
    /// 轮播图
    fileprivate lazy var recommentCycleView:HGRecommentCycleView = {
        let recommentCycleView = HGRecommentCycleView.recommentCycleView()
        // 设置frame
        recommentCycleView.frame = CGRect.init(x: 0, y: -(kCycleViewH+kGameViewH), width: SCREEN_WIDTH, height: kCycleViewH)
        return recommentCycleView
    }()
    /// 游戏
    fileprivate lazy var recommentGameView:HGRecommentGameView = {
        let recommentGameView = HGRecommentGameView.recommentGameView()
        // 设置frame
        recommentGameView.frame = CGRect.init(x: 0, y: -kGameViewH, width: SCREEN_WIDTH, height: kGameViewH)
        return recommentGameView
    }()
    
    // MARK: - 设置UI界面
    override func setupUI() {
        
        /// 1. 先调用super.setupUI
        super.setupUI()
        
        /// 2.将recommentCycleView添加到 collectionView中
        collectionView.addSubview(recommentCycleView)
        
        /// 3.添加游戏
        collectionView.addSubview(recommentGameView)
        
        /// 4.设置内边距
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH+kGameViewH, left: 0, bottom: 0, right: 0)
        
    }
    // MARK: - 请求数据
    override func loadData(){
        
        /// 0.给父类中的viewModel进行赋值
        baseVM = recommendVM
        
        /// 1.请求 推荐数据
        recommendVM.requestData {
            // 1.展示推荐数据
            self.collectionView.reloadData()
            
            /// 2 拿到数据
            var groups = self.recommendVM.ancherGroups
            
            /// 2.1 不需要钱两组数据，移除
            groups.remove(at: 0)
            groups.remove(at: 0)
            
            /// 2.2 添加更多
            let moreGroups = HGAnchorGroup()
            moreGroups.tag_name = "更多"
            groups.append(moreGroups)
            
            // 2.3 将数据给game
            self.recommentGameView.groups = groups
            
            /// 数据请求完成
            self.loadDataFinished()
        }
        /// 2.请求 轮播数据
        recommendVM.requeseCycleData {
            self.recommentCycleView.cycleModels = self.recommendVM.cycleModel
        }
    }
    
}

extension HGRecommendController:UICollectionViewDelegateFlowLayout{
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCell, for: indexPath) as! HGPrettyCell
            cell.anchor = recommendVM.ancherGroups[indexPath.section].anchors[indexPath.item]
            return cell
        }else{
            return super.collectionView(collectionView, cellForItemAt: indexPath)
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1{
           return CGSize(width: kItemW, height: KPrettyItemH)
        }
        return CGSize(width: kItemW, height: KItemH)
        
    }
    
}
