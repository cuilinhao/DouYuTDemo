//
//  AmuseMenuView.swift
//  BettasLiveSwiftTest
//
//  Created by 崔林豪 on 2018/9/20.
//  Copyright © 2018年 崔林豪. All rights reserved.
//

import UIKit


//MARK:- ******************************

/*
 
 设计思想： UICollectionView 里面再嵌套一个UICollectionView
 
 */


//MARK:- ******************************


private let kMemuCellID = "kMemuCellID"

class AmuseMenuView: UIView {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK:- 定义属性
    
    var groups : [AnchorGroupModel]? {
        
        didSet {
            
            collectionView.reloadData()
        }
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
         autoresizingMask = UIViewAutoresizing()
        
        //collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kMemuCellID)
        collectionView.register(UINib(nibName: "AmuseCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kMemuCellID)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.itemSize = collectionView.bounds.size
        layout.scrollDirection = .horizontal
        
    }

}


extension AmuseMenuView {
    
    class func  loadAmuseMenuView () -> AmuseMenuView  {
        
        return Bundle.main.loadNibNamed("AmuseMenuView", owner: nil, options: nil)?.first as! AmuseMenuView
    }
    
}

extension AmuseMenuView : UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if groups == nil {
            return 0
        }
        
        let pageNumber = (groups!.count - 1) / 8 + 1
        
        pageControl.numberOfPages = pageNumber
        
        return pageNumber
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //取出cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kMemuCellID, for: indexPath) as! AmuseCollectionViewCell
        
        //为cell赋值
        //cell.backgroundColor = UIColor.randomColor()
        
        setupCellDataWithCell(cell: cell, indexPath: indexPath)
        
        return cell
    }
    
    private func setupCellDataWithCell(cell : AmuseCollectionViewCell, indexPath : IndexPath) {
        /**
         从0页 取到 7页
         startIndex 第几页 * 8
         endIndex 默认从0 开始  0页 +1 = 1 1 * 8 = 8  8- 1 = 7
         2页 2 + 1 = 3  3 *8 = 24 24 -1 = 23
         
         **/
        
        //0页 ： 0 -7
        //1页 ： 8 - 15
        //2页 ： 16 - 23
        //取出起始位置 & 终点位置
        let startIndex = indexPath.item * 8
        var endIndex = (indexPath.item + 1 ) * 8 - 1
        
        //判断越界问题
        if endIndex > groups!.count - 1 {
            endIndex = groups!.count - 1
        }
        
        //取出数据，并赋值给cell
        cell.groups = Array(groups![startIndex...endIndex])
        
    }
    
    
}
