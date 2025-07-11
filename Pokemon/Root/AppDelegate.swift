//
//  AppDelegate.swift
//  Pokemon
//
//  Created by Steven Lie on 08/07/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.rootViewController = UINavigationController(rootViewController: HomeInjection.provideHomeViewController())
        window?.rootViewController = isUserHasLogin()
        window?.makeKeyAndVisible()
        
        return true
    }
    
    fileprivate func isUserHasLogin() -> UIViewController {
        if UserDefaults.standard.string(forKey: "email") != nil { // user has login
            return UINavigationController(rootViewController: TabbarViewController())
        } else {
            return UINavigationController(rootViewController: LoginViewController())
        }
    }
}

