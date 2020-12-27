//
//  AppDelegate.swift
//  ClassifiedDemo
//
//  Created by Takvir Hossain Tusher on 20/12/20.
//  Copyright © 2020 Demo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let initialViewController = ProductListBuilder.build()
        let navigationController = UINavigationController(rootViewController: initialViewController)
        
        // Set up tab bar controller
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [navigationController]
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        return true
    }

}

