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
    
    
    //MARK:- 定义属性
    var cycleTimer : Timer?
    open var imageURLStringsGroup = [String](){ //设置网络图片地址数组,并刷新Collectionview
        didSet {
            //imagePathsGroup = imageURLStringsGroup
        }
    }
    open var imageNamesGroup = [String](){//设置本地图片名称数组,并刷新Collectionview
        didSet {
            //imagePathsGroup = imageNamesGroup
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 设置该控件不随着父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
        
        //注册Cell
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kCellID)
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
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCellID, for: indexPath)
        
        if indexPath.row % 2 == 0
        {
            cell.backgroundColor = UIColor.red
        }
        else
        {
            cell.backgroundColor = UIColor.orange
        }
        
        return cell
    }
}





