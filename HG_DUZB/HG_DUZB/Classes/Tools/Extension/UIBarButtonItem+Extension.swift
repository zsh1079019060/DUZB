//
//  UIBarButtonItem+Extension.swift
//  HG_DUZB
//
//  Created by day-day-Smile on 2017/12/21.
//  Copyright © 2017年 day-day-Smile. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    /*
    class func  createItem(imageName:String,heightImageName:String,size:CGSize) -> UIBarButtonItem {
        
        let btn = UIButton()
        
        btn.setImage(UIImage.init(named: imageName), for: .normal)
        btn.setImage(UIImage.init(named: imageName), for: .highlighted)
        
        btn.frame = CGRect(origin: .zero, size: size)
        
        return UIBarButtonItem(customView: btn)
    }
    */
    /// swift 建议使用便利构造函数
    /// 1.convenience开头
    /// 2. 在构造函数中必须明确调用一个设计的构造函数 （self）
    convenience init(imageName:String,heightImageName:String = "",size:CGSize = CGSize.zero) {
        
        let btn = UIButton()
        
        btn.setImage(UIImage.init(named: imageName), for: .normal)
        
        if heightImageName != "" {
            btn.setImage(UIImage.init(named: imageName), for: .highlighted)
        }
        
        if size == CGSize.zero {
            btn.sizeToFit()
        }else{
            btn.frame = CGRect(origin: .zero, size: size)
        }
        
        self.init(customView: btn)
    }
}
