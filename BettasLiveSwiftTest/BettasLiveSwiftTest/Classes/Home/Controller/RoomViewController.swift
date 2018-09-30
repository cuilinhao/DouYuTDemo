//
//  RoomViewController.swift
//  BettasLiveSwiftTest
//
//  Created by 崔林豪 on 2018/9/29.
//  Copyright © 2018年 崔林豪. All rights reserved.
//

import UIKit

class RoomViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.randomColor()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //这样写的话，不会有返回的手势， 会把默认的返回手势隐藏掉
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        //依然保持手势
        //navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
       //navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        
    }


}
