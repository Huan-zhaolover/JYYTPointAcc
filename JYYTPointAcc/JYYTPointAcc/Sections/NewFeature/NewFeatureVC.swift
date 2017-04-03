//
//  NewFeatureVC.swift
//  JYYTPointAcc
//
//  Created by shjyyt on 2017/4/3.
//  Copyright © 2017年 shjy. All rights reserved.
//

import UIKit

private let reuseIdentifier = "NewFeatureCell"

class NewFeatureVC: UICollectionViewController {

    let Layout = NewFeatureLayout()
    var imageArry : NSArray?
    init(){
        super.init(collectionViewLayout: Layout)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(NewFeatureCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return (imageArry?.count)!
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : NewFeatureCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! NewFeatureCell
        cell.imageView.image = UIImage.init(named: imageArry![indexPath.item] as! String)
        return cell
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
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpCellUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpCellUI(){
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        contentView.addSubview(imageView)
        // 2.布局子控件的位置
      _ =  imageView.YT_Fill(referView: contentView)
    }
}



