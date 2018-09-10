//
//  PageTitleView.swift
//  BettasLiveSwiftTest
//
//  Created by 崔林豪 on 2018/8/21.
//  Copyright © 2018年 崔林豪. All rights reserved.
//

import UIKit


// MARK:- 定义常量
private let kScrollLineH : CGFloat = 2
private let kNormalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kSelectColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)

// protocol PageTitleViewDelegate : class 只能被类遵守
protocol PageTitleViewDelegate : class {
    
    func pageTitleView(titleView : PageTitleView, selectedIndex index : Int)
}


class PageTitleView: UIView {

    //fileprivate : 在当前源文件中可以访问
    fileprivate var titles : [String]
    private var currentIndex : Int = 0
    weak var delegate : PageTitleViewDelegate?
    
    //MARK:- 懒加载
    //创建一个存储label的数组
    private lazy var titlesLabs : [UILabel] = [UILabel]()
    
    private lazy var scrollView: UIScrollView  = {
       
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    
    private lazy var scrollLine : UIView = {
       let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        
        return scrollLine
    }()
    
    
    // MARK:- 自定义构造函数
    init(frame: CGRect, titles : [String]) {
        self.titles = titles
        
        super.init(frame: frame)
        
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


//MARK:------------ 设置UI界面 -----------------
extension PageTitleView {
    
    private func setupUI() {
        
        addSubview(scrollView)
        scrollView.frame = bounds
        
        //添加label
        setupTitleLabs()
        
        //滚动的线
        setupBottomScrollLine()
    }
    
    
    private  func setupTitleLabs() {
        
        //确定label的一些frame的值
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - kScrollLineH
        let labelY : CGFloat = 0
        
        
        for (index, title) in titles.enumerated() {
            
            let label = UILabel()
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = UIColor.darkGray
            label.textAlignment = .center
            
            //设置frame
            let labelX : CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            //将label 添加到scrollView中
            scrollView.addSubview(label)
            titlesLabs.append(label)
            
            //为labei 设置手势
            label.isUserInteractionEnabled = true
            let tap =  UITapGestureRecognizer(target: self, action: #selector(titleLabelTapClick(_:)))
            
            label.addGestureRecognizer(tap)
        }
    }
    

    private func setupBottomScrollLine() {
        //添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        //添加滚动线
        
        //获取第一个label
        guard let firstLabel = titlesLabs.first else {
            return
        }
        
        firstLabel.textColor = UIColor.orange
        
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
    }
}

//MARK:- 监听label

extension PageTitleView {
    
    @objc fileprivate func titleLabelTapClick(_ tap : UITapGestureRecognizer) {
        
        print("------")
        
        //获取当前label
        guard let currentLab  = tap.view as? UILabel else {
            return
        }
        
        //如果是重复点击同一个title， 那么直接返回  ?????
//        if currentLab.tag == currentIndex {
//            return
//        }
        
        //获取之前label
        let oldLabel = titlesLabs[currentIndex]
        
       //切换文字颜色
        currentLab.textColor = UIColor.orange
        oldLabel.textColor = UIColor.gray
        
        //保存最新label下标
        currentIndex = currentLab.tag
        
        //滚动条位置
        let  scrollLineX = CGFloat(currentLab.tag) * scrollLine.frame.width
        
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        //通知代理
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
        
    }
    
}

//MARK:- 对外暴露的方法

extension PageTitleView {
    func setTitleWithProgress(_ progress : CGFloat, sourceIndex : Int, targetIndex : Int) {
        
        //1.取出sourceLab源label /targetLab 目标label
        let sourceLabel = titlesLabs[sourceIndex]
        let targetLabel = titlesLabs[targetIndex]
        
        //2.处理滑块的逻辑
        /*
         一共要滑动多少x targetLabel.frame.origin.x - sourceLabel.frame.origin.x
         要滑动多少 moveToTalX * progress
         
         */
        let moveToTalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        
        let moveX = moveToTalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        //3.颜色的渐变(复杂)
        //3.1 取出变化的范围
        let colorDelta = (kSelectColor.0 - kNormalColor.0, kSelectColor.1 - kNormalColor.1, kSelectColor.2 - kNormalColor.2 )
        
        //3.2 变化sourceLabel
        sourceLabel.textColor = UIColor(r: kSelectColor.0 - colorDelta.0 * progress, g: kSelectColor.1 - colorDelta.1 * progress, b: kSelectColor.2 - colorDelta.2 * progress)
        
        //4.记录最新的index
        currentIndex = targetIndex
        
    }
}










