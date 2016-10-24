//
//  FoodCell.swift
//  AmazingLife
//
//  Created by sword on 16/7/28.
//  Copyright © 2016年 Chow-Chow. All rights reserved.
//

import UIKit
//如果要实现自定义的cell 或者View 里面点击跳转页面的操作，需要用到代理或者通知来实现

//用代理方式实现传值， class表示只让类来遵循协议，在swift中，类、结构体、枚举都可以遵循协议


//
protocol PlayVideo: class  {
    //声明代理方法
    func playVideoWithUrl(videoUrl: String)
    
}

class FoodCell: UICollectionViewCell {
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var detailLabel: UILabel!
    
    //定义遵循协议的对象，使用weak 关键字进行修饰，防止内存泄漏
    weak var delegate: PlayVideo?
    
    var model : FoodModel! {
        didSet {
            self.mainImageView.sd_setImageWithURL(NSURL(string: model.image!), placeholderImage: UIImage(named: "1.jpeg"))
            self.titleLabel.text = model.title
            self.detailLabel.text = model.detail
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func playButtonClicked(sender: AnyObject) {
        
        self.delegate?.playVideoWithUrl((model.video!))
    }
    

}
