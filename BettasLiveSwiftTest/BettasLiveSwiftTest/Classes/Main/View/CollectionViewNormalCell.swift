//
//  CollectionViewNormalCell.swift
//  BettasLiveSwiftTest
//
//  Created by 崔林豪 on 2018/9/3.
//  Copyright © 2018年 崔林豪. All rights reserved.
//

import UIKit

class CollectionViewNormalCell: UICollectionViewCell {
    
    @IBOutlet weak var bLable: UILabel!
    
    @IBOutlet weak var picImgView: UIImageView!
    
    //MARK:- 定义模型属性
    var anchor : AnchorModel? {
        
        /*
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
            
            nameLab.text = anchor.nickname
            
            guard let iconURL = URL(string: anchor.vertical_src) else {
                return
            }
            iconImageView.kf.setImage(with: iconURL)

        }
        */
        
        didSet {
            
            //校验模型是否有值
            guard let anchor = anchor else {
                return
            }
            
            bLable.text = anchor.nickname
            guard let iconURL = URL(string: anchor.vertical_src) else {
                return
            }
            
            picImgView.layer.cornerRadius = 5.0
            picImgView.layer.masksToBounds = true
            
            picImgView.kf.setImage(with: iconURL)
            
        }
        
        
        
    }

    
}
