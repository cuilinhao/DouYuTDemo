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
        loadAnchroData( URLString: "http://capi.douyucdn.cn/api/v1/getColumnRoom/3", parameters: ["limit" : 30, "offset" : 0], finishedCallBack: finishedCallBack)
    }
    
}
