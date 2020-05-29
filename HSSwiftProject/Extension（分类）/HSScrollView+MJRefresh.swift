//
//  HSScrollView+MJRefresh.swift
//  EducationNews
//
//  Created by 孔祥刚 on 2020/3/21.
//  Copyright © 2020 孔祥刚. All rights reserved.
//

import Foundation
import UIKit
import MJRefresh



extension UIScrollView
{
    func footerEndRefreshing()
    {
        self.mj_footer?.endRefreshing()
    }
    
    func headerEndRefreshing()
    {
        self.mj_header?.endRefreshing()
    }
    
    func addHeader(withTarget: AnyObject, action: Selector)
    {
        let header = MJRefreshNormalHeader.init(refreshingTarget: withTarget, refreshingAction: action)
        header.lastUpdatedTimeLabel?.isHidden = true
        header.stateLabel?.isHidden = true
        self.mj_header = header
    }
    
    func addFooter(withTarget: AnyObject, action: Selector)
    {
        let footer = MJRefreshBackNormalFooter.init(refreshingTarget: withTarget, refreshingAction: action)
        footer.arrowView?.alpha = 0
//        footer?.stateLabel.isHidden = true
        footer.stateLabel?.textColor = UIColor.hexStringToUIColor(hexString: "#999999")
        footer.setTitle("已经到底喽～", for: .noMoreData)
        self.mj_footer = footer
    }
    
    func removeFooter()
    {
        self.mj_footer = nil
    }
}
