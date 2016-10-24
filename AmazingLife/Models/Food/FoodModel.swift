//
//  FoodModel.swift
//  AmazingLife
//
//  Created by sword on 16/7/28.
//  Copyright © 2016年 Chow-Chow. All rights reserved.
//

import UIKit

class FoodModel: NSObject {
    var detail: String?
    var image:String?
    var title: String?
    var video: String?
    //详情页传值
    var dish_id: String?
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        //说明已经修改过的key值
        if key == "description" {
            self.detail = value as? String
        }
    }

}
