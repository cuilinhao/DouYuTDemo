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

private let gameCell  = "gameCell"
private let gameHeaderCell  = "gameHeaderCell"

class GameViewController: UIViewController {

    //MARK:- lazy
    private var  gameGroup : [AnchorGroupModel]?
    
    private lazy var gameViewModel : RecommendViewModel = {
       
        let gameViewModel = RecommendViewModel()

        return gameViewModel
    }()
    
    private lazy var gameVM : GameViewModel = {
        
        let gameViewModel = GameViewModel()
        
        return gameViewModel
    }()
    
    
    
    //文件私有fileprivate
    fileprivate lazy var collectionView : UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 80, height: 80)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        //决定横向布局还是纵向布局
        layout.scrollDirection = .vertical
        //？？？
        layout.headerReferenceSize = CGSize(width: kScreenW, height: 50)
        
       let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        collectionView.isPagingEnabled = true

        
        //注册cell
        collectionView.register(UINib(nibName: "CollectionViewGameCell", bundle: nil), forCellWithReuseIdentifier: gameCell)
        //注册表头
        collectionView.register(UINib(nibName: "CollectionReusableHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: gameHeaderCell)
        
        //高度 和 宽度 随着父视图的拉伸而拉伸
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        return collectionView
    }()
    
    //MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.purple
        view.addSubview(collectionView)
        loadData()
        
    }
    
}


//MARK:- 数据加载
extension GameViewController {
    
    private func loadData() {
        
        gameViewModel.requestData {
            
            self.collectionView.reloadData()
            var groups = self.gameViewModel.anchorGroup
            //移除💰两组数据
            groups.removeFirst()
            groups.removeFirst()
            
            //添加更多组
            let moreGroup = AnchorGroupModel()
            moreGroup.tag_name = "更多"
            groups.append(moreGroup)
            
            self.gameGroup = groups
        }
        
        //----
        gameVM.loadAllGameData {
            
        }
    }

}

extension GameViewController : UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {

        return  gameViewModel.anchorGroup.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //return 12
        return (gameGroup?.count ?? 0)
        
//        let group = gameViewModel.anchorGroup[section]
//        return group.anchors.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: gameCell, for: indexPath) as! CollectionViewGameCell
        cell.group = self.gameGroup![indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        //取出section的headerView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: gameHeaderCell, for: indexPath) as! CollectionReusableHeaderView

        var group = gameViewModel.anchorGroup;
        
        //AnchorGroupModel
        for i in 0..<group.count {
            
            if i == 0
            {
                let item = group[i]
                item.tag_name = "常用"
            }
            else
            {
                let item = group[i]
                item.tag_name = "全部"
            }
        }
        
        headerView.group = group[indexPath.section]

        return headerView
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        if indexPath.section == 0  {
            
            return CGSize(width: 80, height: 80)
        }
        
        return CGSize(width: kItemW, height: kItemH)
    }
}


extension GameViewController : UICollectionViewDelegate {
    
    
}












