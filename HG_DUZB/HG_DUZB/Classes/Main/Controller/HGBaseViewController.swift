//
//  HGBaseViewController.swift
//  HG_DUZB
//
//  Created by day-day-Smile on 2018/1/16.
//  Copyright © 2018年 day-day-Smile. All rights reserved.
//

import UIKit

class HGBaseViewController: UIViewController {
    
    var content : UIView?
    
    // MARK: 懒加载属性
    fileprivate lazy var animageView:UIImageView = {
        let animageView  = UIImageView(image: UIImage.init(named: "img_loading_1"))
        animageView.center = self.view.center
        animageView.animationImages = [UIImage.init(named: "img_loading_1")!,UIImage.init(named: "img_loading_2")!]
        animageView.animationDuration = 0.5
        animageView.animationRepeatCount = LONG_MAX
        //Int(MAXFRAG)
        animageView.autoresizingMask = [.flexibleTopMargin,.flexibleBottomMargin]
        return animageView
    }()
    // MARK: 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }
    
    func setupUI() {
        /// 隐藏内容
        content?.isHidden = true
        
        /// 添加执行动画的UIImageView
        view.addSubview(animageView)
        
        animageView.startAnimating()
        /// 设置背景颜色
        view.backgroundColor = UIColor(r: 250, g: 250, b: 250)
    }
    
    func loadDataFinished() {
        /// 1.停止动画
        animageView.stopAnimating()
        
        /// 2.隐藏animageView
        animageView.isHidden = true
        
        /// 3.展示数据
        content?.isHidden = false
        
    }
}
