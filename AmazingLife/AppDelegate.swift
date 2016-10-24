//
//  AppDelegate.swift
//  AmazingLife
//
//  Created by sword on 16/7/26.
//  Copyright © 2016年 Chow-Chow. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var myTabBar: MyTabBarController?
    
    var guidePageView: GuidePageView?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        myTabBar = MyTabBarController()
        self.window?.rootViewController = self.myTabBar
        
        //方法二： 修改状态栏的颜色，需要结合修改plist文件来做， 这种方式适合全局修改状态栏的颜色
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        //添加引导页
        addGuidePage()
        
        //注册友盟APPkey,在友盟官方平台申请
        UMSocialData.setAppKey("507fcab25270157b37000010")
        
        
        return true
    }
    
    func addGuidePage() {
        
        //判断
        let isRun = NSUserDefaults.standardUserDefaults().objectForKey("isRun")
        
        if isRun != nil {
            return
        }
        let imageArray = ["welcome2","welcome4","welcome6","welcome7"]
        
        //创建引导页
        self.guidePageView = GuidePageView(frame: self.window!.bounds, imageArray: imageArray)
        
        self.myTabBar!.view.addSubview(self.guidePageView!)
        
        //进行本地记录
        //系统自带的NSUserDefault ,数据本地持久化的一种方式，类似于数据库，plist 的使用
        NSUserDefaults.standardUserDefaults().setObject("first", forKey: "isRun")
        
        //给跳转按钮添加方法
        self.guidePageView?.skipButton?.addTarget(self, action: #selector(AppDelegate.skipTheGuidePage), forControlEvents: .TouchUpInside)
        
        
    }
    func skipTheGuidePage() {
        self.guidePageView?.removeFromSuperview()
        
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

