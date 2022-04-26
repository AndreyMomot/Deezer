//
//  ArtistViewModel.swift
//  Deezer
//
//  Created by Andrii Momot on 22.04.2022.
//

import Foundation

protocol ArtistViewModelProtocol {
    var albums: Bindable<[Album]> { get }
    var artist: Artist? { get }
    var selectedAlbum: Bindable<Album> { get }
    var error: Bindable<Error> { get }
}

final class ArtistViewModel: ArtistViewModelProtocol {
    private let api: API
    let albums = Bindable<[Album]>()
    let artist: Artist?
    var selectedAlbum = Bindable<Album>()
    var error = Bindable<Error>()
    
    init(with api: API, artist: Artist?, albums: [Album]?) {
        self.api = api
        self.artist = artist
        self.albums.value = albums
    }
    
    func getAlbumInfo(for albumID: Int) {
        let request = AlbumInfoRequest(albumID: albumID)
        api.send(request) {[weak self] result in
            switch result {
            case .success(let album):
                self?.selectedAlbum.value = album
            case .failure(let error):
                self?.error.value = error
            }
        }
    }
}
