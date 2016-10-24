//
//  ArticleDetailViewController.swift
//  AmazingLife
//
//  Created by sword on 16/7/27.
//  Copyright © 2016年 Chow-Chow. All rights reserved.
//

import UIKit

class ArticleDetailViewController: RootViewController {
    var dataID  = ""
    var webView = UIWebView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resetNav()
        createUI()
        // Do any additional setup after loading the view.
    }
    //web
    func createUI() {
        
        self.webView = UIWebView(frame: CGRectMake(0, 0, screenWidth, screenHeight))
        //加载数据
        //loadHTMLString是用来加载类似XML格式的标签式
        //loadRequest是用来加载一个网址
        let request = NSURLRequest(URL: NSURL(string: "http://d.yixincao.com/detailshow.php?id=\(self.dataID)&from=ios")!)
        self.webView.loadRequest(request)
        self.view.addSubview(webView)
        
    }
    
    //导航
    func resetNav() {
        
         self.titleLabel?.text = "美文详情"
        //设置左右按钮
         self.leftButton?.setImage(UIImage(named: "iconfont-fanhui"), forState: .Normal)
        //
        self.rightButton?.setImage(UIImage(named: "iconfont-fenxiang"), forState: .Normal)
        
        self.addLeftTarget(#selector(ArticleDetailViewController.backButtonClicked))
        self.addRightTarget(#selector(ArticleDetailViewController.shareButtonClicked))
        
        
    }
    
    
    func backButtonClicked() {
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    //分享
    //使用友盟提供的分享快速集成
    func shareButtonClicked() {
        //参数一：执行分享的控制器
        //参数二：appkey 
        //参数三：需要分享的文字
        //参数四：需要分享的图片
        //参数五：需要分享到的第三方平台名称，nil 默认选用友盟支持的全部第三方平台分享
        // 如果要选用特定的分享平台，要传入一个数组，对象为第三方平台名称 UMShareToxxx
        //参数六：需要执行的代理
        UMSocialSnsService.presentSnsIconSheetView(self, appKey: "507fcab25270157b37000010", shareText: "http://d.yixincao.com/detailshow.php?id=\(self.dataID)&from=ios", shareImage: nil , shareToSnsNames: nil , delegate: nil )
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
