//
//  BaseGameModel.swift
//  BettasLiveSwiftTest
//
//  Created by 崔林豪 on 2018/9/13.
//  Copyright © 2018年 崔林豪. All rights reserved.
//

import UIKit

class BaseGameModel: NSObject {

   @objc var tag_name : String = ""
   @objc var pic_url : String = ""
    
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
        
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}
