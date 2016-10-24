//
//  MusicViewController.swift
//  AmazingLife
//
//  Created by sword on 16/7/27.
//  Copyright © 2016年 Chow-Chow. All rights reserved.
//

import UIKit

class MusicViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var  imageArray = NSArray()
    
    var  titleArray = NSArray()
    
    var urlArray = NSArray()
    
    var collectionView : UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()
        //初始化数据
        initData()
        createUI()
        
    }
    //MARK:初始化数据
    func initData() {
        
        self.imageArray = ["shili0","shili1","shili2","shili8","shili10","shili19","shili15","shili13","shili24"]
        self.titleArray = ["流行","新歌","华语","英语","日语","轻音乐","民谣","韩语","歌曲排行榜"]
        self.urlArray = [popularUrl, newSongsUrl, chineseUrl, englishUrl, japaneseUrl, lightMusicUrl, countryUrl, koreanUrl, rankUrl];
        
    }
    //MARK:创建UI
    
    func createUI(){
        //创建网格布局对象
        
        let flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.scrollDirection = UICollectionViewScrollDirection.Vertical
        //创建网格对象
        self.collectionView = UICollectionView(frame: CGRectMake(10, 10, screenWidth - 20, screenHeight), collectionViewLayout: flowLayout)
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        self.collectionView?.backgroundColor = UIColor.whiteColor()
        
        self.view.addSubview(self.collectionView!)
        
        //注册cell
        self.collectionView?.registerNib(UINib(nibName: "MusicCell",bundle: nil), forCellWithReuseIdentifier: "musicCell")
        
    }
    //MARK -- 实现collectionView的代理方法
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return titleArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("musicCell", forIndexPath: indexPath) as! MusicCell
        cell.imageName = self.imageArray[indexPath.item] as! String
        cell.title = self.titleArray[indexPath.item] as! String
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake((screenWidth - 30) / 2, 150)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //跳入音乐列表页
        
        let musicListVC = MusicListViewController()
        
        self.navigationController?.pushViewController(musicListVC, animated: true)
        musicListVC.musicTitle = self.titleArray[indexPath.row] as? String
        musicListVC.musicUrl = self.urlArray[indexPath.item] as? String
        
        musicListVC.hidesBottomBarWhenPushed = true
        
        
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
