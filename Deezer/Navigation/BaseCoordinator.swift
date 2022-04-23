//
//  BaseCoordinator.swift
//  Deezer
//
//  Created by Andrii Momot on 21.04.2022.
//

import UIKit

class BaseCoordinator: Coordinator {
    
    func start() {
        assertionFailure("This method must be overrided")
    }

    func instantiate<T>(_ viewControllerType: T.Type) -> T where T: UIViewController {
        let instantiatedViewController = viewControllerType.loadFromNib()
        return instantiatedViewController
    }
}
