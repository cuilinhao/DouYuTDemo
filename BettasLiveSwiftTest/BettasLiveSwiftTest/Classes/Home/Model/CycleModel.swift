//
//  CycleModel.swift
//  BettasLiveSwiftTest
//
//  Created by 崔林豪 on 2018/9/5.
//  Copyright © 2018年 崔林豪. All rights reserved.
//

import UIKit

class CycleModel: NSObject {

    //标题
    var title : String = ""
    //展示的图片地址
    var pic_url : String = ""
    //pic-url
    var resource : String = ""

    //主播信息对应的字典
    var room : [String : NSObject]? {
        didSet {
            guard let room = room else {
                return
            }
            anchor = AnchorModel(dict: room)
        }
    }

    //主播信息对应的模型对象
    var anchor : AnchorModel?

    //MARK:- 自定义构造函数
    init(dict : [String : NSObject]) {
        super.init()

        setValuesForKeys(dict)
    }

    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }


}
