//
//  HSError.swift
//  HSSwiftProject
//
//  Created by 孔祥刚 on 2020/5/28.
//  Copyright © 2020 孔祥刚. All rights reserved.
//

import UIKit

struct HSError: Error {
    var code : Int?
    var message : String = ""
    var error = NSError()
    
}
