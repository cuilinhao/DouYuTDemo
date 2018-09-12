//
//  GameViewController.swift
//  BettasLiveSwiftTest
//
//  Created by 崔林豪 on 2018/9/11.
//  Copyright © 2018年 崔林豪. All rights reserved.
//

import UIKit


private let kEdgeMargin : CGFloat = 10
private let kItemW : CGFloat = (kScreenW - 2 * kEdgeMargin) / 3
private let kItemH : CGFloat = kItemW * 6 / 5


class GameViewController: UIViewController {

    //MARK:- lazy
    //文件私有fileprivate
    fileprivate lazy var collectionView : UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
       let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        
        
        return collectionView
    }()
    
    //MARK:-
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.purple
    }

}
