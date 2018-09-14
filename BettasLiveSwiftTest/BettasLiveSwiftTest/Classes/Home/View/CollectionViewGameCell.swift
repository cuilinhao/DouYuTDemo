//
//  CollectionViewGameCell.swift
//  BettasLiveSwiftTest
//
//  Created by 崔林豪 on 2018/9/11.
//  Copyright © 2018年 崔林豪. All rights reserved.
//

import UIKit

class CollectionViewGameCell: UICollectionViewCell {

    
    @IBOutlet weak var gLabel: UILabel!
    @IBOutlet weak var gameImg: UIImageView!
    
    @IBOutlet weak var lineView: UIView!
    
    //MARK:- 定义模型属性
    var group : AnchorGroupModel? {
        
        didSet {
            
            gLabel.text = group?.tag_name
            guard let iconURL = URL(string: (group?.icon_url)!) else {
                return
            }
            gameImg.kf.setImage(with: iconURL)
            
            gameImg.layer.masksToBounds = true
            gameImg.layer.cornerRadius = gameImg.frame.width / 2
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    

    
}
