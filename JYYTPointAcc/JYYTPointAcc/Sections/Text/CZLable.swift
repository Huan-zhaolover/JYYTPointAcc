//
//  CZLable.swift
//  JYYTPointAcc
//
//  Created by shjyyt on 2017/5/10.
//  Copyright © 2017年 shjy. All rights reserved.
//

import UIKit
// 默认不能实现垂直顶部对齐，使用TextKit

class CZLable: UILabel {
 
    // 属性文本存储  是 NSMutableAttributedString子类
    private lazy var textStore = NSTextStorage()
    // 负责文本“字形”布局
    private lazy var layoutManager = NSLayoutManager()
    // 设定文本绘制的的范围
    private lazy var textContainer = NSTextContainer ()
    // 构造函数
    override init(frame: CGRect) {
         super.init(frame: frame)
        prepareTextSystem()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareTextSystem()
    }
    // 绘制文本
    // 绘制类似油画，后绘制的内容，会把之前绘制的内容覆盖
    override func drawText(in rect: CGRect) {
        let range  = NSRange(location: 0, length: textStore.length)
        // 绘制背景
        layoutManager.drawBackground(forGlyphRange: range, at: CGPoint())
        // drawGlyphs 字形
        layoutManager.drawGlyphs(forGlyphRange: range, at: CGPoint())
        //
    }
    

    override func layoutSubviews() {
         super.layoutSubviews()
        //指定绘制文本的区域
        textContainer.size = bounds.size
        
    }
    
    func prepareTextSystem(){
        // 1.准备文本
        prepareTextContent()
        // 2.设置对象关系
        textStore.addLayoutManager(layoutManager)
        layoutManager.addTextContainer(textContainer)
    
    }
    // 设置属性文本 添加到 textStore 中,接管UIlable的内容
    func prepareTextContent(){
        if let attribu =  attributedText{
            textStore.setAttributedString(attribu)
        }else if let atext = text{
            textStore.setAttributedString(NSAttributedString(string: atext))
        }else{
            textStore.setAttributedString(NSAttributedString(string: ""))
        }
    
    }
    
    var urlRanges:[NSRange]?{
        let pattenr = "[a-zA-Z]*://[a-zA-Z0-9/\\.]*"
     
       
        guard let reg = try? NSRegularExpression(pattern: pattenr, options: []) else {
            return nil
        }
        // 多重匹配
        let matches = reg.matches(in: textStore.string, options: [], range: NSRange(location: 0, length: textStore.length))
        var ranges = [NSRange]()
        
        for m in matches {
             ranges.append(m.rangeAt(0))
        }
        
        return ranges
//        return [NSRange()]
    }
    
    // UILable 的点击
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: self) else {
             return
        }
        // 获取点击的索引
        let index = layoutManager.glyphIndex(for: location, in: textContainer)
        // 判断 indx 是不是再urlRanges范围内，如果在就高亮
        for urlrange in urlRanges ?? [] {
            if NSLocationInRange(index, urlrange) {
                 // 点击了高亮
                textStore.addAttributes([NSForegroundColorAttributeName:UIColor.red], range: urlrange)
                // 需要重绘，调用setNeedsDisplay函数，但是不是drawrect
                setNeedsDisplay()
            }else{
                // 不在范围内
            }
        }
        
    }
    
}
