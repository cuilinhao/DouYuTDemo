//
//  CycleModel.swift
//  BettasLiveSwiftTest
//
//  Created by 崔林豪 on 2018/9/5.
//  Copyright © 2018年 崔林豪. All rights reserved.
//

import UIKit

class CycleModel: NSObject {

    /*
     +++++>>>>>>>>>+0000++["data": {
     count = 2;
     num = 0;
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
     "vertical_src" = "https://rpic.douyucdn.cn/asrpic/180910/288016_1101.jpg";
     },
     {
     "cate_id" = 1;
     "is_room_show" = 0;
     level = 1;
     link = "https://www.douyu.com/t/lolstar";
     "link_type" = 1;
     resource = "https://cs-op.douyucdn.cn/dypart/2018/06/19/90e7341afb11c560c8170b6ba78c1e33.jpg";
     title = "\U82f1\U96c4\U8054\U76df";
     }
     );
     }, "error": 0]
     
     */
    //标题
    
//    //展示的图片地址
//    var pic_url : String = ""
//    //pic-url
//    var resource : String = ""
//
//    //主播信息对应的字典
//    var room : [String : NSObject]? {
//        didSet {
//            guard let room = room else {
//                return
//            }
//            anchor = slideListModel(dict: room)
//        }
//    }
    
    //主播信息对应的模型对象
    //var anchor : slideListModel?
    
    
    //-----
    lazy var cycleLists : [slideListModel] =  [slideListModel]()
    
    @objc var slide_list : [[String : NSObject]]? {
        
        didSet {
            guard let slide_list = slide_list else {
                return
            }
            
            for dict in slide_list {
                cycleLists.append(slideListModel(dict: dict))
            }
        }
        
    }
    

  

    //MARK:- 自定义构造函数
    init(dict : [String : NSObject]) {
        super.init()

        setValuesForKeys(dict)
    }

    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }


}
