//
//  MusicPlayerViewController.swift
//  AmazingLife
//
//  Created by sword on 16/7/29.
//  Copyright © 2016年 Chow-Chow. All rights reserved.
//

import UIKit
import AVFoundation

class MusicPlayerViewController: RootViewController {

    var   musicUrl : String?
    //音频
    
    var audioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createNav()
        
        //
        /**
         1.AVAudioPlayer 是AVFoundation框架下的音频播放类
         2.实质上只能播放本地音乐
         3.只能播放单一音乐 , 实现上一首歌或下一首歌，首先需要将正在使用的AVAudioPlayer置为nil ,然后重新创建新的对象
         4.类似音频，视频，图片的加载都属于耗时操作，处理的时候使用多线程，将耗时操作放到子线程，完成之后回到主线程刷新UI
         */
        musicBeginPlay ()
       
        
      

        
    }
    func musicBeginPlay () {
        
         //GCD开辟线程
        
        dispatch_async(dispatch_get_global_queue(0, 0)) {
            
            //耗时操作，放到子线程
            self.createAudioPlayer()
            dispatch_async(dispatch_get_main_queue(), {
                
                //主线程刷新界面
                self.audioPlayer.play()
            })
        }

        
        
    }
    
    
    
    //MARK:AudioPlayer
    func createAudioPlayer() {
        
        //初始化,设置播放资源
        //1.本地音乐，url 表示的是本地音乐的url
        //self.audioPlayer = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("", ofType: "")))
        
        //2.网络音乐 将网络音乐文件转化为本地数据
        //方法如果抛出异常，使用的时候要捕捉异常
        if let url = NSURL(string:musicUrl!) {
            if let data = NSData(contentsOfURL: url) {
            self.audioPlayer =  try! AVAudioPlayer(data: data)
                
                
                //属性设置
                //音量
                self.audioPlayer.volume = 0.5
                
                //播放时间
                self.audioPlayer.currentTime = 0
                //负数表示无限循环, 0 表示只播放一次
                
                self.audioPlayer.numberOfLoops = 0
                
                //预播放
                self.audioPlayer.prepareToPlay()
                
            }
            
        }
        
        
       
        
        
        
    }
    
    func createNav() {
        self.titleLabel?.text = "音乐播放"
        self.leftButton?.setImage(UIImage(named: "iconfont-fanhui"), forState: .Normal)
        self.addLeftTarget(#selector(MusicPlayerViewController.backToMusicList))
        
    }
    func backToMusicList() {
        self.navigationController?.popViewControllerAnimated(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}
