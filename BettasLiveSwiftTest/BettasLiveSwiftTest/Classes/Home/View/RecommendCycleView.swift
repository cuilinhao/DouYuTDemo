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
    
    var cycleTimer : Timer?
    
    
    var cycleModels : [slideListModel]? {
        
        didSet {
            // 刷新collectionView
            collectionView.reloadData()
            
            //设置pageControlle个数
            pageControl.numberOfPages = cycleModels?.count ?? 0
            
            //MARK:- ************滚动**************
            //默认滚动到中间的某一个位置
            let indexPath = NSIndexPath(item: (cycleModels?.count ?? 0) * 10, section: 0)
            collectionView.scrollToItem(at: indexPath as IndexPath, at: .left, animated: false)
            
            //添加定时器
            removeCycleTimer()
            addCycleTimer()
        }
        
    }
    
    //MARK:- 定义属性
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 设置该控件不随着父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
        
        //注册Cell
        //collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kCellID)
        collectionView.register(UINib(nibName: "CollectionViewCycleCell", bundle: nil), forCellWithReuseIdentifier: kCellID)
        
        collectionView.dataSource = self
        collectionView.delegate = self
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


//MARK:- 实现滚动
//MARK:- UICollectionViewDelegate
extension RecommendCycleView : UICollectionViewDelegate {
    
    //MARK:- ************滚动**************
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //获取滚动的偏移量
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        //计算pageControl的currentIndex
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width) % (cycleModels?.count ?? 1)
    }
    
    //--- 用户拖拽时， 处理定时器
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCycleTimer()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        addCycleTimer()
    }
    
}

//MARK:- 定时器处理
extension RecommendCycleView {
    private func addCycleTimer() {
        cycleTimer = Timer(timeInterval: 2.0, target: self, selector: #selector(scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: .defaultRunLoopMode)
    }
    
    private func removeCycleTimer() {
        cycleTimer?.invalidate()
        cycleTimer = nil
        
    }
    
    //MARK:- ************滚动**************
   @objc private func scrollToNext()  {
    
    //获取滚动偏移量
    let currentOffsetX = collectionView.contentOffset.x
    let offsetX = currentOffsetX + collectionView.bounds.width
    
    //滚动该位置
    collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
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
        // *1000 实现无线滚动
         return (cycleModels?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCellID, for: indexPath) as! CollectionViewCycleCell
        //% cycleModels!.count防止越界 循环滚动 1000个cell
        cell.cycleModel = cycleModels![indexPath.item % cycleModels!.count]
        
        
        return cell
    }
}






