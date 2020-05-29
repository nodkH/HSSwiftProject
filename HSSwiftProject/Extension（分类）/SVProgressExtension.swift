//
//  SVProgressExtension.swift
//  EducationNews
//
//  Created by 孔祥刚 on 2020/4/18.
//  Copyright © 2020 孔祥刚. All rights reserved.
//

import UIKit
import SVProgressHUD


extension SVProgressHUD {
    /// 设置 SVProgressHUD 属性
    
    static func configuration() {
        //    SVProgressHUD.setForegroundColor(UIColor.colorWithRGBA(75, G: 75, B: 75, A:1.0))
        SVProgressHUD.setForegroundColor(UIColor.white)
        SVProgressHUD.setMinimumDismissTimeInterval(100)
        SVProgressHUD.setImageViewSize(CGSize.init(width: 40, height: 40))
        SVProgressHUD.setBackgroundColor(UIColor.hexStringToUIColor(hexString: "000000", alpha: 0.8))
        
    }
    static func hsShowString(stats:String){
        //        SVProgressHUD.setForegroundColor(UIColor.colorWithRGBA(75, G: 75, B: 75, A:1.0))
        SVProgressHUD.setForegroundColor(UIColor.white)
        SVProgressHUD.setImageViewSize(CGSize.init(width: 0.1 , height: 0.1))
        SVProgressHUD.setBackgroundColor(UIColor.hexStringToUIColor(hexString: "000000", alpha: 0.8))
        SVProgressHUD.showError(withStatus: stats)
        SVProgressHUD.dismiss(withDelay: 1)

    }
    
    
    class  func hsShowErrorString(string : String?) {
            SVProgressHUD.configuration()
            SVProgressHUD.setErrorImage(UIImage(named: "error")!)
            SVProgressHUD.showError(withStatus: string ?? "")
            SVProgressHUD.dismiss(withDelay: 1.5)
    }
    
    class  func hsShowSucessString(string : String?) {
        SVProgressHUD.configuration()
        SVProgressHUD.setSuccessImage(UIImage(named: "success")!)
        SVProgressHUD.showSuccess(withStatus: string ?? "")
        SVProgressHUD.dismiss(withDelay: 1.5)
    }
    
    class func hsShowLoadingActivity(status: String? = nil)
    {
        SVProgressHUD.setImageViewSize(CGSize.init(width: 25, height: 25))
        SVProgressHUD.setBackgroundColor(UIColor.black)
        SVProgressHUD.show(UIImage(gifNamed:"loading")!, status: nil)
    }
        
        
        
        

        
}
