//
//  HomeViewController.swift
//  BettasLiveSwiftTest
//
//  Created by 崔林豪 on 2018/8/21.
//  Copyright © 2018年 崔林豪. All rights reserved.
//

import UIKit

private let kTitleViewH : CGFloat = 40


class HomeViewController: UIViewController {

    //MARK:- 懒加载属性
    private lazy var pagetitleView : PageTitleView = { [weak self] in
        
        let titleFrame = CGRect(x: 0, y: kStatuesBarH + kNavigationBarH, width: UIScreen.main.bounds.width, height: kTitleViewH)
        
        let titles = ["推荐", "游戏", "娱乐","趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        
        return titleView
    }()
    
    private lazy var pageContentView : PageContentView = {
       
        let contentH = kScreenH - kStatuesBarH - kNavigationBarH - kTitleViewH - kTabBarH
        let contentFrame = CGRect(x: 0, y: kStatuesBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: contentH)
        
        var childVcs = [UIViewController]()
        childVcs.append(RecommendViewController())
        
        for _ in 0..<3 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)

        }
        
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, presentViewController: self)
        contentView.delegate = self
        
        
        return contentView
    }()
    
    //MARK:- 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        view.addSubview(pagetitleView)
        
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.red
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


//MARK:-  遵守协议 Delegate
extension HomeViewController : PageTitleViewDelegate {
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int) {
        print("++++++++\(index)")
        pageContentView.setCurrentIndex(currentIndex: index)
        
    }
}

extension HomeViewController : PageContentViewDelegate {
    func pageContentView(_ contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pagetitleView.setTitleWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        
    }
}

extension HomeViewController {
    
    //MARK:- 设置UI
    private func setupUI() {
        
        setupNavi()
    }
    
    //MARK:- 设置导航
    private func setupNavi() {
        
        //设置左侧item
        //let btn = UIButton()
        //btn.setImage(UIImage(named: "logo"), for: .normal)
        //navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        //设置右侧item
        let size = CGSize(width: 40, height: 40)
        
        let historyItem  = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        
        let searchItem  = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        
        let qrcodeItem  = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        
        
        //let historyItem = UIBarButtonItem(imageName: "image_my_history", heightImageName: "Image_my_history_click", size: size)
        
        //let searchItem = UIBarButtonItem(imageName: "btn_search", heightImageName: "btn_search_clicked", size: size)
        
        //let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", heightImageName: "Image_scan_click", size: size)
        
        
        
        
        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
    }
    
}
