//
//  AppCoordinator.swift
//  Deezer
//
//  Created by Andrii Momot on 21.04.2022.
//

import Foundation
import UIKit

public class AppCoordinator {
    
    public func start<T: BaseCoordinator>(_ coordinator: T.Type) -> UINavigationController {
        let coordinator = create(coordinator.self)
        coordinator.start()
        
        let nav = UINavigationController()
        guard let vc = coordinator.viewController else { return nav }
        nav.setViewControllers([vc], animated: true)

        return nav
    }
    
    private func create<T: BaseCoordinator>(_ coordinatorType: T.Type) -> T {
        return coordinatorType.init(with: API())
    }
}
