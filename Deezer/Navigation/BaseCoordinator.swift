//
//  BaseCoordinator.swift
//  Deezer
//
//  Created by Andrii Momot on 21.04.2022.
//

import Foundation
import UIKit

enum PresentOperations {
    case root
    case push
    case present
}

public class BaseCoordinator: NSObject, Coordinator {
    
    func toPresentable() -> UIViewController {
        guard let viewController = viewController else {
            fatalError("viewController did not initialized")
        }
        return viewController
    }
    
    let api: APIProtocol
    var viewController: UIViewController?
    var navigationController: UINavigationController?
    
    required init(with api: APIProtocol) {
        self.api = api
    }
    
    public func start() {
        assertionFailure("Please override this method in subclass")
    }
    
    public func start<T: BaseCoordinator>(_ coordinator: T.Type) -> UINavigationController? {
        let coordinator = create(coordinator.self)
        coordinator.start()
        
        navigationController = UINavigationController()
        guard let vc = coordinator.viewController else { return navigationController }
        navigationController?.setViewControllers([vc], animated: true)

        return navigationController
    }
    
    func instantiate<T>(_ viewControllerType: T.Type) -> T where T: UIViewController {
        let instantiatedViewController = viewControllerType.loadFromNib()
        viewController = instantiatedViewController
        
        return instantiatedViewController
    }
    
    func create<T: BaseCoordinator>(_ coordinatorType: T.Type) -> T {
        return coordinatorType.init(with: api)
    }
}
