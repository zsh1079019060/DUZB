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
    
    private lazy var pageTitleView:HGPageTitleView = {
        let titleFrame = CGRect.init(x: 0, y: kStatusBarH+kNavigationBarH, width: SCREEN_WIDTH, height: kTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = HGPageTitleView(frame: titleFrame, titles: titles)
        
        return titleView
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
