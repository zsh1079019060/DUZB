//
//  HGHomeController.swift
//  HG_DUZB
//
//  Created by day-day-Smile on 2017/12/19.
//  Copyright © 2017年 day-day-Smile. All rights reserved.
//

import UIKit

private let kTitleViewH:CGFloat = 40

class HGHomeController: UIViewController {
    
    /// MARK: - 懒加载属性
    private lazy var pageTitleView:HGPageTitleView = { [weak self] in
        let titleFrame = CGRect.init(x: 0, y: kStatusBarH+kNavigationBarH, width: SCREEN_WIDTH, height: kTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩","视频"]
        let titleView = HGPageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    
    
    
    private lazy var pageContentView:HGPageContentView = { [weak self] in
        /// 1. 确定内容的frame
        let contentH = kStatusBarH + kNavigationBarH + kTitleViewH + kTabBarH
        let contentY = kStatusBarH + kNavigationBarH + kTitleViewH
        let contentFrame = CGRect(x: 0, y: contentY, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - contentH)
        /// 2. 循环创建控制器
        var childVcs = [UIViewController]()
        childVcs.append(HGRecommendController())
        childVcs.append(HGGameViewController())
        childVcs.append(HGAmuseViewController())
        for _ in 0..<5 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor.init(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        
        let pageContentView = HGPageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        pageContentView.delegate = self
        return pageContentView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

}

// MARK: - 设置UI界面
extension HGHomeController{
    
    /// 设置UI界面
    fileprivate func setupUI(){
        /// 1. 添加导航栏
        setNavigtionBar()
        /// 2. 添加TtitleView
        view.addSubview(pageTitleView)
        
        /// 3. 添加contentView
        view.addSubview(pageContentView)
        
    }
    
    /// 设置导航栏
    fileprivate func setNavigtionBar(){
        
        self.navigationItem.title = ""
        
        /// 1. 自定义返回按钮 - 设置左边item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        /// 2. 设置右边的item
        let size = CGSize(width: 35, height: 35)
        
        let historyItem = UIBarButtonItem(imageName: "image_my_history", heightImageName: "Image_my_history_click", size: size)
        
        let searchItem = UIBarButtonItem(imageName: "btn_search", heightImageName: "btn_search_clicked", size: size)
        
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", heightImageName: "Image_scan_click", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
    }
    
}

// MARK: - 实现 代理 HGPageTitleViewDelegate
extension HGHomeController : HGPageTitleViewDelegate{
    
    func pageTtileView(titleView: HGPageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
  
}

// MARK: - HGPageContentViewDelegate
extension HGHomeController : HGPageContentViewDelegate{
    func pageContentView(contentView: HGPageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
