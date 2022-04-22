//
//  AlbumViewModel.swift
//  Deezer
//
//  Created by Andrii Momot on 22.04.2022.
//

import Foundation

protocol AlbumViewModelProtocol {
    var album: Album { get }
}

final class AlbumViewModel: AlbumViewModelProtocol {
    let album: Album
    
    init(_ album: Album) {
        self.album = album
    }
}
