//
//  HSConstant.swift
//  EducationNews
//
//  Created by 孔祥刚 on 2020/3/15.
//  Copyright © 2020 孔祥刚. All rights reserved.
//

// MARK: 系统常量
import Foundation
import UIKit

/// 屏幕宽度
let HS_SCREEN_WIDTH : CGFloat = UIScreen.main.bounds.width
/// 屏幕高度
let HS_SCREEN_HEIGHT : CGFloat = UIScreen.main.bounds.height

/// 判断是否是iPhone X系列
let HS_IS_IPHONE_X_ALL = UIScreen.main.bounds.size.height == 812 || UIScreen.main.bounds.size.height == 896

/// 导航栏高度
let HS_IPHONE_NAVIGATIONBAR_HEIGHT =  (HS_IS_IPHONE_X_ALL ? 88 : 64) as CGFloat
/// 状态栏高度
let HS_IPHONE_STATUSBAR_HEIGHT     =  (HS_IS_IPHONE_X_ALL ? 44 : 20) as CGFloat
/// 底部安全区域高度
let HS_IPHONE_SAFEBOTTOMAREA_HEIGHT = (HS_IS_IPHONE_X_ALL ? 34 : 0) as CGFloat
/// 顶部传感器高度
let HS_IPHONE_TOPSENSOR_HEIGHT      = (HS_IS_IPHONE_X_ALL ? 32 : 0) as CGFloat

/// tabbar 的高度
let HS_IPHONE_TABBAR_HEIGHT        = (HS_IS_IPHONE_X_ALL ? 49 + 34 : 49) as CGFloat


