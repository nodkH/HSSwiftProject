//
//  StringExtension.swift
//  EducationNews
//
//  Created by 孔祥刚 on 2020/4/25.
//  Copyright © 2020 孔祥刚. All rights reserved.
//

import UIKit

extension String {
    

    func setAttributed(strings : [String], colors : [UIColor], fonts : [UIFont]) -> NSAttributedString {
        
        if (strings.count == 0 || self.count == 0) {
            return NSAttributedString()
        }
        
        if strings.count != colors.count && strings.count != fonts.count {
            return NSAttributedString()
        }
        
        let attributedStr = NSMutableAttributedString(string: self)
        
        for (index, string) in strings.enumerated() {
            let color = colors[index]
            let font = fonts[index]
            
            let range = (self as NSString).range(of: string)
            
            
            attributedStr.addAttributes([NSAttributedString.Key.font : font], range: range)
            attributedStr.addAttributes([NSAttributedString.Key.foregroundColor : color], range: range)
        }
        return attributedStr
    }
    
    private func getStringSize(str: String? = nil, attriStr: NSMutableAttributedString? = nil,  w: CGFloat, h: CGFloat, font: UIFont? = nil) -> CGSize {
        if str != nil && str?.count != 0 {
            let strSize = (str! as NSString).boundingRect(with: CGSize(width: w, height: h), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font ?? UIFont.systemFont(ofSize: 1)], context: nil).size
            return strSize
        }
        
        if attriStr != nil {
            let strSize = attriStr!.boundingRect(with: CGSize(width: w, height: h), options: .usesLineFragmentOrigin, context: nil).size
            return strSize
        }
        
        return CGSize.zero
        
    }
    
    
    public func getStringWidth(attriStr: NSMutableAttributedString? = nil, strFont: UIFont, h: CGFloat) -> CGFloat {
        return getStringSize(str: self, w: CGFloat.greatestFiniteMagnitude, h: h, font : strFont).width
    }
    
    public func getStringHeight(attriStr: NSMutableAttributedString? = nil,strFont: UIFont, w: CGFloat) -> CGFloat {
        return getStringSize(str: self, attriStr: attriStr,  w: w, h: CGFloat.greatestFiniteMagnitude, font : strFont).height
    }
    
}
