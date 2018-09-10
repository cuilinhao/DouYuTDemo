//
//  PageContentView.swift
//  BettasLiveSwiftTest
//
//  Created by 崔林豪 on 2018/8/23.
//  Copyright © 2018年 崔林豪. All rights reserved.
//

import UIKit


private let collectionCellID = "collectionCellID"

protocol PageContentViewDelegate : class {
    
    func pageContentView(_ contentView : PageContentView , progress : CGFloat,  sourceIndex : Int , targetIndex : Int )
}


class PageContentView: UIView {
    
    private var childVcs : [UIViewController]
    private var startOffsetX : CGFloat = 0
    weak var delegate : PageContentViewDelegate?
    
    
    /*
     循环引用：
     homeVC 引用了 presentViewController,--->
     
     private lazy var pageContentView : PageContentView = {
     
     presentViewController 引用了 homeVC -->presentViewController : UIViewController, UIViewController就是homeVC
     
     
     
     */
    private weak var presentViewController : UIViewController?
    
    
    //MARK:- lazy
    private lazy var collectionView : UICollectionView = { [weak self ] in
       //创建layout
        let layout  = UICollectionViewFlowLayout()
        // 强解包
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: collectionCellID)
        
        collectionView.delegate = self
        
        return collectionView
    }()
    
    
    //MARK:- 自定义构造函数
    init(frame: CGRect, childVcs: [UIViewController], presentViewController : UIViewController?) {
        
        self.childVcs = childVcs
        self.presentViewController = presentViewController
        super.init(frame: frame)
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


//MARK:- 设置UI
extension PageContentView {
    private func setupUI() {
        for childVc in childVcs {
            presentViewController?.addChildViewController(childVc)
        }
        
        addSubview(collectionView)
        collectionView.frame = bounds
        
    }
}

//MARK:- UICollectionViewDataSource
extension PageContentView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellID, for: indexPath)
        
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        return cell
    }
}




//MARK:- 对外暴露的方法
extension PageContentView {
    func setCurrentIndex(currentIndex : Int) {
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
        
    }
    
}

//MARK:- 监听滚动
//MARK:- UICollectionViewDelegate
extension PageContentView : UICollectionViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startOffsetX =  scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //获取数据
        /*
         progress  进度
         sourceIndex 开始的index
         targetIndex 目标的index
         刚开始 源 是 0  目标是 1 
         
         */
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        /*
         左滑的算法
         progress = offsetx / width  得到 可能是1.2  然后要减1
         ration = offsetx / width
         ration - floor(ration)  = 0.2,  floor 取整函数
         
         右滑的算法 0.2
         ratio = offsetx / width
         ratio - floor(ratio) = 0.8
         1 - 0.8 = 0.2
         */
        
        //判断是左滑还是右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollView = scrollView.bounds.width
        print("----zuo hua---\(startOffsetX)")
        if currentOffsetX > startOffsetX {//左滑
            //计算progress
            progress = currentOffsetX / scrollView - floor(currentOffsetX / scrollView)
            
            //计算sourceindex
            sourceIndex = Int(currentOffsetX / scrollView)
            
            //计算targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            
            //如果完全划过去
            if currentOffsetX - startOffsetX == scrollView {
                progress = 1
                targetIndex = sourceIndex
            }
            
        } else {//右滑
            //计算progress
            progress = 1 - (currentOffsetX / scrollView - floor(currentOffsetX / scrollView))
            
            //计算targetindex
            targetIndex = Int(currentOffsetX / scrollView)
            
            //计算sourceindex
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count - 1
            }
            
        }
        
        //将progress/sourceindex/targetindex给titileView
        print("--pp---\(progress)---ss---\(sourceIndex)---tt--\(targetIndex)")
        
        delegate?.pageContentView(self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
    
}









