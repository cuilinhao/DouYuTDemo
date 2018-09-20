//
//  AmuseViewModel.swift
//  BettasLiveSwiftTest
//
//  Created by 崔林豪 on 2018/9/20.
//  Copyright © 2018年 崔林豪. All rights reserved.
//

import UIKit

class AmuseViewModel: NSObject {
    
    lazy var anchorGroups : [AnchorGroupModel] = [AnchorGroupModel]()

}


extension AmuseViewModel {
    
    func loadAmuseData(finishedCalledBack : @escaping () -> ()) {
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2") { (result) in
            
            guard let resultDic = result as? [String : Any] else {
                return
            }
            guard let dataArray = resultDic["data"] as? [[String : Any]] else {
                return
            }
            
            for dict in dataArray {
                self.anchorGroups.append(AnchorGroupModel(dict: dict))
            }
            
            finishedCalledBack()
            
        }
    }
    
    
}
