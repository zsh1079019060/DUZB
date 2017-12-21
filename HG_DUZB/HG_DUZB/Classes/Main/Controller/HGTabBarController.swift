//
//  HGTabBarController.swift
//  HG_DUZB
//
//  Created by day-day-Smile on 2017/12/19.
//  Copyright © 2017年 day-day-Smile. All rights reserved.
//

import UIKit

class HGTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let home = HGHomeController()
        addChildViewController(home, title: "首页", image: "tabHome", select_image: "tabHomeHL")
        let live = HGLiveController()
        addChildViewController(live, title: "首页", image: "tabLiving", select_image: "tabLivingHL")
        let follow = HGFollowController()
        addChildViewController(follow, title: "关注", image: "tabFocus", select_image: "tabFocusHL")
        let profile = HGProfileController()
        addChildViewController(profile, title: "我", image: "tabMine", select_image: "tabMineHL")
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func addChildViewController(_ childController: UIViewController,title:String,image:String,select_image:String) {
        
        /// 1. 设置文字
        childController.title = title
        
        /// 2. 设置图片 - 默认 和 高亮
        childController.tabBarItem.image = UIImage.init(named: image)?.withRenderingMode(.alwaysOriginal)
        childController.tabBarItem.selectedImage = UIImage.init(named: select_image)?.withRenderingMode(.alwaysOriginal)
        
        /// 3. 设置文字颜色 和 选中颜色
///     childController.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor:UIColor.brown], for: .normal)
       childController.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor:UIColor.orange], for: .selected)
        childController.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.font:UIFont.systemFont(ofSize: 13)], for: .normal)
        
        /// 3.1 设置每个控制器背景颜色
        childController.view.backgroundColor = UIColor.white
        
        /// 4. 把 控制器添加导航控制器
        let nav = HGNavigationController(rootViewController: childController  )
        
        /// 5. 把 导航控制器 添加到TabBar上
        self.addChildViewController(nav)
        
    }
    
}
