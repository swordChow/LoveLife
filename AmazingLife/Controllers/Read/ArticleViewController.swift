//
//  ArticleViewController.swift
//  AmazingLife
//
//  Created by sword on 16/7/27.
//  Copyright © 2016年 Chow-Chow. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    var tableView = UITableView()
    
    var hud = MBProgressHUD()
    
    var page = 1
    
    var dataArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createUI()
        createRefresh()
       
    }
    //刷新，闭包
    func createRefresh() {
        //下拉刷新
        self.tableView.header = MJRefreshNormalHeader(refreshingBlock: {
            self.page = 1
            self.dataArray.removeAllObjects()
            self.getData()
            
        })
        //上拉加载
        self.tableView.footer = MJRefreshAutoNormalFooter(refreshingBlock: { 
            self.page += 1
            self.getData()
        })
        
        self.tableView.header.beginRefreshing()
    }
    
    
    func getData() {
        
        self.hud.show(true)
        
        let manager = AFHTTPSessionManager()
        
        manager.responseSerializer.acceptableContentTypes = NSSet(object: "text/html") as! Set<String>
        
        manager.GET("http://d.yixincao.com/interface/getdata.php?act=list&type=nuanwen&page=\(self.page)", parameters: nil , success: { (dataMask: NSURLSessionDataTask?, responseObject: AnyObject?) in
            
          
            
            let array = responseObject?.objectForKey("data") as! NSArray
            for i in 0..<array.count {
                let dic = array[i]
                //
                let articleModel = ArticleModel()
                articleModel.setValuesForKeysWithDictionary(dic as! [String: AnyObject])
                self.dataArray.addObject(articleModel)
                
            }
            self.hud.hide(true)
            
            if self.page == 1{
                self.tableView.header.endRefreshing()
            }
            else{
                self.tableView.footer.endRefreshing()
            }
            self.tableView.reloadData()
            
        }) { (dataMask: NSURLSessionDataTask?, error:ErrorType?) in
            
                print(error)
        }
        
        
    }
    
    
    //
    func createUI() {
        
        self.tableView = UITableView(frame: CGRectMake(0, 0, screenWidth, screenHeight), style: .Plain)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.view.addSubview(self.tableView)
        
        self.hud = MBProgressHUD(view: self.view)
        self.hud.labelText = "正在加载..."
        self.hud.activityIndicatorColor = UIColor.whiteColor()
        self.hud.color = UIColor(white: 0, alpha: 0.5)
        self.view.addSubview(hud)
        
        //cell
        self.tableView.registerNib(UINib(nibName: "ArticleCell", bundle: nil ), forCellReuseIdentifier: "articleCell")
        
    }
    
    //MARK: tableView代理方法
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("articleCell", forIndexPath: indexPath) as! ArticleCell
        
        //取消选中状态
        cell.selectionStyle = .None
        
        //防止
        if self.dataArray.count > 0 {
        //赋值
        cell.model = self.dataArray[indexPath.row] as! ArticleModel
       
        }
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailVC = ArticleDetailViewController()
        let model = self.dataArray[indexPath.row] as! ArticleModel
        
        detailVC.dataID = model.id!
        //隐藏tabbar
        detailVC.hidesBottomBarWhenPushed = true
        
        
        self.navigationController?.pushViewController(detailVC, animated: true)
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
