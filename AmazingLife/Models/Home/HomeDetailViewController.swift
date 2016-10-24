//
//  HomeDetailViewController.swift
//  AmazingLife
//
//  Created by sword on 16/7/26.
//  Copyright © 2016年 Chow-Chow. All rights reserved.
//

import UIKit

class HomeDetailViewController: RootViewController, UITableViewDelegate, UITableViewDataSource {
    
    //数据ID
    var dataID = ""
    
    var tableView = UITableView()
    
    //头部图片
    var headerImageView = UIImageView()
    //头部文字描述
    var headerTitleLabel = UILabel()
    //头部字典
    var dataDic = NSMutableDictionary()
    //tableview
    var dataArray = NSMutableArray()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置导航
        resetNav()
        //创建UI
        createUI()
        
        //请求数据
        getData()
        
    }
    //
    func getData() {
        
        let manager = AFHTTPSessionManager()
        manager.GET("http://open4.bantangapp.com/topic/info?client_id=bt_app_android&client_secret=ffcda7a1c4ff338e05c42e7972ba7b8d&id=\(self.dataID)", parameters: nil , success: { (dataMask:NSURLSessionDataTask?, responseObject: AnyObject?) in
            //print(responseObject)
            //头部数据
            let dic = responseObject?.objectForKey("data")
            self.dataDic = dic as! NSMutableDictionary
            //print(self.dataDic)
            
            //tableview 
            self.dataArray = self.dataDic.objectForKey("product") as! NSMutableArray
            
            //刷新UI
            //头部
            self.reloadHeaderView()
            
            //
            self.tableView.reloadData()
            
        }) { (dataMask:NSURLSessionDataTask?, error:ErrorType?) in
            
        }
    }
    
    //刷新头部数据
    func reloadHeaderView() {
        
        self.headerImageView.sd_setImageWithURL(NSURL(string:self.dataDic["pic"] as!String ), placeholderImage: UIImage(named: ""))
        self.headerTitleLabel.text = self.dataDic["desc"] as? String
        
    }
    //MARK:创建UI
    func createUI() {
        
        //tableView
        self.tableView = UITableView(frame: CGRectMake(0, 0, screenWidth, screenHeight), style: .Plain)
        //delegate datasources
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(tableView)
        
        //头部图片
        self.headerImageView = Factory.createImageViewWith(CGRectMake(0, 0, screenWidth, screenHeight / 3), imageName: "")
        //头部文字描述
        self.headerTitleLabel = Factory.createLabelWith(CGRectMake(0, 0, screenWidth, screenHeight / 3), text: "", font: UIFont.systemFontOfSize(14), textAlignment: .Left, textColor: UIColor.whiteColor())
        self.headerTitleLabel.backgroundColor = UIColor(white: 0, alpha: 0.3)
        
        //行数
        self.headerTitleLabel.numberOfLines = 0
        //折行方式
        self.headerTitleLabel.lineBreakMode = .ByWordWrapping
        
        self.headerImageView.addSubview(headerTitleLabel)
        
        self.tableView.tableHeaderView = self.headerImageView
        
        //注册cell 
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "homeDetailCell")
        
    }
    //MARK:代理方法
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.dataArray.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //取出每一个section的数组
        let sectionArray = self.dataArray[section]["pic"]
        return sectionArray!!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("homeDetailCell", forIndexPath: indexPath)
        //创建imageView 
        let imageView = UIImageView(frame: CGRectMake(10, 10, screenWidth - 20, 180))
        cell.contentView.addSubview(imageView)
        
        //赋值
        let sectionArray = self.dataArray[indexPath.section]["pic"]
        let pic = sectionArray!![indexPath.row]["pic"]
        imageView.sd_setImageWithURL(NSURL(string: pic as! String))
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = Factory.createViewWith(CGRectMake(0, 0, screenWidth, 60))
        view.backgroundColor = UIColor.whiteColor()
     
        //索引
        let indexLabel = UILabel(frame: CGRectMake(10, 10, 40, 40))
        indexLabel.textColor = UIColor.RGBAlpha(255, 156, 187)
        indexLabel.text = "\(section + 1)"
        indexLabel.textAlignment = .Center
        //设置边框
        indexLabel.layer.borderColor = UIColor.RGBAlpha(255, 156, 187).CGColor
        indexLabel.layer.borderWidth = 2
        
        view.addSubview(indexLabel)
        
        //组头标题
        let sectionTitleLabel = Factory.createLabelWith(CGRectMake(indexLabel.frame.size.width + indexLabel.frame.origin.x + 10, 10, 200, 40), text: "", font: UIFont.systemFontOfSize(15), textAlignment: .Left, textColor: UIColor.RGBAlpha(255, 156, 187))
        view.addSubview(sectionTitleLabel)
        //组头赋值
        
        sectionTitleLabel.text = self.dataArray[section]["title"]as? String
        
        return view
    }
    //如果要用到组头的话，必须设置组头的高度，否则不显示
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    //MARK:设置导航
    func resetNav() {
        
        self.titleLabel?.text = "详情"
        
        self.leftButton?.setImage(UIImage(named: "iconfont-fanhui"), forState: .Normal)
        
        self.rightButton?.setImage(UIImage(named: "iconfont-fenxiang"), forState: .Normal)
        
        self.addLeftTarget(#selector(HomeDetailViewController.backButtonClicked))
        self.addRightTarget(#selector(HomeDetailViewController.shareButtonClicked))
        
    }
    
    //MARK:按钮响应方法
    func backButtonClicked() {
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    //分享
    func shareButtonClicked(){
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}
