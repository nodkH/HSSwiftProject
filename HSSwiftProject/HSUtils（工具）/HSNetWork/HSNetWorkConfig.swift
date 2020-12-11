//
//  HSNetWorkConfig.swift
//  HSSwiftProject
//
//  Created by 孔祥刚 on 2020/5/28.
//  Copyright © 2020 孔祥刚. All rights reserved.
//

import UIKit

private var versionPrivate: String?

var HSNetWorkVersion: String {
    get {
        if let versionPrivate_ = versionPrivate {
            return versionPrivate_
        }
        versionPrivate = (Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String)
        return versionPrivate ?? "没有version😁"
    }
}



///超时时间
let Alamafire_TimeoutIntervalForRequest:TimeInterval = 10



class HSDefaultHeader: NSObject {
    static func defaultHeader() -> [String : String] {
        return [
            "Version": HSNetWorkVersion,
            "Content-Type":"application/json;charset=utf-8"
        ]
    }
}
