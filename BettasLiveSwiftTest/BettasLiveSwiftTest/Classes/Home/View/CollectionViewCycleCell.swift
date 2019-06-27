//
//  CollectionViewCycleCell.swift
//  BettasLiveSwiftTest
//
//  Created by 崔林豪 on 2018/9/10.
//  Copyright © 2018年 崔林豪. All rights reserved.
//

import UIKit

import Kingfisher


class CollectionViewCycleCell: UICollectionViewCell {

    @IBOutlet weak var cycleBGImg: UIImageView!
    
    @IBOutlet weak var cycleTitleLab: UILabel!
    
    //MARK:- 定义模型属性
    var cycleModel : slideListModel? {
        
        didSet {
            
            cycleTitleLab.text = cycleModel?.title
            
            guard let iconURL = URL(string: (cycleModel?.resource)!) else {
                return
            }
            //cycleBGImg.kf.setImage(with: iconURL)
            
            cycleBGImg.image = UIImage.init(named: "scroll011")

        }
    }
    
    
    //cycleBGImg.image = UIImage.init(named: "scroll011")
    
    
    
    
    

}
