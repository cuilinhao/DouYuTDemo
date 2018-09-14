//
//  AnchorGroupModel.swift
//  BettasLiveSwiftTest
//
//  Created by 崔林豪 on 2018/8/30.
//  Copyright © 2018年 崔林豪. All rights reserved.
//

import UIKit

class AnchorGroupModel : BaseGameModel {
    
    /*
     
     ----
     "data": [
     {
     "icon_url": "https://cs-op.douyucdn.cn/dycatr/game_cate/d3e0073bfb714186ab0c818744601963.jpg",
     "small_icon_url": "https://cs-op.douyucdn.cn/dycatr/game_cate/ffdc72ed97b50ad8011de9a779b8d83b.png",
     "tag_name": "英雄联盟",
     "tag_id": "1",
     "push_vertical_screen": "0",
     "push_nearby": "0",
     "room_list": [
     {
     "room_id": "24418",
     "vertical_src": "https://rpic.douyucdn.cn/asrpic/180903/24418_1037.jpg",
     "cate_id": 1,
     "hot": 59985,
     "avatar_small": "https://apic.douyucdn.cn/upload/avatar_v3/201808/00abaed4cc443dfde54d3991a85fed4b_small.jpg",
     "room_src": "https://rpic.douyucdn.cn/asrpic/180903/24418_1037.jpg",
     "room_name": "OB青铜5：场均百头丨神仙打架",
     "game_name": "英雄联盟",
     "isVertical": 0,
     "owner_uid": 409388,
     "ranktype": "0",
     "nickname": "斗鱼丶华仔",
     "online": "59985",
     "show_status": 1,
     "avatar_mid": "https://apic.douyucdn.cn/upload/avatar_v3/201808/00abaed4cc443dfde54d3991a85fed4b_middle.jpg",
     "jumpUrl": "",
     "rmf1": 0,
     "rmf2": 0,
     "rmf3": 0,
     "rmf4": 0,
     "rmf5": 0
     },
     {},
     {},
     {}
     ]
     },
     {},
     {},
     
     */
    
    //组显示的标题
   //@objc var tag_name : String = ""
    //组显示的图标
   //@objc var icon_url : String = ""
    
    //--定义主播的模型对象数组----
    lazy var anchors : [AnchorModel] = [AnchorModel]()
    
    //---
   @objc var room_list : [[String : NSObject]]? {
        // didSet 监听熟悉改变
        didSet {
            guard let room_lists = room_list else {
                return
            }
            for dict in room_lists {
                anchors.append(AnchorModel(dict: dict))
            }
        }
    }
    
    
    
    /*
    override func setValue(_ value: Any?, forKeyPath keyPath: String) {
        if key == "room_list" {
            if let dataArray = value as? [[String : NSObject]] {
                for dict in dataArray {
                    anchors.append(AnchorModel(dict: dict))
                }
            }
        }
    }
    */
    
}
