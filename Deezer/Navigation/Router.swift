//
//  Router.swift
//  Deezer
//
//  Created by Andrii Momot on 22.04.2022.
//

import UIKit

enum RouterPresentOperation {
    case root
    case push
    case present
}

struct RouterOptions {
    var operation: RouterPresentOperation = .push
    var animated: Bool = true
    var isNavigationBarHidden: Bool = false
    
    static var `rootDefault`: RouterOptions {
        return RouterOptions(operation: .root, animated: true, isNavigationBarHidden: false)
    }
    
    static var `pushDefault`: RouterOptions {
        return RouterOptions(operation: .push, animated: true, isNavigationBarHidden: false)
    }
    
    static var `presentDefault`: RouterOptions {
        return RouterOptions(operation: .present, animated: true, isNavigationBarHidden: false)
    }
}

protocol RoutableDelegate: AnyObject {
    func didShowViewController(_ viewController: UIViewController)
}

protocol Routable: AnyObject, Presentable {
    var presenter: UINavigationController { get }
    var rootViewController: UIViewController? { get }
    var delegate: RoutableDelegate? { get set }
    
    func show(_ viewController: Presentable?)
    func show(_ viewController: Presentable?, options: RouterOptions?, completion: (() -> Void)?)
    func hide()
    func hide(options: RouterOptions?)
    func hide(options: RouterOptions?, completion: (() -> Void)?)
}

final class Router: NSObject, Routable {
    
    private var completions: [UIViewController: () -> Void]
    private var rootCompletions: [UIViewController: () -> Void]
    
    let presenter: UINavigationController
    
    var rootViewController: UIViewController? {
        return presenter.viewControllers.first
    }
    
    weak var delegate: RoutableDelegate?
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
        completions = [:]
        rootCompletions = [:]
        
        super.init()
        
        presenter.delegate = self
    }
    
    func show(_ viewController: Presentable?) {
        show(viewController, options: nil, completion: nil)
    }
    
    func show(_ viewController: Presentable?, options: RouterOptions? = nil, completion: (() -> Void)? = nil) {
        guard let viewController = viewController else {
            assertionFailure("viewController is nil")
            return
        }
        
        var showOptions = RouterOptions()
        
        if let options = options {
            showOptions = options
        }
        
        DispatchQueue.main.async { [weak self] in
            switch showOptions.operation {
            case .root:
                // perform and clean all completions
                self?.completions.forEach { [weak self] in
                    self?.performCompletion(for: $0.key)
                }
                
                // perform and clean all root completions
                self?.rootCompletions.forEach { [weak self] in
                    self?.performRootCompletion(for: $0.key)
                }
   
                // save current room completions
                if let completion = completion {
                    self?.rootCompletions[viewController.toPresentable()] = completion
                }
                
                self?.presenter.setViewControllers([viewController.toPresentable()], animated: showOptions.animated)
                self?.presenter.isNavigationBarHidden = showOptions.isNavigationBarHidden
                self?.delegate?.didShowViewController(viewController.toPresentable())
            case .push:
                guard viewController is UINavigationController == false else {
                    return
                }
                
                if let completion = completion {
                    self?.completions[viewController.toPresentable()] = completion
                }
                
                self?.presenter.pushViewController(viewController.toPresentable(), animated: showOptions.animated)
                self?.delegate?.didShowViewController(viewController.toPresentable())
            case .present:
                if let completion = completion {
                    self?.completions[viewController.toPresentable()] = completion
                }
                
                viewController.toPresentable().modalPresentationStyle = .fullScreen
                self?.presenter.present(viewController.toPresentable(), animated: showOptions.animated, completion: { [weak self] in
                    self?.delegate?.didShowViewController(viewController.toPresentable())
                })
            }
        }
    }
    
    func hide() {
        hide(options: nil, completion: nil)
    }
    
    func hide(options: RouterOptions?) {
        hide(options: options, completion: nil)
    }
    
    func hide(options: RouterOptions?, completion: (() -> Void)? = nil) {
        var hideOptions = RouterOptions()
        
        if let options = options {
            hideOptions = options
        }
        
        switch hideOptions.operation {
        case .root:
            if let viewControllers = presenter.popToRootViewController(animated: hideOptions.animated) {
                viewControllers.forEach { performCompletion(for: $0) }
            }
            
            completion?()
        case .push:
            if let viewController = presenter.popViewController(animated: hideOptions.animated) {
                performCompletion(for: viewController)
            }
            
            completion?()
            
        case .present:
            if let viewController = presenter.presentedViewController {
                performCompletion(for: viewController)
            }
            
            presenter.dismiss(animated: hideOptions.animated, completion: completion)
        }
    }
    
    // MARK: Presentable
    
    func toPresentable() -> UIViewController {
        return presenter
    }
    
}

// MARK: - Helpers

extension Router {
    
    fileprivate func performCompletion(for controller: UIViewController) {
        guard let completion = completions[controller] else {
            return
        }
        
        completion()
        completions.removeValue(forKey: controller)
    }
    
    fileprivate func performRootCompletion(for controller: UIViewController) {
        guard let completion = rootCompletions[controller] else {
            return
        }
        
        completion()
        rootCompletions.removeValue(forKey: controller)
    }
    
}

// MARK: - UINavigationControllerDelegate

extension Router: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let viewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
            !navigationController.viewControllers.contains(viewController) else {
                return
        }
        
        performCompletion(for: viewController)
    }
    
}


