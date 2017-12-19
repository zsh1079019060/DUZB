//
//  AppDelegate.swift
//  HG_DUZB
//
//  Created by day-day-Smile on 2017/12/13.
//  Copyright © 2017年 day-day-Smile. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        /// 实例化Window
        self.window = UIWindow(frame: UIScreen.main.bounds)
        /// 设置tabBar控制器 
        let tabBarController = HGTabBarController()
        self.window?.rootViewController = tabBarController
        /// 让其显示
        self.window?.makeKeyAndVisible()
        /// 返回
        return true
    }

}

