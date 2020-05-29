//
//  HSNavigationController.swift
//  EducationNews
//
//  Created by 孔祥刚 on 2020/4/18.
//  Copyright © 2020 孔祥刚. All rights reserved.
//

import UIKit

class HSNavigationController: UINavigationController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.isTranslucent = true
        self.navigationBar.barTintColor = .white
        self.navigationBar.barStyle = UIBarStyle.default
        self.navigationBar.tintColor = .black
        self.navigationBar.shadowImage = UIImage()
    }
    
    /// 重写 push 方法，所有的 push 动作都会调用此方法！
    /// viewController 是被 push 的控制器，设置他的左侧的按钮作为返回按钮
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        // 如果不是栈底控制器才需要隐藏，根控制器不需要处理
        if children.count > 0 {
            // 隐藏底部的 TabBar
            viewController.hidesBottomBarWhenPushed = true
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image:UIImage.init(named: "Path.png"), style: .plain, target: self, action: #selector(popToParent))
        }
        
        super.pushViewController(viewController, animated: true)
    }
    
    /// POP 返回到上一级控制器
    @objc private func popToParent() {
        self.popViewController(animated: true)
    }
    
    
    override func popViewController(animated: Bool) -> UIViewController? {
        super.popViewController(animated: animated)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
