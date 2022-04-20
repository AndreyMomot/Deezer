//
//  AppDelegate.swift
//  Deezer
//
//  Created by Andrii Momot on 20.04.2022.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)

        let navigationController = UINavigationController()
        window?.rootViewController = navigationController

        let vc = HomeViewController()
        navigationController.setViewControllers([vc], animated: true)
        
        window?.makeKeyAndVisible()
        
        return true
    }


}
