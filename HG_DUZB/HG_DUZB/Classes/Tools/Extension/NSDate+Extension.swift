//
//  NSDate+Extension.swift
//  HG_DUZB
//
//  Created by day-day-Smile on 2017/12/28.
//  Copyright © 2017年 day-day-Smile. All rights reserved.
//

import Foundation

extension NSDate {
    class func getCurrentTime() -> String {
        let nowDate = NSDate()
        let Interval = nowDate.timeIntervalSince1970
        return "\(Interval)"
    }
}
