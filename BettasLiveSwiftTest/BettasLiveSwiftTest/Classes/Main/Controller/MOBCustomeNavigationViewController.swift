//
//  MOBCustomeNavigationViewController.swift
//  BettasLiveSwiftTest
//
//  Created by 崔林豪 on 2018/9/29.
//  Copyright © 2018年 崔林豪. All rights reserved.
//

import UIKit

class MOBCustomeNavigationViewController: UINavigationController {

    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //获取系统的pop手势
        guard let  systemGes = interactivePopGestureRecognizer else {
            return
        }
        
        //获取手势添加到的view 中
        guard let gesView = systemGes.view else {
            return
        }
        
        //获取target/action
        //利用运行时机制查看所有的属性名称
        var count : UInt32 = 0
        let ivars = class_copyIvarList(UIGestureRecognizer.self, &count)!
        /*
         ++++++++++++_gestureFlags
         ++++++++++++_targets
         ++++++++++++_delayedTouches
         ++++++++++++_delayedPresses
         ++++++++++++_view
         ++++++++++++_lastTouchTimestamp
         ++++++++++++_firstEventTimestamp
         ++++++++++++_state
         ++++++++++++_allowedTouchTypes
         ++++++++++++_initialTouchType
         ++++++++++++_internalActiveTouches
         ++++++++++++_forceClassifier
         ++++++++++++_requiredPreviewForceState
         ++++++++++++_touchForceObservable
         ++++++++++++_touchForceObservableAndClassifierObservation
         ++++++++++++_forceTargets
         ++++++++++++_forcePressCount
         ++++++++++++_beganObservable
         ++++++++++++_failureRequirements
         ++++++++++++_failureDependents
         ++++++++++++_activeEvents
         ++++++++++++_keepTouchesOnContinuation
         ++++++++++++_delegate
         ++++++++++++_allowedPressTypes
         ++++++++++++_name
         ++++++++++++_gestureEnvironment
         */
        for i in 0..<count {
            let ivar = ivars[Int(i)]
            //name 是一个指针
            let name = ivar_getName(ivar)
            //指针转成字符串
            print("++++++++++++\(String(cString: name!))")
        }
        
        let targets = systemGes.value(forKey: "_targets") as? [NSObject]
        /*
         (lldb) po targets
         ▿ Optional<Array<NSObject>>
         ▿ some : 1 element
         - 0 : (action=handleNavigationTransition:, target=<_UINavigationInteractiveTransition 0x7ff45d11deb0>)
         */
        guard let targetObject = targets?.first else {
            return
        }
        //------->>>>>>>>(action=handleNavigationTransition:, target=<_UINavigationInteractiveTransition 0x7fc5cec24a40>)
        print("------->>>>>>>>\(targetObject)")
        
        //取出target
        guard let target = targetObject.value(forKey: "target") else {
            return
        }
        /*
         (lldb) po targetObject
         (action=handleNavigationTransition:, target=<_UINavigationInteractiveTransition 0x7fe3ae6308c0>)
         */
        
        //取出action
        let action = Selector(("handleNavigationTransition:"))

        //创建自己pan手势
        let panGes  = UIPanGestureRecognizer()
        gesView.addGestureRecognizer(panGes)
        panGes.addTarget(target, action: action)
        
        
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        //隐藏要push的控制器的tabbar
        viewController.hidesBottomBarWhenPushed = true
        
        super.pushViewController(viewController, animated: animated)
        
    }
    

   

}
