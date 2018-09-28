//
//  AmuseViewController.swift
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

private let kMenuView : CGFloat = 200

class AmuseViewController: BaseViewController {

    //MARK:- lazy
    
    fileprivate lazy var menuView : AmuseMenuView = {
       
        let menuView = AmuseMenuView.loadAmuseMenuView()
        
        menuView.frame = CGRect(x: 0, y: -kMenuView, width: kScreenW, height: kMenuView)
        
        return menuView
        
    }()
    
    private lazy var amuseVM : AmuseViewModel = {
        
        let amuseVM = AmuseViewModel()
        
        return amuseVM
    }()
    
    //MARK:- life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //----设置努力加载中
        contentView = collectionView
        
        super.setAnimationUI()
        
        loadData()
        
        super.setupUI()
        collectionView.addSubview(menuView)
        collectionView.contentInset = UIEdgeInsetsMake(kMenuView, 0, 0, 0 )
        
        //数据加载完成，停止加载动画
        
        super.loadfinishedAnimation()
        
        
    }
    
}

//MARK:-  initUI
extension  AmuseViewController {
    
   func loadData () {
    
        //给父类中的viewmodel 进行赋值
        baseVM = amuseVM
        //请求数据
        amuseVM.loadAmuseData {
            self.collectionView.reloadData()
            
            //self.menuView.groups = self.amuseVM.anchorGroups
            
            var groups = self.amuseVM.anchorGroups
            groups.removeFirst()
            
            self.menuView.groups = groups
            
        }
    }
    
}










