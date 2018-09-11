//
//  RecommendGameView.swift
//  BettasLiveSwiftTest
//
//  Created by 崔林豪 on 2018/9/10.
//  Copyright © 2018年 崔林豪. All rights reserved.
//

import UIKit

private let kGameCell = "kGameCell"

class RecommendGameView: UIView {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var gameGroup : [AnchorGroupModel]? {
        
        didSet {
            collectionView.reloadData()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 设置该控件不随着父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        
        //---创建布局---
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.itemSize = CGSize(width: 80, height: 80)
        collectionLayout.minimumLineSpacing = 0
        collectionLayout.minimumInteritemSpacing = 0
        collectionLayout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = collectionLayout
        
        //注册cell
        collectionView.register(UINib(nibName: "CollectionViewGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCell)
    }
}

extension RecommendGameView : UICollectionViewDelegate {
    
}


extension RecommendGameView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //return 12
        //return (self.gameGroup?.count)!
        
        return (gameGroup?.count ?? 0)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCell, for: indexPath) as! CollectionViewGameCell
        
        cell.group = self.gameGroup![indexPath.item]
        return cell
    }
}

//MARK:- 提供一个快速创建的类方法
extension RecommendGameView {
    class func recommendGameView() -> RecommendGameView {
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }
}
