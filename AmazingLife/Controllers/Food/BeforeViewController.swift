//
//  BeforeViewController.swift
//  AmazingLife
//
//  Created by sword on 16/7/28.
//  Copyright © 2016年 Chow-Chow. All rights reserved.
//

import UIKit
import MediaPlayer
class BeforeViewController: MPMoviePlayerViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    //实现横屏播放，重写系统的两个方法
    //1.允许开放横屏
    override func shouldAutorotate() -> Bool {
        return true
    }
    //设置横屏播放界面的样式
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Landscape
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
