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
    
    func loadAnchroData(isGroupData: Bool , URLString : String, parameters : [String : Any]? = nil, finishedCallBack : @escaping () -> ()) {
        
        NetworkTools.requestData(type: .GET, URLString: URLString) { (result) in
            
            //1. 界面处理
            guard let resultDic = result as? [String : Any] else {
                return
            }
            guard let dataArray = resultDic["data"] as? [[String : Any]] else {
                return
            }
            
            /*
            for dict in dataArray {
                self.anchorGroups.append(AnchorGroupModel(dict: dict))
            }
            */
            
            //-----
            //2. 判断是否分组数据
            if isGroupData {
                //2.1 遍历数组中的字典
                for dict in dataArray {
                    self.anchorGroups.append(AnchorGroupModel(dict: dict))
                }
            }
            else
            {
                //2.1 创建组
                let group = AnchorGroupModel()
                
                //2.2 遍历dataArray的所有字典
                for dict in dataArray {
                    group.anchors.append(AnchorModel(dict: dict as! [String : NSObject]))
                }
                
                //2.3 将group ，添加到 anchorgroups
                self.anchorGroups.append(group)
            }
            
            
            
            finishedCallBack()
            
        }
        
    }
    
}

