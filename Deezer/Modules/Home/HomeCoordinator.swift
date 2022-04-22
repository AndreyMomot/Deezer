//
//  HomeCoordinator.swift
//  Deezer
//
//  Created by Andrii Momot on 21.04.2022.
//

import UIKit

final class HomeCoordinator: BaseCoordinator {
    
    override func start() {
        let viewModel = HomeViewModel(api)
        let vc = instantiate(HomeViewController.self)
        vc.viewModel = viewModel
    }
}
