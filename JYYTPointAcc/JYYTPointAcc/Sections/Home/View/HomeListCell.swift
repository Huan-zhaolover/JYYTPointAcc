//
//  HomeListCell.swift
//  JYYTPointAcc
//
//  Created by shjyyt on 2017/5/6.
//  Copyright © 2017年 shjy. All rights reserved.
//

import UIKit

class HomeListCell: UITableViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var bookNameLable: UILabel!
    @IBOutlet weak var personCountLable: UILabel!

    var listViewModel:AccBookVM?{
        didSet{
        
            iconImageView.image = UIImage(named: (listViewModel?.aModel?.photo_path)!)
            bookNameLable.text = listViewModel?.aModel?.short_name
            personCountLable.text = listViewModel?.personCount
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = superview?.backgroundColor
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
