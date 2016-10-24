//
//  MyViewController.swift
//  AmazingLife
//
//  Created by sword on 16/7/26.
//  Copyright © 2016年 Chow-Chow. All rights reserved.
//

import UIKit

class MyViewController: RootViewController, UITableViewDataSource, UITableViewDelegate {
    //夜间模式
    var nightView = UIView()
    
    var tableView = UITableView()
    
    var headerImgaeView = UIImageView()
    //图片原始高度
    let imageOriginalHeight :CGFloat = 200.0
    //图标数组
    var imageArray = NSArray()
    
    var titleArray = NSArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleLabel?.text = "我的"
        
        self.imageArray = ["iconfont-iconfontaixinyizhan","iconfont-lajitong","iconfont-yejianmoshi","iconfont-zhengguiicon40","iconfont-guanyu"]
        self.titleArray = ["我的喜欢","清理缓存","夜间模式","推送消息","关于"]
        createUI()
        
        
    }
    //MARK:UI
    func createUI() {
        self.tableView = UITableView(frame: CGRectMake(0, 0, screenWidth, screenHeight), style: .Plain)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.view.addSubview(tableView)
        //取消多余的线条
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorColor = UIColor.RGBAlpha(255, 156, 187)
        //imageView
        
        self.headerImgaeView = Factory.createImageViewWith(CGRectMake(0, -imageOriginalHeight, screenWidth ,imageOriginalHeight), imageName: "welcome1")
        self.tableView.addSubview(headerImgaeView)
        //设置tableView的内容，从图片的下方开始显示,UIEdgeInsetsMake 表示的是距离边界的距离，是一个相对值，参数表示上左下右
        self.tableView.contentInset = UIEdgeInsetsMake(imageOriginalHeight, 0, 0, 0)
        
        
        //注册cell
        self.tableView.registerClass(UITableViewCell.self , forCellReuseIdentifier: "myCell")
        //创建夜间模式
        self.nightView = UIView(frame: self.view.bounds)
        
        
        
    }
    //MARK:实现代理方法
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("myCell", forIndexPath: indexPath)
        //设置尾部控件
        
        if indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 4 {
            cell.accessoryType = .DisclosureIndicator
        }
        else {
            //创建switch 按钮
            let swi = UISwitch(frame: CGRectMake(screenWidth - 70, 5, 60, 34))
            //内嵌颜色
           // swi.onTintColor = UIColor.greenColor()
            //边框颜色
           // swi.tintColor = UIColor.redColor()
            swi.tag = indexPath.row
            cell.addSubview(swi)
            //cell.contentView.addSubview(swi)
            //添加响应事件
            
            swi.addTarget(self, action: "changeValue:", forControlEvents: .ValueChanged)
        }
        //赋值
        cell.imageView?.image = UIImage(named: self.imageArray[indexPath.row] as! String)
        
        cell.textLabel?.text = self.titleArray[indexPath.row] as! String
        
        return cell
    }
    func changeValue(sender: UISwitch) {
        if sender.tag == 2 {
            //出现夜间模式
            //关闭nightvIEW 交互
            self.nightView.userInteractionEnabled = false
            //设置背景颜色
            self.nightView.backgroundColor = UIColor(white: 0, alpha: 0.2)
            
            //将nightView 添加到window
            //获取window
            let app = UIApplication.sharedApplication()
            let delegate = app.delegate as! AppDelegate
            delegate.window?.addSubview(nightView)
        }
        else {
            self.nightView.removeFromSuperview()
        }
        
    }
    //MARK :放大效果
    func scrollViewDidScroll(scrollView: UIScrollView) {
        //通过tableView滑动的时候，获取它的偏移量，通过偏移量来改变头部图片的大小
        if  scrollView == self.tableView {
            //获取scrollView偏移量
            //纵向
            let yOffset = scrollView.contentOffset.y
            //横向 随着纵向偏移量的变化而变化
            let xOffset = (imageOriginalHeight + yOffset) / 2
            if yOffset < -imageOriginalHeight {
                var  rect = self.headerImgaeView.frame
                //纵坐标
                rect.origin.y = yOffset
                rect.size.height = -yOffset
                rect.origin.x = xOffset
                rect.size.width = screenWidth + fabs(xOffset) * 2
                self.headerImgaeView.frame = rect
                
            }
            
        }
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
