//
//  MusicCell.swift
//  AmazingLife
//
//  Created by sword on 16/7/28.
//  Copyright © 2016年 Chow-Chow. All rights reserved.
//

import UIKit

class MusicCell: UICollectionViewCell {
    
    
    @IBOutlet weak var mainImageView: UIImageView!

    @IBOutlet weak var titleLabel: UILabel!
    
    var imageName :String = "" {
        didSet {
            mainImageView.image = UIImage(named: imageName)
            
        }
    }
    
    var title : String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
