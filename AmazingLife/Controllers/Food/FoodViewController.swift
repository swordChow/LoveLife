//
//  FoodViewController.swift
//  AmazingLife
//
//  Created by sword on 16/7/26.
//  Copyright © 2016年 Chow-Chow. All rights reserved.
//

import UIKit
//iOS9前
import MediaPlayer

//iOS之后
import AVKit
import AVFoundation

class FoodViewController: RootViewController, UICollectionViewDelegateWaterFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource, PlayVideo {
    
    //按钮标题
    let titleArray = ["家常菜","小炒","凉菜","烘焙"]
    //button对象
    var buttonArray = NSMutableArray()
    //指示线条
    var lineView = UIView()
    
    //分页
    var page = 1
    //数据数组
    var dataArray = NSMutableArray()
    //菜品的分类ID
    var typeID = "1"
    //标题
    var titleStr = "家常菜"
    //iOS9之前
    var moviePlayer : MPMoviePlayerViewController?
    //iOS9之后
    var avPlayer : AVPlayerViewController?
        
    //CollectionView warn: 定义collectionView的时候只能定义成?可选类型
    var collectionView : UICollectionView?
    
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(true)
        
        for i in 0..<self.buttonArray.count {
            let btn = self.buttonArray[i] as!UIButton
            if btn == self.buttonArray.firstObject as!UIButton {
                btn.selected = true
            }
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleLabel?.text = "美食"
        //创建头部按钮
        createHeaderView()
        //创建collectionView
        createCollectionView()
        
        //创建刷新
        createRefresh()
       
    }
    
