//
//  HomeViewModel.swift
//  Deezer
//
//  Created by Andrii Momot on 21.04.2022.
//

import Foundation

protocol HomeViewModelProtocol {
    func search(for artist: String)
    func getAlbums(for artistID: Int)
    
    var artists: Bindable<[Artist]> { get }
    var albums: Bindable<[Album]> { get }
    var error: Bindable<Error> { get }
    var selectedArtist: Artist? { get set }
    var previousSearch: String? { get set }
}

final class HomeViewModel: HomeViewModelProtocol {
    private let api: APIProtocol
    var artists = Bindable<[Artist]>()
    var albums = Bindable<[Album]>()
    var error = Bindable<Error>()
    var selectedArtist: Artist?
    var previousSearch: String?
    
    init(with api: APIProtocol) {
        self.api = api
    }
    
    func search(for artist: String) {
        previousSearch = artist
        api.search(for: artist) {[weak self] result  in
            switch result {
            case .success(let artists):
                self?.artists.value = artists
            case .failure(let error):
                self?.error.value = error
            }
        }
    }
    
    func getAlbums(for artistID: Int) {
        api.getAlbums(for: artistID) {[weak self] result in
            switch result {
            case .success(let albums):
                self?.albums.value = albums
            case .failure(let error):
                self?.error.value = error
            }
        }
    }
}
