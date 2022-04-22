//
//  ArtistCoordinator.swift
//  Deezer
//
//  Created by Andrii Momot on 22.04.2022.
//

import UIKit

final class ArtistCoordinator: BaseCoordinator {
    
    var albums: [Album]?

    override func start() {
        guard let albums = albums else { return }
        let viewModel = ArtistViewModel(api, artist: nil, albums: albums)
        let vc = instantiate(ArtistViewController.self)
        vc.viewModel = viewModel
    }
}
