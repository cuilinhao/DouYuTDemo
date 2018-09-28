//
//  FunnyViewModel.swift
//  BettasLiveSwiftTest
//
//  Created by 崔林豪 on 2018/9/27.
//  Copyright © 2018年 崔林豪. All rights reserved.
//

import UIKit

class FunnyViewModel: BaseViewModel {

}


extension FunnyViewModel {
    
    func loadFunnyData(finishedCallBack : @escaping () -> ()) {
        loadAnchroData( isGroupData: true, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: ["limit" : "4", "offset" : "0", "time" : self.getCurrentTime() as NSString], finishedCallBack: finishedCallBack)
    }
    
}


extension FunnyViewModel {
    
    func getCurrentTime() -> String {
        let nowDate = Date()
        
        let interval = Int(nowDate.timeIntervalSince1970)
        
        return "\(interval)"
    }
    
}
