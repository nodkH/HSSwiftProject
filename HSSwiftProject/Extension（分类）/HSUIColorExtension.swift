//
//  HSUIColorExtension.swift
//  EducationNews
//
//  Created by 孔祥刚 on 2020/3/15.
//  Copyright © 2020 孔祥刚. All rights reserved.
//

import UIKit

extension UIColor {
    static func hexStringToUIColor(hexString:String,alpha:CGFloat = 1)->UIColor {
        let tmpstring = hexString.replacingOccurrences(of: "#", with: "")
        guard tmpstring.count == 6 else { return UIColor.clear }
        var tmpStr = tmpstring
        var i = 0
        var data = Data()
        for _ in 0..<tmpstring.count/2 {
            let index = tmpStr.index((tmpStr.startIndex), offsetBy: 2)
            let str = String(tmpStr.prefix(upTo: index))
            tmpStr.removeSubrange(str.startIndex..<index)
            var result:UInt32 = 0
            Scanner(string: str).scanHexInt32(&result)
            data.append(UInt8(result))
            i = i+2
        }
        return UIColor.init(red: CGFloat(data[0])/255.0, green: CGFloat(data[1])/255.0, blue: CGFloat(data[2])/255.0, alpha: alpha)
    }

}
