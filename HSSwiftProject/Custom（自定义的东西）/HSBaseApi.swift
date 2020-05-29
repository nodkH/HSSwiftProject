//
//  HSBaseApi.swift
//  HSSwiftProject
//
//  Created by 孔祥刚 on 2020/5/28.
//  Copyright © 2020 孔祥刚. All rights reserved.
//

import UIKit
///是否为debug模式
var isDebug: Bool {
    get {
        #if DEBUG
            return true
        #else
            return false
        #endif
    }
}

enum ApiSystem: Int {
    case get            = 1
    case post           = 2
    case wx             = 3
    case by             = 4
}

extension String {
    init(system: ApiSystem) {
        switch system {
        case .get:
            if !isDebug {
                self = "http://118.190.24.202:8080/modle/a/xuexiapp/"
            }
            self = "http://118.190.24.202:8080/modle/a/xuexiapp/"
        case .post:
            if !isDebug {
                self = "http://118.190.24.202:8080/modle/a/xuexiapp/"
            }
            self = "http://118.190.24.202:8080/modle/a/xuexiapp/"
        case .by:
            self = "https://f2c.baiyangwang.com/app/v1.6/index.php"
        default:
            self = "https://f2c.baiyangwang.com/app/v1.6/index.php?+"
        }
    }
}
