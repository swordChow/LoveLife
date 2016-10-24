//
//  ChTool.swift
//  AmazingLife
//
//  Created by sword on 16/7/26.
//  Copyright © 2016年 Chow-Chow. All rights reserved.
//

import Foundation

//屏幕宽、高
let screenWidth = UIScreen.mainScreen().bounds.size.width

//优先级
let screenHeight = (UIScreen.mainScreen().bounds.size.height - 64)

//extension of UIColor

extension UIColor {
    
   static func RGBAlpha(red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha:CGFloat = 1) -> UIColor {
        
        return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
        
    }
    
    
    
    
}

//音乐接口

let popularUrl = "http://theinfoapps.com/myfm/category/1003841/?appid=com.infoapps.myfm&appname=JapanFM&v=2.5.1&lang=zh-Hans&jb=0&deviceid=74496205-8F51-4552-9DCA-4130F80C2112&phonetype=iphone&model=iphone5,2&osn=iPhone%2520OS&osv=8.1.3&carrier=%25E4%25B8%25AD%25E5%259B%25BD%25E7%25A7%25BB%25E5%258A%25A8&device_type=iPhone%206&r=541105&e=6RVcc6soACRbdXxqjkatPg"
let newSongsUrl = "http://theinfoapps.com/myfm/category/61/?appid=com.infoapps.myfm&appname=JapanFM&v=2.5.1&lang=zh-Hans&jb=0&deviceid=74496205-8F51-4552-9DCA-4130F80C2112&phonetype=iphone&model=iphone5,2&osn=iPhone%2520OS&osv=8.1.3&carrier=%25E4%25B8%25AD%25E5%259B%25BD%25E7%25A7%25BB%25E5%258A%25A8&device_type=iPhone%206&r=330044&e=ps_YSM9m_r-HkZIGujuUFg"

let chineseUrl = "http://theinfoapps.com/myfm/category/10001/?appid=com.infoapps.myfm&appname=JapanFM&v=2.5.1&lang=zh-Hans&jb=0&deviceid=74496205-8F51-4552-9DCA-4130F80C2112&phonetype=iphone&model=iphone5,2&osn=iPhone%2520OS&osv=8.1.3&carrier=%25E4%25B8%25AD%25E5%259B%25BD%25E7%25A7%25BB%25E5%258A%25A8&device_type=iPhone%206&r=035453&e=f9kps3LBJyEC7GQT63x6dg"
let englishUrl = "http://theinfoapps.com/myfm/category/10004/?appid=com.infoapps.myfm&appname=JapanFM&v=2.5.1&lang=zh-Hans&jb=0&deviceid=74496205-8F51-4552-9DCA-4130F80C2112&phonetype=iphone&model=iphone5,2&osn=iPhone%2520OS&osv=8.1.3&carrier=%25E4%25B8%25AD%25E5%259B%25BD%25E7%25A7%25BB%25E5%258A%25A8&device_type=iPhone%206&r=143121&e=XGP8qT2gcYL9smqtVBG1hA"

let japaneseUrl = "http://theinfoapps.com/myfm/category/10006/?appid=com.infoapps.myfm&appname=JapanFM&v=2.5.1&lang=zh-Hans&jb=0&deviceid=74496205-8F51-4552-9DCA-4130F80C2112&phonetype=iphone&model=iphone5,2&osn=iPhone%2520OS&osv=8.1.3&carrier=%25E4%25B8%25AD%25E5%259B%25BD%25E7%25A7%25BB%25E5%258A%25A8&device_type=iPhone%206&r=401453&e=BxF7Xk4PgsnwbiDkcwye2A"

let lightMusicUrl = "http://theinfoapps.com/myfm/category/9/?appid=com.infoapps.myfm&appname=JapanFM&v=2.5.1&lang=zh-Hans&jb=0&deviceid=74496205-8F51-4552-9DCA-4130F80C2112&phonetype=iphone&model=iphone5,2&osn=iPhone%2520OS&osv=8.1.3&carrier=%25E4%25B8%25AD%25E5%259B%25BD%25E7%25A7%25BB%25E5%258A%25A8&device_type=iPhone%206&r=001512&e=0vCiDwfc1wJcu9u-BKoEKA"

let countryUrl = "http://theinfoapps.com/myfm/category/8/?appid=com.infoapps.myfm&appname=JapanFM&v=2.5.1&lang=zh-Hans&jb=0&deviceid=74496205-8F51-4552-9DCA-4130F80C2112&phonetype=iphone&model=iphone5,2&osn=iPhone%2520OS&osv=8.1.3&carrier=%25E4%25B8%25AD%25E5%259B%25BD%25E7%25A7%25BB%25E5%258A%25A8&device_type=iPhone%206&r=350515&e=W3uIfTpXmGckEbvYwBP_rA"

let koreanUrl = "http://theinfoapps.com/myfm/category/1002500/?appid=com.infoapps.myfm&appname=JapanFM&v=2.5.1&lang=zh-Hans&jb=0&deviceid=74496205-8F51-4552-9DCA-4130F80C2112&phonetype=iphone&model=iphone5,2&osn=iPhone%2520OS&osv=8.1.3&carrier=%25E4%25B8%25AD%25E5%259B%25BD%25E7%25A7%25BB%25E5%258A%25A8&device_type=iPhone%206&r=524525&e=x-OCW3kqtDe2UEUnxVqCtg"

let rankUrl = "http://theinfoapps.com/myfm/rank/v2/?appid=com.infoapps.japanfm&appname=JapanFM&v=2.5.1&lang=zh-Hans&jb=0&deviceid=74496205-8F51-4552-9DCA-4130F80C2112&phonetype=iphone&model=iphone5,2&osn=iPhone%252520OS&osv=8.1.3&carrier=%2525E4%2525B8%2525AD%2525E5%25259B%2525BD%2525E7%2525A7%2525BB%2525E5%25258A%2525A8&device_type=iPhone%25206&r=150355&e=qxCeQmVva4FDQcUMsjEy7g&appid=com.infoapps.japanfm&appname=JapanFM&v=2.5.1&lang=zh-Hans&jb=0&deviceid=74496205-8F51-4552-9DCA-4130F80C2112&phonetype=iphone&model=iphone5,2&osn=iPhone%2520OS&osv=8.1.3&carrier=%25E4%25B8%25AD%25E5%259B%25BD%25E7%25A7%25BB%25E5%258A%25A8&device_type=iPhone%206"
























