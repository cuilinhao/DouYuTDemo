//
//  AnchorModel.swift
//  BettasLiveSwiftTest
//
//  Created by 崔林豪 on 2018/8/30.
//  Copyright © 2018年 崔林豪. All rights reserved.
//

import UIKit


class AnchorModel: NSObject {

    /*
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
     */
    /// 房间ID
   @objc var room_id : Int = 0
    /// 房间图片对应的URLString
   @objc var vertical_src : String = ""
    /// 判断是手机直播还是电脑直播
    // 0 : 电脑直播(普通房间) 1 : 手机直播(秀场房间)
   //@objc var isVertical : Int = 0
    /// 房间名称
   @objc var room_name : String = ""
    /// 主播昵称
   @objc var nickname : String = ""
    /// 观看人数
   @objc var online : Int = 0
    /// 所在城市
   //@objc var anchor_city : String = ""
    
    
    
    init(dict : [String : NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}


class slideListModel: NSObject {
    
    /*
     "slide_list" =     (
     {
     "cate_id" = 1;
     isVertical = 0;
     "is_room_show" = 0;
     level = 0;
     link = 288016;
     "link_type" = 0;
     nrt = 0;
     resource = "https://sta-op.douyucdn.cn/dypart/2018/09/01/cc710365d3cabf0d0687a76e24299fa0.jpg";
     title = "\U82f1\U96c4\U8054\U76df";
     "vertical_src" = "https://rpic.douyucdn.cn/asrpic/180910/288016_1056.jpg";
     },
     */
    
    /// 房间ID
    @objc var resource : String = ""
    /// 房间图片对应的URLString
    @objc var title : String = ""
    
    @objc var vertical_src : String = ""
    
    
    
    init(dict : [String : NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    
}
