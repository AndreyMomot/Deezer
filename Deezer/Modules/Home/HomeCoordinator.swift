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
        vc.onShowArtist = {[weak self] artistID in

//            self?.showArtistDetails(with: artistID)
        }
    }
}

extension HomeCoordinator {
    
//    func showArtistDetails(with artistID: Int) {
//        let coordinator = create(ArtistCoordinator.self)
//        coordinator.artistID = artistID
//        coordinator.start()
//        guard let vc = coordinator.viewController else { return }
//        navigationController?.present(vc, animated: true, completion: nil)
//    }
}
