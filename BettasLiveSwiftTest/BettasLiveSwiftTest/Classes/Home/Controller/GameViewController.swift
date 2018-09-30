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

private let kHeaderViewH : CGFloat = 130
private let kGameViewH : CGFloat = 90

//MARK:- *****************************************
//ios 上下两个scrolleview， 上面滚动，下面也跟着滚动
//https://www.google.com.hk/search?safe=strict&ei=KkWiW-3bCoS78QWuwK-QCA&q=ios+%E4%B8%8A%E4%B8%8B%E4%B8%A4%E4%B8%AAscrolleview%EF%BC%8C+%E4%B8%8A%E9%9D%A2%E6%BB%9A%E5%8A%A8%EF%BC%8C%E4%B8%8B%E9%9D%A2%E4%B9%9F%E8%B7%9F%E7%9D%80%E6%BB%9A%E5%8A%A8&oq=ios+%E4%B8%8A%E4%B8%8B%E4%B8%A4%E4%B8%AAscrolleview%EF%BC%8C+%E4%B8%8A%E9%9D%A2%E6%BB%9A%E5%8A%A8%EF%BC%8C%E4%B8%8B%E9%9D%A2%E4%B9%9F%E8%B7%9F%E7%9D%80%E6%BB%9A%E5%8A%A8&gs_l=psy-ab.3..33i160k1.5290.9337.0.10225.10.10.0.0.0.0.316.1315.6j3j0j1.10.0....0...1c.1j4.64.psy-ab..0.1.142....0.wXQSS0-xVIg

//MARK:- ***************************************

class GameViewController: UIViewController {

    //MARK:- lazy
    private var  gameGroup : [AnchorGroupModel]?
    
    private lazy var gameViewModel : RecommendViewModel = {
       
        let gameViewModel = RecommendViewModel()

        return gameViewModel
    }()
    
    //头部view
    private lazy var gameHeaderView : GameHeaderView = {
        let gameHeaderView = GameHeaderView.gameHeaderView()
        gameHeaderView.frame = CGRect(x: 0, y: -kHeaderViewH, width: kScreenW, height: kHeaderViewH)
        
        return gameHeaderView
    }()
    
    //游戏的view
    private lazy var gameView : RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        
        gameView.frame = CGRect(x: 0, y: 40, width: kScreenW, height: kGameViewH)
        
        return gameView
    }()
    
    private lazy var gameVM : GameViewModel = {
        
        let gameViewModel = GameViewModel()
        
        return gameViewModel
    }()
    
    
    
    //文件私有fileprivate
    fileprivate lazy var collectionView : UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        //MARK:设置cell之间的距离
        layout.sectionInset = UIEdgeInsetsMake(0, kEdgeMargin, 0, kEdgeMargin)
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
        
        
        collectionView.contentInset = UIEdgeInsetsMake(kHeaderViewH, 0, 0, 0 )
        
        view.addSubview(collectionView)
        collectionView.addSubview(gameHeaderView)
        
        gameHeaderView.addSubview(gameView)
        
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
            //let moreGroup = AnchorGroupModel()
            //moreGroup.tag_name = "更多"
            //groups.append(moreGroup)
            
            self.gameGroup = groups
            
            self.gameView.gameGroup = groups
            
        }
        
        //----
        gameVM.loadAllGameData {
            //展示全部游戏
            self.collectionView.reloadData()
            //展示 天下游戏
            self.gameView.gameGroup = Array(self.gameVM.games[0..<10])
            
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
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("-------->>>>>>>>>\(indexPath.section, indexPath.row)")
        
        pushNormalRoomVc()
        
    }
    
    private func presentShowRoomVc() {
        
        //1. 创建ShowRoomVc
        let showRoomVC = RoomViewController()
        
        //2.以Modal 方法弹出
        self.present(showRoomVC, animated: true, completion: nil)
    }
    
    private func pushNormalRoomVc() {
        
        //1. 创建normalRoomVC
        let normalRoomVc = RoomViewController()
        
        //push 方式弹出
        navigationController?.pushViewController(normalRoomVc, animated: true)
    }
    
    
}


extension GameViewController : UICollectionViewDelegate {
    
    
}












