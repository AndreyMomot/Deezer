//
//  AlbumCoordinator.swift
//  Deezer
//
//  Created by Andrii Momot on 23.04.2022.
//

import UIKit

final class AlbumCoordinator: BaseCoordinator {
    private let presenter: UINavigationController
    private let album: Album
    var albumViewController: AlbumViewController?
    
    init(presenter: UINavigationController, album: Album) {
        self.presenter = presenter
        self.album = album
    }
    
    override func start() {
        let viewModel = AlbumViewModel(with: album)
        let albumViewController = instantiate(AlbumViewController.self)
        albumViewController.viewModel = viewModel
        presenter.pushViewController(albumViewController, animated: true)
        
        self.albumViewController = albumViewController
    }
}
