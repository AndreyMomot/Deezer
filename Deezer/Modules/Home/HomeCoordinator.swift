//
//  HomeCoordinator.swift
//  Deezer
//
//  Created by Andrii Momot on 21.04.2022.
//

import UIKit

final class HomeCoordinator: BaseCoordinator {
    private let presenter: UINavigationController
    private let api: API
    private var homeViewController: HomeViewController?
    private var artistCoordinator: ArtistCoordinator?
    
    init(presenter: UINavigationController, api: API) {
      self.presenter = presenter
      self.api = api
    }
    
    override func start() {
        let viewModel = HomeViewModel(with: api)
        let homeViewController = instantiate(HomeViewController.self)
        homeViewController.viewModel = viewModel
        homeViewController.onShowArtist = {[weak self] albums in
            self?.showArtistDetails(with: viewModel.selectedArtist, albums: albums)
        }
        presenter.pushViewController(homeViewController, animated: true)
        
        self.homeViewController = homeViewController
    }
}

extension HomeCoordinator {
    
    func showArtistDetails(with artist: Artist?, albums: [Album]) {
        let artistCoordinator = ArtistCoordinator(presenter: presenter, api: api, artist: artist, albums: albums)
        artistCoordinator.start()
        
        self.artistCoordinator = artistCoordinator
    }
}
