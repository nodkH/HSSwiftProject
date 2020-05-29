//
//  HSRequestType.swift
//  HSSwiftProject
//
//  Created by 孔祥刚 on 2020/5/28.
//  Copyright © 2020 孔祥刚. All rights reserved.
//

import UIKit
import Alamofire




/// 请求类型
public enum HSHTTPMethod : Int {
    case get            = 0
    case post           = 1
    case bodyPost       = 2
    case uploadImage    = 3
}