    //MARK:刷新数据
    func createRefresh() {
        //下拉刷新
        self.collectionView?.header = MJRefreshNormalHeader(refreshingBlock: {
            
            self.page = 1
            self.dataArray.removeAllObjects()
            self.getData()
            
        })
        //上拉刷新
        self.collectionView?.footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            
            self.page += 1
            self.getData()
            
        })
        
        self.collectionView?.header.beginRefreshing()
        
    }
    //请求数据
    func getData() {
        
        let manager = AFHTTPSessionManager()
        //使用POST请求，更符合实际项目中的请求方式，需要拼接参数，参数以字典的形式进行拼接，只有baseurl的话是拿不到数据的，参数相应的字段是有后台给规定的，相应的value 就是我们要上传的变量
        
        //参数拼接
        let dic = ["methodName": "HomeSerial", "page": String(self.page), "serial_id": self.typeID, "size": "20"]
        manager.POST("http://api.izhangchu.com:/", parameters: dic, success: { (dataMask:NSURLSessionDataTask?, responseObject: AnyObject?) in
            
            let dic = responseObject?.objectForKey("data")
            let array = dic?.objectForKey("data") as! NSArray
            print(array)
            //字典转模型
            for i in 0..<array.count {
                
                //实例化模型
                let model = FoodModel()
                let subDic = array[i]
                model.setValuesForKeysWithDictionary(subDic as![String: AnyObject])
                self.dataArray.addObject(model)
                
            }
            
            if self.page == 1 {
                self.collectionView?.header.endRefreshing()
            }
            else {
                self.collectionView?.footer.endRefreshing()
            }
            //刷新UI
            self.collectionView?.reloadData()
            
        }) { (dataMask:NSURLSessionDataTask?, error:ErrorType?) in
          
            
        }
        
     
        
    }
    //MARK:创建UI
    func createHeaderView() {
        for i in 0..<titleArray.count {
            
            let headerButton = UIButton(type: .Custom)
            headerButton.frame = CGRectMake(CGFloat(i) * screenWidth / 4, 0 , screenWidth / 4, 40)
            
            headerButton.setTitle(titleArray[i], forState: .Normal)
            headerButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
            headerButton.setTitleColor(UIColor.RGBAlpha(255, 156, 187), forState: .Selected)
            
            headerButton.tag = 200 + i
            
            headerButton.addTarget(self, action: #selector(FoodViewController.typeButtonClicked(_:)), forControlEvents: .TouchUpInside)
            
            self.view.addSubview(headerButton)
            
            self.buttonArray.addObject(headerButton)
        }
        //创建线条指示
        self.lineView = UIView(frame: CGRectMake(0, 38, screenWidth / 4, 2))
        self.lineView.backgroundColor = UIColor.RGBAlpha(255, 156, 187)
        self.view.addSubview(lineView)
        
    }
    func typeButtonClicked(sender: UIButton) {
        
        for button  in buttonArray {
            let btn = button as! UIButton
            btn.selected = false
        }
        
        sender.selected = true
        //每次改变线条指示的位置
        UIView.animateWithDuration(0.3) {
            self.lineView.frame = CGRectMake(CGFloat(sender.tag - 200) * (screenWidth / 4), 38, screenWidth / 4, 2)
        }
        //切换数据源
        //分类ID
        self.typeID = String(sender.tag - 200 + 1)
        //标题
        self.titleStr = self.titleArray[sender.tag - 200]
        
        //重新刷新UI
        self.collectionView?.header.beginRefreshing()
        
        
        
        
        
    }
    
    //创建CollectionView
    func createCollectionView() {
        
        //创建网格布局对象
        let flowLayout = NBWaterFlowLayout()
        //设置网格的大小
        flowLayout.itemSize = CGSizeMake((screenWidth - 30) / 2, 180)
        //设置一列可显示的网格
        flowLayout.numberOfColumns = 2
        //设置item距离边界的距离
        flowLayout.sectionInsets = UIEdgeInsetsMake(10, 10, 10, 10)
        
        flowLayout.delegate = self
        
        //创建网格对象
        self.collectionView = UICollectionView(frame: CGRectMake(0, 50, screenWidth, screenHeight - 50), collectionViewLayout: flowLayout)
        
        //设置代理
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        
        //设置背景颜色，默认背景色为黑色
        self.collectionView?.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(self.collectionView!)
        
        //注册cell
        //标题cell
        self.collectionView?.registerClass(FoodTitleCell.self, forCellWithReuseIdentifier: "foodTitleCell")
        
        //正文cell
        self.collectionView?.registerNib(UINib(nibName: "FoodCell",bundle: nil), forCellWithReuseIdentifier: "foodCell")
        
        
        
        
    }
    
    //MARK:实现collectionView的代理方法
    //确定item 的个数
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //使用三位运算判断
        return self.dataArray.count > 0 ? self.dataArray.count + 1 : 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        //标题
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("foodTitleCell", forIndexPath: indexPath) as! FoodTitleCell
            cell.titleLabel.text = self.titleStr
            return cell
        }
        //正文
        else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("foodCell", forIndexPath: indexPath) as! FoodCell
            
            //设置代理
            cell.delegate = self
            if self.dataArray.count > 1 {
            //传值
            let model = dataArray[indexPath.item - 1] as! FoodModel
            cell.model = model
            }
            return cell
        }
        
    }
    
    //确定item的高度 --自定义的代理方法
    func collectionView(collectionView: UICollectionView!, waterFlowLayout layout: NBWaterFlowLayout!, heightForItemAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        //标题
        if indexPath.item == 0 {
            return 30
        }
        //正文
        else {
            return 180
        }
    }
    //MARK:播放视频
    //实现自定义的代理方法
    func playVideoWithUrl(videoUrl: String) {
        
        /**
         ios9 之前，使用MediaPlayer框架下MPMoviePlayerViewController实现；
         ios9 之后，之前被废弃，使用的是AVKit 框架下得AVPlayerController 和AVFoundation下的AVPlayer实现
         */
        //一.iOS9之前：
        //1.正常情况下的播放(直接调用系统类)
       // beforeIOS9WithNormal(videoUrl)
        //横屏
        //beforeIOS9WithOritention(videoUrl)
        
        //二.ios9
        afterIOS9WithNormal(videoUrl)
        //afterIOS9WithOritention(videoUrl)
        
        
        
    }
    func beforeIOS9WithNormal(videoUrl: String) {
        
        //创建视频播放器
        self.moviePlayer = MPMoviePlayerViewController(contentURL: NSURL(string: videoUrl))
        //设置全屏播放
        self.moviePlayer?.moviePlayer.controlStyle = MPMovieControlStyle.Fullscreen
        //设置预bof
        self.moviePlayer?.moviePlayer.prepareToPlay()
        //开始播放
        self.moviePlayer?.moviePlayer.play()
        
        //推出视图控制器
        
        self.presentViewController(self.moviePlayer!, animated: true, completion: nil)
        
    }
    func beforeIOS9WithOritention(videoUrl: String) {
        //坑
        //let before = BeforeViewController
        
        
    }
    
    func afterIOS9WithNormal(videoUrl:String) {
        //初始化视频播放器
        self.avPlayer = AVPlayerViewController()
        //设置播放资源
        
        let player = AVPlayer(URL: NSURL(string: videoUrl)!)
        
        self.avPlayer?.player = player
        //推出播放控制器
        self.presentViewController(avPlayer!, animated: true, completion: nil)
        
    }
    func afterIOS9WithOritention(videoUrl: String) {
        let after = AfterViewController()
        let player = AVPlayer(URL: NSURL(string: videoUrl)!)
        after.player = player
        self.presentViewController(after, animated: true, completion: nil)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}
