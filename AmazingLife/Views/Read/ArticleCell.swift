//
//  ArticleCell.swift
//  AmazingLife
//
//  Created by sword on 16/7/27.
//  Copyright © 2016年 Chow-Chow. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {
    
    @IBOutlet weak var mainImageView: UIImageView!

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var authorLabel: UILabel!
    
    var model: ArticleModel! {
        didSet {
            mainImageView.sd_setImageWithURL(NSURL(string: model.pic!), placeholderImage: UIImage(named: "1"))
            titleLabel.text = model.title
            timeLabel.text = model.createtime
            authorLabel.text = model.author
            
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
