//
//  NSDate+Extension.swift
//  HG_DUZB
//
//  Created by day-day-Smile on 2017/12/28.
//  Copyright © 2017年 day-day-Smile. All rights reserved.
//

import Foundation

extension Date {
    static func getCurrentTime() -> String {
        let nowDate = Date()
        let Interval = nowDate.timeIntervalSince1970
        return "\(Interval)"
    }
}
