//
//  HomeModel.swift
//  AmazingLife
//
//  Created by sword on 16/7/26.
//  Copyright © 2016年 Chow-Chow. All rights reserved.
//

import UIKit

class HomeModel: NSObject {
    var id : String?
    var title: String?
    var pic : String?
    //方法中可以过滤到没有定义的字段，或者可以修改和系统关键字相同的字段
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }

}
