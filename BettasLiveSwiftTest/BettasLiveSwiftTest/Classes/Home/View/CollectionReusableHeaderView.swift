//
//  CollectionReusableHeaderView.swift
//  BettasLiveSwiftTest
//
//  Created by 崔林豪 on 2018/8/28.
//  Copyright © 2018年 崔林豪. All rights reserved.
//

import UIKit

class CollectionReusableHeaderView: UICollectionReusableView {

    @IBOutlet weak var titleLab: UILabel!
    
    var group : AnchorGroupModel?  {
        
        didSet {
            titleLab.text = group?.tag_name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.green
    }
    
}
