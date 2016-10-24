//
//  MusicListViewController.swift
//  AmazingLife
//
//  Created by sword on 16/7/28.
//  Copyright © 2016年 Chow-Chow. All rights reserved.
//

import UIKit

class MusicListViewController: RootViewController, UITableViewDelegate, UITableViewDataSource {
    
    var musicTitle: String?
    
    var musicUrl: String?
    
    var tableView = UITableView()
    
    var dataArray = NSMutableArray()
    
  

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createNav()
        createUI()
        
        createRefresh()
    }
    
    //MARK:刷新
    func createRefresh() {
       
        
        self.tableView.header = MJRefreshNormalHeader(refreshingBlock: {
            
            self.dataArray.removeAllObjects()
            self.getData()
        })
        self.tableView.footer = MJRefreshAutoFooter(refreshingBlock: {
          
            self.getData()
            
        })
        self.tableView.header.beginRefreshing()
        
        
    }
    //MARK:请求数据
    func getData() {
        
       
        let manager = AFHTTPSessionManager()
        
        manager.responseSerializer.acceptableContentTypes = NSSet(objects: "text/html", "text/plain") as! Set<String>

        manager.GET(self.musicUrl, parameters: nil , success: { (dataMask: NSURLSessionDataTask?, responseObject: AnyObject?) in
            
        
            let array = responseObject?.objectForKey("data") as! NSArray
            
            if self.musicUrl == rankUrl {
                for subArray in array {
                    
                    let dic = subArray.objectForKey("song") as! [String: AnyObject]
                    let model = MusicModel()
                    model.setValuesForKeysWithDictionary(dic)
                    self.dataArray.addObject(model)
                }
                print(self.dataArray.count)
                
            }
            else {
            
            for i in 0..<array.count  {
                
                let model = MusicModel()
                model.setValuesForKeysWithDictionary(array[i] as! [String : AnyObject])
                self.dataArray.addObject(model)
                
                
                }
            }
            
            self.tableView.header.endRefreshing()
            
            self.tableView.reloadData()
            
            
        }) { (dataMask: NSURLSessionDataTask?, error: ErrorType?) in
                print(error)
        }
        
      
        
        
        
    }
    //MARK:UI
    func createUI() {
        self.tableView = UITableView(frame: CGRectMake(0, 64, screenWidth, screenHeight), style: .Plain)
        self.tableView.rowHeight = 100
        self.tableView.backgroundColor = UIColor.whiteColor()
        
        self.tableView.separatorColor = .None
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.view.addSubview(self.tableView)
        
        //注册cell
        self.tableView.registerNib(UINib(nibName: "MusicDetailCell",bundle:  nil), forCellReuseIdentifier: "musicDetailCell")
      
        
    }
    //MARK:设置导航
    func createNav() {
        self.titleLabel?.text = musicTitle
        
        self.leftButton?.setImage(UIImage(named: "iconfont-fanhui"), forState: .Normal)
        
        self.addLeftTarget(#selector(MusicListViewController.backButtonToMusic(_:)))

        
    }
    func backButtonToMusic(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    //MARK:实现tableView的代理方法
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("musicDetailCell", forIndexPath: indexPath) as! MusicDetailCell
         cell.accessoryType = .DisclosureIndicator
         cell.selectionStyle = .None
        if self.dataArray.count > 0 {
       
        cell.musicModel = self.dataArray[indexPath.row] as! MusicModel
        
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let musicPlayVC = MusicPlayerViewController()
        let model = self.dataArray[indexPath.row] as! MusicModel
        musicPlayVC.musicUrl = model.url!
        print(model.url!)
        self.navigationController?.pushViewController(musicPlayVC, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}
