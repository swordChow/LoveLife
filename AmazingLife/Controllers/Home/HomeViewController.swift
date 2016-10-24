//
//  HomeViewController.swift
//  AmazingLife
//
//  Created by sword on 16/7/26.
//  Copyright © 2016年 Chow-Chow. All rights reserved.
//

import UIKit

class HomeViewController: RootViewController , UITableViewDelegate, UITableViewDataSource{
    
    //
    var tableView = UITableView()
    
    //活动指示器
    var hud = MBProgressHUD()
    
    //广告轮播
    var cyclePlaying = Carousel()
    
    //分页
    var page = 0
    
    //最后得到的数据
    var dataArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    //  实现界面搭建： 1.创建UI 2.请求数据 3.返回刷新UI
        resetNav()
        //创建UI
        createUI()
        //创建数据刷新
        createRefresh()
    }
    
    //刷新
    func createRefresh() {
        
        //下拉刷新
        self.tableView.header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(HomeViewController.loadNewData))
        self.tableView.footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(HomeViewController.loadMoreData))
        //让程序进入后自动刷新
        self.tableView.header.beginRefreshing()
    }
    
    //下拉刷新
    func loadNewData() {
        self.page = 0
        //
        self.dataArray.removeAllObjects()
        getData()
        
    }
    
    //上拉加载
    func loadMoreData() {
        self.page += 1
        getData()
    }
    
    //请求数据
    func getData() {
        
        self.hud.show(true)
        //
        let manager = AFHTTPSessionManager()
        manager.GET("http://open4.bantangapp.com/recommend/index?client_id=bt_app_android&client_secret=ffcda7a1c4ff338e05c42e7972ba7b8d&page=\(self.page)&pagesize=20", parameters: nil, success: { (dataMask: NSURLSessionDataTask?, responseObject:AnyObject?) in
            //解析数据
            let dic = responseObject?.objectForKey("data")
            let array = dic?.objectForKey("topic") as! NSArray
            //利用KVC来进行属性赋值（字典转模型）
            for i in 0..<array.count {
                let subDic = array[i]
                //初始化model
                let homeModel = HomeModel()
                //直接字典转模型，必须保证model中的字段和json 请求下来的数据字段完全一样
                homeModel.setValuesForKeysWithDictionary(subDic as![String: AnyObject])
                self.dataArray.addObject(homeModel)
                
            }
            
            //数据请求成功之后停止活动指示器，停止MJ刷新，去刷新UI
            
            self.hud.hide(true)
            if self.page == 0 {
                self.tableView.header.endRefreshing()
            }
            else {
                self.tableView.footer.endRefreshing()
            }
            //相当于将tableView的代理方法重新走一遍
            self.tableView.reloadData()
            
        }) { (dataMask: NSURLSessionDataTask?, error: ErrorType?) in
            print(error)
            
        }
        
    }
    
    func createUI() {
        
        //tableView
        self.tableView = UITableView(frame: CGRectMake(0, 0, screenWidth, screenHeight), style: .Plain)
        
        //delegate datasources
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        
        //修改分割线的样式
        self.tableView.separatorColor = UIColor.RGBAlpha(255, 156, 187)
        //隐藏系统的分割线
        //self.tableView.separatorStyle = .None
        //取消多余的线条
        self.tableView.tableFooterView = UIView()
        
        //
        
        self.cyclePlaying = Carousel(frame: CGRectMake(0, 0, screenWidth, screenHeight / 3))
        //设置是否需要pagecontrol
        self.cyclePlaying.needPageControl = true
        //设置是否需要无限轮播
        self.cyclePlaying.infiniteLoop = true
        //
        self.cyclePlaying.pageControlPositionType = PAGE_CONTROL_POSITION_TYPE_MIDDLE
        //使用本地图片
        self.cyclePlaying.imageArray = ["shili8","shili2","shili10","shili13","shili24"]
        //设置为tableView 的tableHeaderView
        self.tableView.tableHeaderView = self.cyclePlaying
        
        //Hud活动指示器
        self.hud = MBProgressHUD(view: self.view)
        // 设置加载文字 
        self.hud.labelText = "正在加载..."
        //设置齿轮色
        self.hud.activityIndicatorColor = UIColor.whiteColor()
        //设置背景色
        self.hud.color = UIColor(white: 0, alpha: 0.5)
        
        self.view.addSubview(hud)
        
        
        //注册cell
        //UINib 来注册自定义的xib - 加载xib 文件
        //nibName: 自定义类名
        let nib = UINib(nibName: "HomeCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: "homeCell")
        
    }
    
    //MARK:- 实现tableView的代理方法
    
    //确定单元格数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    //cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //方法一： 注册cell
        let cell = tableView.dequeueReusableCellWithIdentifier("homeCell", forIndexPath: indexPath) as! HomeCell
        
        //赋值
        let model = dataArray[indexPath.row]
        cell.model = model as! HomeModel
       
        //方法二： 不需要注册cell - UITableView的复用机制
//        var cell = tableView.dequeueReusableCellWithIdentifier("homeCell")
//        if cell == nil {
//           cell = UITableViewCell(style: .Default, reuseIdentifier: "homeCell")
//        }
        
        return cell
    }
    
    //确定cell 的高度
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200
    }
    
    //点击cell
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let detailVC = HomeDetailViewController()
        let model = dataArray[indexPath.row] as! HomeModel
        detailVC.dataID = model.id!
        //在推出详情页之前隐藏tabbar 
        detailVC.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    //MARK: - 设置导航
    func resetNav() {
        self.titleLabel?.text = "首页"
        self.rightButton?.setImage(UIImage(named: "2vm"), forState: .Normal)
        //调用父类的实例方法 添加右按钮的响应方法
        self.addRightTarget(#selector(HomeViewController.toQRCode))
        
    }
    func toQRCode() {
        print("扫描二维码")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    
}
