//
//  HGPageTitleView.swift
//  HG_DUZB
//
//  Created by day-day-Smile on 2017/12/21.
//  Copyright © 2017年 day-day-Smile. All rights reserved.
//

import UIKit

 @objc protocol HGPageTitleViewDelegate {
    func pageTtileView(titleView:HGPageTitleView,selectedIndex index:Int)
}

private let  kScrollLineH:CGFloat = 2
/// 元祖 - 渐变色
private let kNormalColor:(CGFloat,CGFloat,CGFloat) = (85,85,85)
private let kSelectColor:(CGFloat,CGFloat,CGFloat) = (255,128,0)

class HGPageTitleView: UIView {

    /// 定义属性
    private var titles:[String]
    fileprivate var cureentIndex:Int = 0
    
    private var titleLabels:[UILabel] = [UILabel]()
    
    /// 代理协议
    weak var delegate:HGPageTitleViewDelegate?
    
    /// 懒加载属性
    lazy var scrollView:UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        /// 主要用于点击设备的状态栏时,是scrollsToTop == YES的控件滚动返回至顶部
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
            label.textColor = UIColor.init(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            label.textAlignment = .center
            
            /// 3. sehzhiframe
            let labelX:CGFloat = labelW * CGFloat(index)
            
            label.frame = CGRect.init(x: labelX, y: labelY, width: labelW, height: labelH)
            
            /// 4. 添加到scrollView
            scrollView.addSubview(label)
            /// 5. 添加到数组中，便于取到第一个 label的宽度
            titleLabels.append(label)
            
            /// 4. 给每个label添加手势
            label.isUserInteractionEnabled = true
            let gest  = UITapGestureRecognizer(target: self, action: #selector(titleLabelCilckTap(tapGes:)))
            label.addGestureRecognizer(gest)
        }
    }
    
    private func setButtomLineAndScrollLine(){
        /// 1. 添加底线
        let buttomLine = UIView()
        buttomLine.backgroundColor = UIColor.lightGray
        let lineH:CGFloat = 0.5
        
        buttomLine.frame = CGRect.init(x: 0, y: frame.height - lineH , width: frame.width, height: lineH)
        addSubview(buttomLine)
        
        /// 2.添加scrollLine
       guard let fistLanel = titleLabels.first else{
            return
        }
        fistLanel.textColor = UIColor.init(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        
        /// 2.1 设置scrollView属性
        scrollView.addSubview(scrollLine)
        
        scrollLine.frame = CGRect(x: fistLanel.frame.origin.x, y: frame.height - kScrollLineH, width: fistLanel.frame.width, height: kScrollLineH)
    }
    
}

// MARK: - 手势 监听label点击
extension HGPageTitleView {
    @objc func titleLabelCilckTap(tapGes:UITapGestureRecognizer) {
        /// 1. 获取当前label  (view 就是当前点击的label )
        guard let currentLabel = tapGes.view as? UILabel else{
            return
        }
        /// 如果重复点击同一个title，颜色不变
        if currentLabel.tag == cureentIndex {
            return
        }
        /// 2. 获取之前的label
        let oldLabel = titleLabels[cureentIndex]
        /// 3. 设置文字颜色
        currentLabel.textColor = UIColor.init(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        oldLabel.textColor = UIColor.init(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        
        /// 4. 保存最新label的下标值
        cureentIndex = currentLabel.tag
        
        /// 5. 滚动条位置发生改变
        let scrollLineX = CGFloat(currentLabel.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.25) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        /// 通知代理
        delegate?.pageTtileView(titleView: self, selectedIndex: cureentIndex)
    }
}

extension HGPageTitleView {
    @objc func setTitleWithProgress(progress:CGFloat,sourceIndex:Int,targetIndex:Int){
        /// 取出sourceLabel/targetLabel
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        /// 处理滑块的逻辑
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        /// 进度
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        /// 3.颜色的渐变（复杂）
        /// 3.1 取出变化的范围
        let colorDelta = (kSelectColor.0 - kNormalColor.0,kSelectColor.1 - kNormalColor.1,kSelectColor.2 - kNormalColor.2)
        /// 3.2 变化sourceLabel
        sourceLabel.textColor = UIColor.init(r: kSelectColor.0 - colorDelta.0 * progress, g: kSelectColor.1 - colorDelta.1 * progress, b: kSelectColor.2 - colorDelta.2 * progress)
        /// 3.3 变化targetLabel
        targetLabel.textColor = UIColor.init(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        /// 4. 把目标字体颜色记录
        cureentIndex = targetIndex
    }
    
}
