//
//  MainViewController.swift
//  BettasLiveSwiftTest
//
//  Created by 崔林豪 on 2018/8/21.
//  Copyright © 2018年 崔林豪. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addClibVc("Home")
        addClibVc("Live")
        addClibVc("Follow")
        addClibVc("Profile")
        
    }

    fileprivate func addClibVc ( _ stroryName : String ) {
        
        //1. 通过storyboard 获取控制器
        let childVc = UIStoryboard(name: stroryName, bundle: nil).instantiateInitialViewController()!
        
        //2. 将childVc 作为子控制器
        addChildViewController(childVc)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
