//
//  HomeViewModel.swift
//  Deezer
//
//  Created by Andrii Momot on 21.04.2022.
//

import Foundation

protocol HomeViewModelProtocol {
    func search(for artist: String)
    
    var artists: Bindable<[Artist]> { get }
    var error: Bindable<Error> { get }
}

class HomeViewModel: HomeViewModelProtocol {
    let api: APIProtocol
    var artists = Bindable<[Artist]>()
    var error = Bindable<Error>()
    
    init(_ api: APIProtocol) {
        self.api = api
    }
    
    func search(for artist: String) {
        api.search(for: artist) {[weak self] result  in
            switch result {
            case .success(let artists):
                self?.artists.value = artists
                self?.getAlbums(for: artists.first!.id)
            case .failure(let error):
                self?.error.value = error
            }
        }
    }
    
    func getAlbums(for artistID: Int) {
        api.getAlbums(for: artistID) {[weak self] result in
            switch result {
            case .success(let albums):
                print(albums)
                self?.getAlbumInfo(for: albums.first!.id)
            case .failure(let error):
                self?.error.value = error
            }
        }
    }
    
    func getAlbumInfo(for albumID: Int) {
        api.getAlbumInfo(albumID) {[weak self] result in
            switch result {
            case .success(let album):
                print(album)
                
            case .failure(let error):
                self?.error.value = error
            }
        }
    }
    
    
}
