//
//  ArtistCoordinator.swift
//  Deezer
//
//  Created by Andrii Momot on 22.04.2022.
//

import UIKit

final class ArtistCoordinator: BaseCoordinator {
    private let presenter: UINavigationController
    private let api: API
    private let artist: Artist?
    private let albums: [Album]?
    var artistViewController: ArtistViewController?
    private var albumCoordinator: AlbumCoordinator?
    
    init(presenter: UINavigationController, api: API, artist: Artist?, albums: [Album]?) {
        self.presenter = presenter
        self.api = api
        self.artist = artist
        self.albums = albums
    }
    
    override func start() {
        let viewModel = ArtistViewModel(with: api, artist: artist, albums: albums)
        let artistViewController = instantiate(ArtistViewController.self)
        artistViewController.viewModel = viewModel
        
        artistViewController.onShowAlbum = {[weak self] album in
            self?.showAlbumDetails(with: album)
        }
        presenter.pushViewController(artistViewController, animated: true)
        
        self.artistViewController = artistViewController
    }
}

extension ArtistCoordinator {
    
    func showAlbumDetails(with album: Album) {
        let albumCoordinator = AlbumCoordinator(presenter: presenter, album: album)
        albumCoordinator.start()
        
        self.albumCoordinator = albumCoordinator
    }
}
