//
//  NewFeatureVC.swift
//  JYYTPointAcc
//
//  Created by shjyyt on 2017/4/3.
//  Copyright © 2017年 shjy. All rights reserved.
//

import UIKit

protocol NewFeatureVCDelegate:NSObjectProtocol {
     func startbuttonClick()
}
private let reuseIdentifier = "NewFeatureCell"

class NewFeatureVC: UIView {

    weak var newfeturedelegate:NewFeatureVCDelegate?
    var collctionView :UICollectionView?
    let Layout = NewFeatureLayout()
    var imageArry : [String]

    
    init(imageStrArry:[String]){
        let rect = CGRect(x: 0, y: 0, width: ScreenW, height: ScreenH)
        
        imageArry = imageStrArry
        collctionView = UICollectionView.init(frame: rect, collectionViewLayout: Layout)
        super.init(frame: rect)
        
        collctionView?.delegate = self
        collctionView?.dataSource = self
        collctionView?.register(NewFeatureCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    
        self.addSubview(collctionView!)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
}
// MARK: UICollectionViewDataSource
extension  NewFeatureVC:UICollectionViewDataSource,UICollectionViewDelegate{

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (imageArry.count)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : NewFeatureCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! NewFeatureCell
        // 1,2,3,4
        cell.imageView.image = UIImage.init(named: imageArry[indexPath.item] )
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //   传递的是上一个的cell  不能使用
        
        //  获取当前显示的indexpath
        let indexPa = collectionView.indexPathsForVisibleItems.last
        if (indexPa?.item)! == (imageArry.count)-1 {
            // 最后一页cell，显示动画
            let acell = collectionView.cellForItem(at: indexPa!) as! NewFeatureCell
            acell.buttonStartAnimation()
            acell.cellButton.addTarget(self, action: #selector(ClickGoHome), for: .touchUpInside)

        }
    }
    // 点击进入首页
    func ClickGoHome(){
        removeFromSuperview()
//        // 去主页, 注意点: 企业开发中如果要切换根控制器, 最好都在appdelegate中切换
//        NotificationCenter.default.post(name:SwitchRootVCNotification, object: nil)
        
    }
}

class NewFeatureLayout: UICollectionViewFlowLayout {
   
    override func prepare() {
        itemSize = UIScreen.main.bounds.size
        minimumLineSpacing = 0;
        minimumInteritemSpacing = 0;
        scrollDirection = .horizontal
        
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.isPagingEnabled = true
        collectionView?.bounces = false
    }
}
 class NewFeatureCell: UICollectionViewCell {
    
    lazy var imageView = UIImageView()
    lazy var cellButton :UIButton = {
        let bu = UIButton()
        bu.setTitle("立即体验", for: .normal)
        bu.backgroundColor = UIColor.lightGray
        bu.isHidden = true
        return bu
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpCellUI()
    }
  
    // 设置cell 布局
    func setUpCellUI(){
        contentView.addSubview(imageView)
        contentView.addSubview(cellButton)
        // 2.布局子控件的位置
      _ =  imageView.YT_Fill(referView: contentView)
        
     _ = cellButton.YT_AlignInner(type: .BottomCenter, referView: contentView, size: CGSize(width: 200, height: 40), offset:CGPoint(x: 0, y: -50));
    }
    
    // button的动画
    func buttonStartAnimation(){
        cellButton.isHidden = false
        cellButton.transform = CGAffineTransform(scaleX: 0, y: 0);
        cellButton.isUserInteractionEnabled = false

        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 10, options: UIViewAnimationOptions.init(rawValue: 0), animations: {
            self.cellButton.transform = CGAffineTransform.identity
            
        }) { (_) in
            self.cellButton.isUserInteractionEnabled = true
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



