//
//  myModel.swift
//  HSSwiftProject
//
//  Created by 孔祥刚 on 2020/5/28.
//  Copyright © 2020 孔祥刚. All rights reserved.
//

import UIKit
import ObjectMapper

class postModel: Mappable {
    var id : String?
    var isNewRecord : Bool?
    var createDate : String?
    var updateDate : String?
    var questionUserId : String?
    var answerNumber : String?
    var content : String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        isNewRecord <- map["isNewRecord"]
        createDate <- map["createDate"]
        updateDate <- map["updateDate"]
        questionUserId <- map["questionUserId"]
        answerNumber <- map["answerNumber"]
        content <- map["content"]
    }
    
    
}



class getModel: Mappable {
    var voucher_t_id : Int?
    var voucher_title : String?
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        voucher_t_id <- map["voucher_t_id"]
        voucher_title <- map["voucher_title"]
    }
    
    
}

