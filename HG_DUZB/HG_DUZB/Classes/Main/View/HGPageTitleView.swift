//
//  HGPageTitleView.swift
//  HG_DUZB
//
//  Created by day-day-Smile on 2017/12/21.
//  Copyright © 2017年 day-day-Smile. All rights reserved.
//

import UIKit

private let  kScrollLineH:CGFloat = 2

class HGPageTitleView: UIView {

    /// 定义属性
    private var titles:[String]
    
    private var titleLabels:[UILabel] = [UILabel]()
    
    /// 懒加载属性
    lazy var scrollView:UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.isPagingEnabled = false
        scrollView.bounces = false
        return scrollView
    }()
    
    private lazy var scrollLine:UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    init(frame: CGRect,titles:[String]) {

        self.titles = titles

        super.init(frame: frame)
        
        /// 设置UI界面
        self.setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - 设置UI界面
extension HGPageTitleView{
    private func setupUI(){
        /// 1.添加scrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        /// 2.添加titleView对应的label
        setTitleLabels()
        /// 3.设置底线和滚动滑块
        setButtomLineAndScrollLine()
    }
    
    private func setTitleLabels(){
       
        /// 0. 提高效率，不需要每次在循环中计算 
        let labelW:CGFloat = frame.width / CGFloat(titles.count)
        let labelH:CGFloat = frame.height - kScrollLineH
        let labelY:CGFloat = 0
        
        for (index,title) in titles.enumerated() {
            /// 1. 创建label
            let label = UILabel()
            
            /// 2. 设置属性
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.text = title
            label.tag = index
            label.textColor = UIColor.darkGray
            label.textAlignment = .center
            
            /// 3. sehzhiframe
            let labelX:CGFloat = labelW * CGFloat(index)
            
            
            label.frame = CGRect.init(x: labelX, y: labelY, width: labelW, height: labelH)
            
            /// 4. 添加到scrollView
            scrollView.addSubview(label)
            /// 5. 添加到数组中，便于取到第一个 label的宽度
            titleLabels.append(label)
        }
        
        
        
    }
    
    private func setButtomLineAndScrollLine(){
        /// 1. 添加底线
        let buttomLine = UIView()
        buttomLine.backgroundColor = UIColor.lightGray
        let lineH:CGFloat = 0.5
        print("_FUN_\(frame.height)")/// label 高度
        buttomLine.frame = CGRect.init(x: 0, y: frame.height - lineH , width: frame.width, height: lineH)
        addSubview(buttomLine)
        
        /// 2.添加scrollLine
       guard let fistLanel = titleLabels.first else{
            return
        }
        fistLanel.textColor = UIColor.orange
        
        /// 2.1 设置scrollView属性
        scrollView.addSubview(scrollLine)
        
        scrollLine.frame = CGRect(x: fistLanel.frame.origin.x, y: frame.height - kScrollLineH, width: fistLanel.frame.width, height: kScrollLineH)
    }
    
}
