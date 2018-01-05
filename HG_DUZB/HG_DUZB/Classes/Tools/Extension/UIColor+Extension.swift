//
//  UIColor+Extension.swift
//  HG_DUZB
//
//  Created by day-day-Smile on 2017/12/22.
//  Copyright © 2017年 day-day-Smile. All rights reserved.
//

import UIKit

extension UIColor{
    convenience init(r:CGFloat,g:CGFloat,b:CGFloat) {
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0,alpha:1.0)
    }
    
    class func randomColor()->UIColor{
        return UIColor.init(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)))
    }
}
