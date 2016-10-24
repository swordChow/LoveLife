//
//  RootViewController.swift
//  AmazingLife
//
//  Created by sword on 16/7/26.
//  Copyright © 2016年 Chow-Chow. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    //标题
    var titleLabel: UILabel?
    
    //左、右按钮
    var leftButton: UIButton?
    var rightButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //设置背景颜色
        self.view.backgroundColor = UIColor.whiteColor()
        //设置导航不透明
        self.navigationController?.navigationBar.translucent = false
        //设置导航颜色
        self.navigationController?.navigationBar.barTintColor = UIColor.RGBAlpha(255, 156, 187)
        
        //方法一： 修改状态栏的颜色
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        //标题
        titleLabel = Factory.createLabelWith(CGRectMake(0, 0, 100, 44), text: "", font: UIFont.boldSystemFontOfSize(20), textAlignment: .Center, textColor: UIColor.whiteColor())
        self.navigationItem.titleView = titleLabel
        
        //左按钮
        self.leftButton = Factory.createButtonWith(CGRectMake(0, 0, 44, 44), type: .Custom, title: "", titleColor: UIColor.whiteColor(), imageName: "", target: nil , action: "", backgroundImageName: "")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: self.leftButton!)
        //右按钮
        self.rightButton = Factory.createButtonWith(CGRectMake(0, 0, 44, 44), type: .Custom, title: "", titleColor: UIColor.whiteColor(), imageName: "", target: nil , action: "", backgroundImageName: "")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.rightButton!)
        
    }
    //左按钮的响应事件
    
    func addLeftTarget(selector: Selector) {
        
        self.leftButton?.addTarget(self, action: selector, forControlEvents: .TouchUpInside)
        
    }
    //右按钮响应事件
    
    func addRightTarget(selector: Selector) {
        
        self.rightButton?.addTarget(self, action: selector, forControlEvents: .TouchUpInside)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    

    
}
