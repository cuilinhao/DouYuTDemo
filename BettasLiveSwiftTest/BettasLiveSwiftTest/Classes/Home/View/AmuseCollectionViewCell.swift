//
//  AmuseCollectionViewCell.swift
//  BettasLiveSwiftTest
//
//  Created by 崔林豪 on 2018/9/21.
//  Copyright © 2018年 崔林豪. All rights reserved.
//

import UIKit


private let kGameCellID = "kGameCellID"

class AmuseCollectionViewCell: UICollectionViewCell {

    //MARK:- 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var groups : [AnchorGroupModel]? {
     
        didSet {
            collectionView.reloadData()
            
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(UINib(nibName: "CollectionViewGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        let itemW = collectionView.bounds.width / 4
        let itemH = collectionView.bounds.height / 2
        layout.itemSize = CGSize(width: itemW, height: itemH)
    }
}


extension AmuseCollectionViewCell : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionViewGameCell
        
        cell.group = groups![indexPath.item]
        cell.clipsToBounds = true
        cell.lineView.isHidden = true
        
        return cell
    }
    
}
