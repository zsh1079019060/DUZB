//
//  HGRoomNormalViewController.swift
//  HG_DUZB
//
//  Created by day-day-Smile on 2018/1/16.
//  Copyright © 2018年 day-day-Smile. All rights reserved.
//

import UIKit

class HGRoomNormalViewController: UIViewController,UIGestureRecognizerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.red
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        /// 隐藏导航栏后  手势左右拖动屏幕不管用，必须设置手势代理
        navigationController?.setNavigationBarHidden(true, animated: true)
        /// 依然保持手势
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
