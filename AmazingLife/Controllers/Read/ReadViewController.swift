//
//  ReadViewController.swift
//  AmazingLife
//
//  Created by sword on 16/7/26.
//  Copyright © 2016年 Chow-Chow. All rights reserved.
//

import UIKit

class ReadViewController: RootViewController , UIScrollViewDelegate{
    
    var scrollView = UIScrollView()
    //分段控件
    var segment = UISegmentedControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createNav()
        createUI()
    }
    
    func createUI() {
        
        //创建scrollView
        scrollView = UIScrollView(frame: CGRectMake(0,0,screenWidth,screenHeight))
        scrollView.delegate = self
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.pagingEnabled = true
        scrollView.bounces = false
        
        self.view.addSubview(scrollView)
        //contentSize
        self.scrollView.contentSize = CGSizeMake(2 * screenWidth, 0)
        
        //实例化子控制器
        let articleVC = ArticleViewController()
        articleVC.view.backgroundColor = UIColor.greenColor()
        
        let musicVC = MusicViewController()
        //musicVC.view.backgroundColor = UIColor.magentaColor()
        
        let array = [articleVC, musicVC]
        for i in 0..<array.count {
            let vc = array[i]
            vc.view.frame = CGRectMake(CGFloat(i) * screenWidth, 0, screenWidth, screenHeight)
            //将子控制器作为当前控制器的childvc
            self.addChildViewController(vc)
            self.scrollView.addSubview(vc.view)
            
        }
        
        
        
        
    }
    
    func createNav() {
        self.segment = UISegmentedControl(frame: CGRectMake(0, 0, 100, 30))
        //
        self.segment.insertSegmentWithTitle("看美文", atIndex: 0, animated: true)
        self.segment.insertSegmentWithTitle("听音乐", atIndex: 1, animated: true)
        //设置笔触颜色
        self.segment.tintColor = UIColor.whiteColor()
        //将segment设置为导航的titlevIew
        self.navigationItem.titleView = self.segment
        
        //添加响应事件
        
        self.segment.addTarget(self, action: #selector(changeValues(_ :)), forControlEvents: .ValueChanged)
        //默认选中第一个
        self.segment.selectedSegmentIndex = 0
        
    }
    //MARK:segment响应事件
    func changeValues(segment:UISegmentedControl) {
        //关联scrollView
        self.scrollView.contentOffset = CGPointMake(CGFloat(segment.selectedSegmentIndex) * screenWidth, 0)
        
    }
    //MARK:scrollView反向关联
    /*func scrollViewDidScroll(scrollView: UIScrollView) {
        let index = scrollView.contentOffset.x / screenWidth
        //
        segment.selectedSegmentIndex = Int(index)
    }
   */
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        let index = scrollView.contentOffset.x / screenWidth
        //
        segment.selectedSegmentIndex = Int(index)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
