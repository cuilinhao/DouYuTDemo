//
//  CollectionViewPerttyCell.swift
//  BettasLiveSwiftTest
//
//  Created by 崔林豪 on 2018/8/29.
//  Copyright © 2018年 崔林豪. All rights reserved.
//

import UIKit

import Kingfisher


class CollectionViewPerttyCell: UICollectionViewCell {

    @IBOutlet weak var onlineLab: UILabel!
    
    @IBOutlet weak var iconImgView: UIImageView!
    
    @IBOutlet weak var cityBtn: UIButton!
    @IBOutlet weak var nickNameLabel: UILabel!
   
    //MARK:- 定义模型属性
    var anchor : AnchorModel? {
        
        didSet {
            //校验模型是否有值
            guard let anchor = anchor else {
                return
            }
            //取出在线人数显示
            var onlineStr : String = ""
            
            if anchor.online >= 10000 {
                onlineStr = "\(Int(anchor.online / 10000)) 万在线"
            } else {
                onlineStr = "\(anchor.online) 万在线"
            }
            onlineLab.text = onlineStr
            
            nickNameLabel.text = anchor.nickname
            
            cityBtn.setTitle("shangHai", for: .normal)
            
            guard let iconURL = URL(string: anchor.vertical_src) else {
                return
            }
            
            iconImgView.kf.setImage(with: iconURL)
        }
    }
    

}
