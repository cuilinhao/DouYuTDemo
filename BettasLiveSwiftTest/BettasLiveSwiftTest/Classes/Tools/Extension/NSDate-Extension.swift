//
//  NSDate-Extension.swift
//  DYZB
//
//  Created by 1 on 16/9/19.
//  Copyright © 2016年 小码哥. All rights reserved.
//

import Foundation


extension Date {
    //Date 是结构体 所以扩展用stastic
    static func getCurrentTime() -> String {
        let nowDate = Date()
        
        let interval = Int(nowDate.timeIntervalSince1970)
        
        return "\(interval)"
    }
    
}
