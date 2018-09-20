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


class AmuseViewController: BaseViewController {

    //MARK:- lazy
    private lazy var amuseVM : AmuseViewModel = {
        
        let amuseVM = AmuseViewModel()
        
        return amuseVM
    }()
    
    
    
    //MARK:- life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        
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
        }
    }
    
}










