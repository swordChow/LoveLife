//
//  MyTabBarController.swift
//  AmazingLife
//
//  Created by sword on 16/7/26.
//  Copyright © 2016年 Chow-Chow. All rights reserved.
//

import UIKit

class MyTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let foodVC = FoodViewController()
        let foodNav = UINavigationController(rootViewController: foodVC)
        let homeVC = HomeViewController()
        let homeNav = UINavigationController(rootViewController: homeVC)
        let myVC = MyViewController()
        let myNav = UINavigationController(rootViewController: myVC)
        let readVC = ReadViewController()
        let readNav = UINavigationController(rootViewController: readVC)
        let navArray =  [homeNav, readNav, foodNav, myNav]
        self.viewControllers = navArray
        let titleArray = ["首页","阅读","美食","我的"]
        
        
        let unselectedImageArray = ["ic_tab_home_normal@2x","ic_tab_select_normal@2x","iconfont-iconfontmeishi","ic_tab_profile_normal_female@2x"]
        
        let selectedImageArray = ["ic_tab_home_selected@2x","ic_tab_select_selected@2x","iconfont-iconfontmeishi-2","ic_tab_profile_selected_female@2x"]
        
        for i in 0..<navArray.count {
            let nav = navArray[i]
            nav.tabBarItem.title = titleArray[i]
            //未选中图片
            let unselectedImage = UIImage(named: unselectedImageArray[i])
            nav.tabBarItem.image = unselectedImage?.imageWithRenderingMode(.AlwaysOriginal)
            //选中图片
            let selectedImage = UIImage(named: selectedImageArray[i])
            nav.tabBarItem.selectedImage = selectedImage?.imageWithRenderingMode(.AlwaysOriginal)
            
        }
        //设置选中时标题颜色
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.RGBAlpha(255, 156, 187)], forState: .Selected)
        
        
        
       
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
