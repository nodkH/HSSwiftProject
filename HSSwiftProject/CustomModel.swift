//
//  CustomModel.swift
//  HSSwiftProject
//
//  Created by 孔祥刚 on 2020/7/23.
//  Copyright © 2020 孔祥刚. All rights reserved.
//

import UIKit
import ObjectMapper

class CustomModel: Mappable {
    var voucher : [String]?
    required init?(map: Map) {
    }
    
    init() {
        
    }
    
    func mapping(map: Map) {
        voucher <- map["voucher"]
    }
}
