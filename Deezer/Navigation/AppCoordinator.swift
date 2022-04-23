//
//  AppCoordinator.swift
//  Deezer
//
//  Created by Andrii Momot on 23.04.2022.
//

import UIKit

final class AppCoordinator: Coordinator {
  let api: API
  let window: UIWindow
  let rootViewController: UINavigationController
  let homeCoordinator: HomeCoordinator
  
  init(window: UIWindow) {
    self.window = window
    api = API()
    rootViewController = UINavigationController()
      
    homeCoordinator = HomeCoordinator(presenter: rootViewController, api: api)
  }
  
  func start() {
    window.rootViewController = rootViewController
    homeCoordinator.start()
    window.makeKeyAndVisible()
  }
}
