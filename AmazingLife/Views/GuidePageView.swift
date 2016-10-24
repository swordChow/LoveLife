//
//  GuidePageView.swift
//  AmazingLife
//
//  Created by sword on 16/7/26.
//  Copyright © 2016年 Chow-Chow. All rights reserved.
//

import UIKit

class GuidePageView: UIView {
    
    //引导页实现： 用户第一次下载用户，提示用户功能 或使用方法
    //实现思路：在tabBarController的view 上添加一个自定义的view
    
    //自定义ScrollView
    var scrollView : UIScrollView?
    
    var skipButton: UIButton?
    init(frame: CGRect, imageArray: NSArray) {
        super.init(frame: frame)
        
        //创建scrollView
        scrollView = UIScrollView(frame: CGRectMake(0, 0, screenWidth, screenHeight + 64))
        
        scrollView?.showsHorizontalScrollIndicator = false
        
        scrollView?.pagingEnabled = true
        
        self.addSubview(scrollView!)
        
        //设置ContentSize
        scrollView?.contentSize = CGSizeMake(CGFloat(imageArray.count) * screenWidth, 0)
        //add imageView
        for i in 0..<imageArray.count {
            
            let imageView = Factory.createImageViewWith(CGRectMake(CGFloat(i) * screenWidth, 0, screenWidth, screenHeight + 64), imageName: imageArray[i] as! String)
            self.scrollView?.addSubview(imageView)
            
            //创建一个跳转按钮
            if i == imageArray.count - 1  {
                self.skipButton = UIButton(type: .Custom)
                self.skipButton?.frame = CGRectMake(100, 100, 44, 44)
                self.skipButton?.setImage(UIImage(named: "LinkedIn"), forState: .Normal)
                
                //开启用户交互
                //UIImageView的用户交互默认是关闭的，UIView的用户交互默认是开启的
                //响应链： skipButton -> uiapplication -> window -> controller -> view -> skipButton
                imageView.userInteractionEnabled = true
                imageView.addSubview(skipButton!)
            }
            
        }
        
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
