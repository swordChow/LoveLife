//
//  HomeCell.swift
//  AmazingLife
//
//  Created by sword on 16/7/26.
//  Copyright © 2016年 Chow-Chow. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {
    
    @IBOutlet weak var imageVIew: UIImageView!

    @IBOutlet weak var titleLabel: UILabel!
    
    //声明一个model 属性
    var model: HomeModel! {
        //可以监听属性的变化
        //willSet didSet
        didSet {
            //利用model 字段赋值
            imageVIew.sd_setImageWithURL(NSURL(string: model.pic!), placeholderImage: UIImage(named: "1"))
            titleLabel.text = model.title
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
