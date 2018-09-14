
//
//  RecommendViewModel.swift
//  BettasLiveSwiftTest
//
//  Created by 崔林豪 on 2018/8/30.
//  Copyright © 2018年 崔林豪. All rights reserved.
//

import UIKit

import Alamofire


private let  ZJCateBannerURL = "https://apiv2.douyucdn.cn/live/Slide/getSlideLists?cate_id=1&app_ver=4610000&client_sys=ios"

class RecommendViewModel: NSObject {

    //MARK:- lazy
    // 0组和1组放到最前面 然后是 2- 12 组
     lazy var anchorGroup : [AnchorGroupModel] = [AnchorGroupModel]()
    private lazy var bigDataGroup : AnchorGroupModel = AnchorGroupModel()
    
    private lazy var perttyGroup : AnchorGroupModel = AnchorGroupModel()
    
    
     lazy var cycleGroup : [slideListModel] = [slideListModel]()
}


//MARK:- 发送网络数据
extension RecommendViewModel {
    
     func getCurrentTime() -> String {
        let nowDate = Date()
        
        let interval = Int(nowDate.timeIntervalSince1970)
        
        return "\(interval)"
    }
    
}

extension RecommendViewModel {
    //func requestData(_ finishedCallback : @escaping (_ jsonData : [AnyObject]) -> ()) {
    func requestData(_ finishedCallback : @escaping () -> ()) {
        
        //let parameters = ["limit" : "4", "offset" : "0", "time" : NSDate.getCurrentTime()]
        
        
        let parameters = ["limit" : "4", "offset" : "0", "time" : self.getCurrentTime()]
        
        
        //创建group
        let dispatchGroup = DispatchGroup()
        
        //请求推荐数据
        dispatchGroup.enter()
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: parameters as [String : NSString]) { (result) in
            
            guard let resultDic = result as? [String : NSObject] else {
                return
            }
            
            guard let dataArray = resultDic["data"] as? [[String : NSObject]] else {
                return
            }
            
            //let group = AnchorGroupModel()
            //group.tag_name = "热门";
            self.bigDataGroup.tag_name = "热门"
            
            
            for dict in dataArray {
                
                let anchor = AnchorModel(dict: dict)
                self.bigDataGroup.anchors.append(anchor)
            }
             dispatchGroup.leave()
            print("------------0000-------")
        }
        
        //请求颜值数据
         dispatchGroup.enter()
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters as [String : NSString]) { (result) in
            
            //转成字典类型
            guard let resultDict = result as? [String : NSObject] else {
                return
            }
            //获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {
                return
            }
            
            //遍历字典，转成对象
            //let group = AnchorGroupModel()
            //group.tag_name = "颜值"
            
            self.perttyGroup.tag_name = "颜值"
            
            //获取主播数据
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.perttyGroup.anchors.append(anchor)
            }
            print("---------111----------")
            dispatchGroup.leave()
        }
        
        //请求游戏数据
         dispatchGroup.enter()
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: ["limit" : "4", "offset" : "0", "time" : self.getCurrentTime() as NSString]) { (response) in
            
            
            guard let resultDic = response  as? [String : NSObject] else {
                
                return
            }
            
            guard let dataArray = resultDic["data"] as? [[String : Any]]  else {
                return
            }
            
            for dict in dataArray {
                let group = AnchorGroupModel(dict: dict)
                self.anchorGroup.append(group)
            }

            for group in self.anchorGroup {
                for anchor in group.anchors {
                    print("++++++++" + anchor.nickname)
                }
            }
            
            print("---------222----------")
            dispatchGroup.leave()
        }
        
        //所有的数据请求到，之后排序
        dispatchGroup.notify(queue: DispatchQueue.main) {
            print("所有数据请求到")
            self.anchorGroup.insert(self.perttyGroup, at: 0)
            self.anchorGroup.insert(self.bigDataGroup, at: 0)
            
            finishedCallback()
        }
    }

    //MARK:- ？？？？？？？？？？
    //请求轮播数据
    func requestCycleData(finishCallback : @escaping () -> ()) {
        
         //ZJNetWorking.requestData(type: .GET, URlString: ZJCateBannerURL, parameters: ["version" : "2.300"]) { (response) in
         //print("+++++++++轮播数据+++111++\(response)")
         //}
        
        // 配置 HTTPHeaders
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "charset":"utf-8",
            ]
        
        Alamofire.request(ZJCateBannerURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
        
            guard let result = response.result.value else {
                print(response.result.error ?? "错误")
                return
            }
            
            guard let dict = result as? [String : Any] else {
                return
            }
            
             print("+++++>>>>>>>>>+0000++\(dict)")
            
            
            /*
             guard let dataArray = resultDic["data"] as? [[String : Any]]  else {
             return
             }
             
             for dict in dataArray {
             let group = AnchorGroupModel(dict: dict)
             self.anchorGroup.append(group)
             }
             
             for group in self.anchorGroup {
             for anchor in group.anchors {
             print("++++++++" + anchor.nickname)
             }
             }
             
             */
            
            guard let dataDic = dict["data"] as? [String : Any] else {
                return
            }
            
            guard let dataArray = dataDic["slide_list"] as? [[String : Any]] else {
                return
            }

            for dic in dataArray {

                let group = slideListModel(dict: dic as! [String : NSObject])
                self.cycleGroup.append(group)
            }
            
            print("------ccccc-----\(self.cycleGroup.count)")
            
            
            finishCallback()
        }
    }
    
    //请求推荐游戏的接口
    
    
        
}


