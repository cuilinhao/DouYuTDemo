//
//  BaseViewModel.swift
//  BettasLiveSwiftTest
//
//  Created by 崔林豪 on 2018/9/20.
//  Copyright © 2018年 崔林豪. All rights reserved.
//

import UIKit


//MARK:- 抽取是按照代码最少的那个来写

class BaseViewModel: NSObject {

    lazy var anchorGroups : [AnchorGroupModel] = [AnchorGroupModel]()
}

//http://capi.douyucdn.cn/api/v1/getHotRoom/2

extension BaseViewModel {
    
    func loadAnchroData(URLString : String, parameters : [String : Any]? = nil, finishedCallBack : @escaping () -> ()) {
        
        NetworkTools.requestData(type: .GET, URLString: URLString) { (result) in
            
            guard let resultDic = result as? [String : Any] else {
                return
            }
            guard let dataArray = resultDic["data"] as? [[String : Any]] else {
                return
            }
            
            for dict in dataArray {
                self.anchorGroups.append(AnchorGroupModel(dict: dict))
            }
            
            finishedCallBack()
            
        }
        
    }
    
}

