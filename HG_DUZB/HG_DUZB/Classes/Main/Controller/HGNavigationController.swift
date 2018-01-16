//
//  HGNavigationController.swift
//  HG_DUZB
//
//  Created by day-day-Smile on 2017/12/19.
//  Copyright © 2017年 day-day-Smile. All rights reserved.
//

import UIKit

class HGNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {

        // 如果不是栈低的控制器才需要隐藏，跟控制器不需要处理
        if childViewControllers.count > 0 {
            
            // 隐藏底部的TabBar
            viewController.hidesBottomBarWhenPushed = true
        
        }
        super.pushViewController(viewController, animated: animated)
        
    }
}
