//
//  GameHeaderView.swift
//  BettasLiveSwiftTest
//
//  Created by 崔林豪 on 2018/9/17.
//  Copyright © 2018年 崔林豪. All rights reserved.
//

import UIKit

class GameHeaderView: UIView {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = UIViewAutoresizing()
        /*
        collectionView.delegate = self
        collectionView.dataSource = self
        //collectionView.isSpringLoaded = true
        
        //---创建布局---
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.itemSize = CGSize(width: 80, height: 80)
        collectionLayout.minimumLineSpacing = 0
        collectionLayout.minimumInteritemSpacing = 0
        collectionLayout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = collectionLayout
        
        //注册cell
        collectionView.register(UINib(nibName: "CollectionViewGameCell", bundle: nil), forCellWithReuseIdentifier: "kGameCell")
         */
        
    }
}

/*
extension GameHeaderView : UICollectionViewDelegate {
    
}


extension GameHeaderView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "kGameCell", for: indexPath)
        
        return cell
        
    }
    
}

 */

extension GameHeaderView {
    
    class func gameHeaderView() -> GameHeaderView {
        return Bundle.main.loadNibNamed("GameHeaderView", owner: nil, options: nil)?.first as! GameHeaderView
    }
}



