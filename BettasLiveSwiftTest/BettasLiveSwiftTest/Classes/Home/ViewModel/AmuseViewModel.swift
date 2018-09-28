//
//  AmuseViewModel.swift
//  BettasLiveSwiftTest
//
//  Created by 崔林豪 on 2018/9/20.
//  Copyright © 2018年 崔林豪. All rights reserved.
//

import UIKit

class AmuseViewModel: BaseViewModel {
    
}


extension AmuseViewModel {
    
    func loadAmuseData(finishedCalledBack : @escaping () -> ()) {
        loadAnchroData( isGroupData: true, URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", finishedCallBack: finishedCalledBack)
    }
    
}
