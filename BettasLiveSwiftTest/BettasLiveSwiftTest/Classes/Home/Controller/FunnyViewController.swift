//
//  FunnyViewController.swift
//  BettasLiveSwiftTest
//
//  Created by 崔林豪 on 2018/9/25.
//  Copyright © 2018年 崔林豪. All rights reserved.
//

import UIKit



private let kTopMargin : CGFloat = 8

class FunnyViewController: BaseViewController {

    //MARK:- 懒加载 ViewModel 对象
    fileprivate lazy var funnyVM : FunnyViewModel = FunnyViewModel()
    
}


extension FunnyViewController {
    
    override func viewDidLoad() {
        super.setupUI()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize.zero
        collectionView.contentInset = UIEdgeInsets(top: kTopMargin, left: 0, bottom: 0, right: 0)
    }
    
}


extension FunnyViewController {
    
    func loadData() {
        
        //1.给父类中的ViewModel赋值
        baseVM = funnyVM
        
        //2. 请求数据
        funnyVM.loadFunnyData {
            
            super.collectionView.reloadData()
        }
        
    }
    
}
