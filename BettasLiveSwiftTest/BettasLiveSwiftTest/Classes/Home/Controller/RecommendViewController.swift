//
//  RecommendViewController.swift
//  BettasLiveSwiftTest
//
//  Created by 崔林豪 on 2018/8/28.
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

class RecommendViewController: UIViewController {

    //MARK:- lazy
    
    private lazy var recomendViewModel : RecommendViewModel = {
        
        let recomendViewModel = RecommendViewModel()
        
        return recomendViewModel
    }()
    
    
    private lazy var cycleView : RecommendCycleView = {
        
       let cycleView = RecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH + kGameViewH), width: kScreenW, height: kCycleViewH)
  
        return cycleView
    }()
    
    
    private lazy var collectionView : UICollectionView = {
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
        
        
        //collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kNormalCell)
        
        //注册表头
       //collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderView)

        collectionView.register(UINib(nibName: "CollectionReusableHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderView)
        
        collectionView.register(UINib(nibName: "CollectionViewNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCell)
        
        //CollectionViewPerttyCell
        collectionView.register(UINib(nibName: "CollectionViewPerttyCell", bundle: nil), forCellWithReuseIdentifier: kPerttyCell)
                                
        //高度 和 宽度 随着父视图的拉伸而拉伸
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        return collectionView
        
    }()
    
    //游戏的view
    private lazy var gameView : RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        
        return gameView
        
    }()
    
    //MARK:- life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.red
        collectionView.addSubview(cycleView)
        collectionView.addSubview(gameView)
        
        collectionView.contentInset = UIEdgeInsetsMake(kCycleViewH + kGameViewH , 0, 0, 0)
        
        setupUI()
        loadData()
        
    }
}

//MARK:- 加载数据

extension RecommendViewController {
    
    //请求推荐数据
    private func loadData () {
        
        recomendViewModel.requestData {
            self.collectionView.reloadData()
            
            // 2.将数据传递给GameView
            var groups = self.recomendViewModel.anchorGroup
            
            // 2.1.移除前两组数据
            groups.removeFirst()
            groups.removeFirst()
            
            // 2.2.添加更多组
            let moreGroup = AnchorGroupModel()
            moreGroup.tag_name = "更多"
            groups.append(moreGroup)
            
            self.gameView.gameGroup = groups
            
            print("---game data---->>>\(groups.count)")
            
        }
        
         //请求轮播数据
        recomendViewModel.requestCycleData {
            
            //self.cycleView.cycleModels = self.recommendVM.cycleModels
            
            self.cycleView.cycleModels = self.recomendViewModel.cycleGroup
            
            print("请求轮播数据完成----\(String(describing: self.cycleView.cycleModels?.count))")
        }
    }
    
}

//MARK:-  initUI
extension  RecommendViewController {
    
    func setupUI() {
        view.addSubview(collectionView)
    }
}


//MARK:- UICollectionViewDataSource
extension  RecommendViewController : UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        print("---总共的数量-----" +  "\(recomendViewModel.anchorGroup.count)")
        return  recomendViewModel.anchorGroup.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = recomendViewModel.anchorGroup[section]
        
        return group.anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCell, for: indexPath)
        
        //取出模型对象
        let group = recomendViewModel.anchorGroup[indexPath.section]
        let anchor = group.anchors[indexPath.item]
        
        if indexPath.section == 0
        {
            //取出cell
          let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: kPerttyCell, for: indexPath) as! CollectionViewPerttyCell
            
            //设置数据
            cell.anchor  = anchor
            
            return cell
        }
        else
        {
           let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCell, for: indexPath) as! CollectionViewNormalCell

            cell.anchor = anchor
            
            //取出cell
//            let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: kPerttyCell, for: indexPath) as! CollectionViewPerttyCell
//            //设置数据
//            cell.anchor  = anchor
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        //取出section的headerView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderView, for: indexPath) as! CollectionReusableHeaderView
        
        headerView.group = recomendViewModel.anchorGroup[indexPath.section]
        
        return headerView
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        if indexPath.section == 0 {
            
            return CGSize(width: kItemW, height : kItemPerttyH - 30)
        }
        
        return CGSize(width: kItemW, height : kItemNormalH)
    }
  
    
}


