//
//  FoodTitleCell.swift
//  AmazingLife
//
//  Created by sword on 16/7/28.
//  Copyright © 2016年 Chow-Chow. All rights reserved.
//

import UIKit

class FoodTitleCell: UICollectionViewCell {
    
    //iOS8之后，自定义的cell 和view的初始化方法都需要自己来写，在iOS8之前，系统已经处理好
    //重写父类的构造方法
    
    var titleLabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       self.titleLabel = Factory.createLabelWith(CGRectMake(10, 0, (screenWidth - 60) / 2, 30), text: "", font: UIFont.systemFontOfSize(15), textAlignment: .Center, textColor: UIColor.whiteColor())
        self.titleLabel.backgroundColor = UIColor.RGBAlpha(255, 156, 187)
        
        self.contentView.addSubview(titleLabel)
        
    }
    
    //必须实现的构造方法
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
