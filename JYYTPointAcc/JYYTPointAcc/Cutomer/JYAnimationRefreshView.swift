//
//  JYAnimationRefreshView.swift
//  JYYTPointAcc
//
//  Created by shjyyt on 2017/5/4.
//  Copyright © 2017年 shjy. All rights reserved.
//

import UIKit

class JYAnimationRefreshView: JYNomalRefreshView {

    @IBOutlet weak var bulidingIconView: UIImageView!
    @IBOutlet weak var earthIconView: UIImageView!
    @IBOutlet weak var kangronIconView: UIImageView!
   
    override var parentViewHigh: CGFloat {
        didSet{
            print("\(parentViewHigh)")
            
            // 根据高度 实现子视图的动画
            
            if parentViewHigh<23 {
                 return
            }
            var scale:CGFloat

            if parentViewHigh > 126 {
                 scale = 1
            }else{
            scale = 1-(126-parentViewHigh)/(126-23)
                
            }
            kangronIconView.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
        
    }
    override func awakeFromNib() {
        
        let buding1 = UIImage(named: "buding1")
        let buding2 = UIImage(named: "buding2")
        //  两张图合成1张动图
        bulidingIconView.image = UIImage.animatedImage(with: [buding1!,buding2!], duration: 0.25);
        
        // 增加旋转动画
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        
        animation.toValue = -Double.pi*2
        animation.duration = 2
        animation.repeatCount = MAXFLOAT
        animation.isRemovedOnCompletion = false
        earthIconView.layer.add(animation, forKey: nil)
        
        // 设置锚点
        kangronIconView.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        let x  = self.bounds.width * 0.5
        let y = self.bounds.height - 23
        kangronIconView.center = CGPoint(x: x, y: y)
        kangronIconView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        
        
        
    }
    
    
    

}
