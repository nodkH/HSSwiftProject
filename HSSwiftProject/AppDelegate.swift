//
//  AppDelegate.swift
//  HSSwiftProject
//
//  Created by 孔祥刚 on 2020/5/18.
//  Copyright © 2020 孔祥刚. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let nav = UINavigationController(rootViewController: ViewController())
        window?.rootViewController = nav
        
        return true
    }



}

