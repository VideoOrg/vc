//
//  VCTools.swift
//  VideoCapture
//
//  Created by admin on 16/9/6.
//  Copyright © 2016年 zhangyun. All rights reserved.
//

import UIKit


let SWIDTH = UIScreen.mainScreen().bounds.size.width  //屏幕 宽
let SHEIGHT = UIScreen.mainScreen().bounds.size.height //屏幕 高

// RGBA的颜色设置
func VCRGBColor(r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
}
// 全体控制器背景颜色
func VCBaseViewColor() -> UIColor {
    return VCRGBColor(255, g: 255, b: 255, a: 1)
}
