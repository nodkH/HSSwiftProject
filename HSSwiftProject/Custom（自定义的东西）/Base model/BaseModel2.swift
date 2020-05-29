//
//  BaseModel2.swift
//  HSSwiftProject
//
//  Created by 孔祥刚 on 2020/5/29.
//  Copyright © 2020 孔祥刚. All rights reserved.
//

import UIKit
import ObjectMapper

class BaseModel2: Mappable {

    var code: Int?
    var datas: [String : Any]?
    
    
    required init?(map: Map) {
        
    }
    
    init() {
        
    }
    
    func mapping(map: Map) {
        code <- map["code"]
        datas <- map["datas"]
    }
}
