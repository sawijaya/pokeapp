//
//  AppDelegate.swift
//  pokeapp
//
//  Created by Salim Wijaya on 02/02/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // Instantiate a window.
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        self.window = window
        self.window?.tag = 0xBABECAFE
        
        var vc: UIViewController!
        vc = AppContainer.shared.homeViewController
        window.rootViewController = vc

        return true
    }

}

