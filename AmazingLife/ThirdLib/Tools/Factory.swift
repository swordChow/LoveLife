//
//  Factory.swift
//  AmazingLife
//
//  Created by sword on 16/7/26.
//  Copyright © 2016年 Chow-Chow. All rights reserved.
//

import UIKit

class Factory: NSObject {
    // 工厂设计模式：使用类方法将一些基础的UI控件的属性总结归纳，方便统一修改
    //类方法实质上是在实例方法前加上static或者class 关键字
    
    //UIView
    static func createViewWith(frame:CGRect) -> UIView {
        
        let view = UIView(frame: frame)
        return view
    }
    
    //UILabel
    static func createLabelWith(frame: CGRect, text: String, font: UIFont, textAlignment: NSTextAlignment, textColor: UIColor) -> UILabel {
        
        let label = UILabel(frame: frame)
        label.text = text
        label.textColor = textColor
        label.textAlignment = textAlignment
        label.font = font
        
        return label
        
    }
    //UIButton
    static func createButtonWith(frame: CGRect,type: UIButtonType, title: String,titleColor: UIColor, imageName: String,target: AnyObject?, action: Selector, backgroundImageName: String) -> UIButton {
        
        let button = UIButton(type: type)
        button.frame = frame
        button.setTitle(title, forState: .Normal)
        button.setTitleColor(titleColor, forState: .Normal)
        //Set Image
        button.setImage(UIImage(named: imageName), forState: .Normal)
        //Set backgroudImage
        button.setBackgroundImage(UIImage(named: backgroundImageName), forState: .Normal)
        //Set Action
        button.addTarget(target, action: action, forControlEvents: .TouchUpInside)
        
        return button
        
    }
    //UIImageView
    static func createImageViewWith(frame: CGRect, imageName: String) -> UIImageView {
        
        let imageView = UIImageView(frame: frame)
        imageView.image = UIImage(named: imageName)
        
        return imageView
    }
    
    //TextField
    static func createTextFieldWith(frame: CGRect, text: String, placeholder: String) -> UITextField {
        
        let textField = UITextField(frame: frame)
        textField.text = text
        textField.placeholder = placeholder
        
        return textField
    }

}









