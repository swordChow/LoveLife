//
//  MusicDetailCell.swift
//  AmazingLife
//
//  Created by sword on 16/7/28.
//  Copyright © 2016年 Chow-Chow. All rights reserved.
//

import UIKit

class MusicDetailCell: UITableViewCell {

    @IBOutlet weak var mainImageView: UIImageView!
    
    @IBOutlet weak var musicNameLabel: UILabel!
    
    @IBOutlet weak var authorNameLabel: UILabel!
    
    var musicModel : MusicModel! {
        
        didSet {
            mainImageView.sd_setImageWithURL(NSURL(string: musicModel.coverURL!), placeholderImage: UIImage(named: "1.jpeg"))
            
            musicNameLabel.text = musicModel.title!
            authorNameLabel.text = musicModel.artist!
            
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
