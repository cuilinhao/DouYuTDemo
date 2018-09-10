//
//  RecommendCycleView.swift
//  BettasLiveSwiftTest
//
//  Created by 崔林豪 on 2018/8/30.
//  Copyright © 2018年 崔林豪. All rights reserved.
//

import UIKit

private let  kCellID = "kCellID"

class RecommendCycleView: UIView {
    

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var cycleModels : [CycleModel]? {
        
        didSet {
            // 1.刷新collectionView
            collectionView.reloadData()
        }
        
    }
    
    //MARK:- 定义属性
    var cycleTimer : Timer?
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 设置该控件不随着父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
        
        //注册Cell
        //collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kCellID)
        collectionView.register(UINib(nibName: "CollectionViewCycleCell", bundle: nil), forCellWithReuseIdentifier: kCellID)
        
        collectionView.dataSource = self
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
     //设置layout
       let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        collectionView.isPagingEnabled = true
    }
    
}

//MARK:- 提供一个类方法
extension RecommendCycleView {
    class func recommendCycleView() -> RecommendCycleView {
        
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
    }
    
}

//MARK:- UICollectionView DataSource

extension RecommendCycleView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return 6
        
        print("----cyc-------\(String(describing: cycleModels?.count))")
        
         return (cycleModels?.count ?? 0)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCellID, for: indexPath) as! CollectionViewCycleCell
        
        cell.cycleModel = cycleModels![indexPath.item]
        
        return cell
    }
}





