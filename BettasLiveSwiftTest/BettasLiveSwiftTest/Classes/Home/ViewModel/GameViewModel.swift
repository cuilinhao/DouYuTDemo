//
//  GameViewModel.swift
//  BettasLiveSwiftTest
//
//  Created by 崔林豪 on 2018/9/13.
//  Copyright © 2018年 崔林豪. All rights reserved.
//

import UIKit

class GameViewModel: NSObject {

    lazy var games : [GameModel] = [GameModel]()
    
}

extension GameViewModel {
    func loadAllGameData(finishedCallBack : @escaping () -> ()) {
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: ["shortName" : "game"]) { (result) in
            
            //获取到数据
            guard let resultDict = result as? [String : Any] else {
                return
            }
            
            print("--------vvv-------\(resultDict)")
            
            
            guard let dataArray = resultDict["data"] as? [[String : Any]] else {
                return
            }
            //字典转模型
            for dict in dataArray {
                
                self.games.append(GameModel(dict: dict))
            }
            
            finishedCallBack()
            
        }
    }
}
