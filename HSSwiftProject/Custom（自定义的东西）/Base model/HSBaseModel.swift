//
//  HSBaseModel.swift
//  HSSwiftProject
//
//  Created by 孔祥刚 on 2020/5/28.
//  Copyright © 2020 孔祥刚. All rights reserved.
//

import UIKit
import ObjectMapper

class HSBaseModel: Mappable {
    
    var result : [String : Any]?
    var code : String?
    var msg: String = "error"
    
    var isSuccess : Bool?
    
    required init?(map: Map) {
    }
    
    init() {
        
    }
    
    func mapping(map: Map) {
        result <- map["result"]
        code <- map["code"]
        msg <- map["msg"]
        if self.code == "200" {
            self.isSuccess = true
        } else {
            self.isSuccess = false
        }
    }
    
}
