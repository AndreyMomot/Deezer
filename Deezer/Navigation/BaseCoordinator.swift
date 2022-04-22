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
    let api: APIProtocol
    var viewController: UIViewController?
    
    required init(with api: APIProtocol) {
        self.api = api
    }
    
    public func start() {
        assertionFailure("Please override this method in subclass")
    }
    
    func instantiate<T>(_ viewControllerType: T.Type) -> T where T: UIViewController {
        let instantiatedViewController = viewControllerType.loadFromNib()
        viewController = instantiatedViewController
        
        return instantiatedViewController
    }
}
