//
//  BaseViewController.swift
//  BettasLiveSwiftTest
//
//  Created by 崔林豪 on 2018/9/20.
//  Copyright © 2018年 崔林豪. All rights reserved.
//

import UIKit

private let kItemMargin : CGFloat = 10

private let kItemW = (kScreenW - 3 * kItemMargin) / 2
private let kItemNormalH = kItemW * 3 / 4
private let kItemPerttyH = (kItemW * 4) / 3

private let kCycleViewH = kScreenW * 3 / 8
private let kGameViewH : CGFloat = 90



private let kNormalCell  = "kNormalCell"
private let kHeaderView  = "kHeaderView"
private let kPerttyCell  = "kPerttyCell"


private let kHeaderH : CGFloat = 50


class BaseViewController: UIViewController {

    //MARK:- life cycle
    
    var baseVM : BaseViewModel!
    
     lazy var collectionView : UICollectionView = {
        //---创建布局---
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.itemSize = CGSize(width: kItemW, height: kItemNormalH)
        collectionLayout.minimumLineSpacing = 0
        collectionLayout.minimumInteritemSpacing = kItemMargin
        
        collectionLayout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderH)
        
        //设置组的内边距
        collectionLayout.sectionInset = UIEdgeInsetsMake(0, kItemMargin, 0, kItemMargin )
        
        //------注册-----
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: collectionLayout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kNormalCell)
        
        collectionView.register(UINib(nibName: "CollectionViewNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCell)
        
        collectionView.register(UINib(nibName: "CollectionReusableHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderView)
        
        //高度 和 宽度 随着父视图的拉伸而拉伸
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        return collectionView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    
}

extension BaseViewController {
    
    func setupUI() {
        
        view.addSubview(collectionView)
    }
    
}


//MARK:- Delegate

//MARK:- UICollectionViewDataSource
extension  BaseViewController : UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return baseVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return baseVM.anchorGroups[section].anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCell, for: indexPath) as! CollectionViewNormalCell
        
        cell.anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderView, for: indexPath) as! CollectionReusableHeaderView
        
        headerView.group = baseVM.anchorGroups[indexPath.section]
        
        return headerView
        
    }
    
}


