//
//  DeezerTests.swift
//  DeezerTests
//
//  Created by Andrii Momot on 20.04.2022.
//

import XCTest
@testable import Deezer

class DeezerTests: XCTestCase {
    
    func testArtistCoordinator() {
        let bundle = Bundle(for: DeezerTests.self)
        guard let url = bundle.url(forResource: "artbat", withExtension: "json") else { return }
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(AlbumsResponse.self, from: data)
            let albums = jsonData.data
            let artist = Artist(id: 1, name: "Artbat", picture: nil)
            
            let nav = UINavigationController()
            let api = API()
            let coordinator = ArtistCoordinator(presenter: nav, api: api, artist: artist, albums: albums)
            coordinator.start()
            
            XCTAssertEqual(coordinator.artistViewController?.viewModel?.albums.value?.count, 24)
            XCTAssertEqual(coordinator.artistViewController?.viewModel?.artist?.id, 1)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testArtistViewModel() {
        let bundle = Bundle(for: DeezerTests.self)
        guard let url = bundle.url(forResource: "artbat", withExtension: "json") else { return }
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(AlbumsResponse.self, from: data)
            let albums = jsonData.data
            let artist = Artist(id: 1, name: "Artbat", picture: nil)
            let api = API()
            
            let viewModel = ArtistViewModel(with: api, artist: artist, albums: albums)
            let artistViewController = ArtistViewController.loadFromNib()
            artistViewController.viewModel = viewModel
            
            XCTAssertEqual(viewModel.albums.value?.count, 24)
            XCTAssertEqual(viewModel.artist?.id, 1)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testAlbumCoordinator() {
        let bundle = Bundle(for: DeezerTests.self)
        guard let url = bundle.url(forResource: "albums", withExtension: "json") else { return }
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let album = try decoder.decode(Album.self, from: data)
            
            let nav = UINavigationController()
            let coordinator = AlbumCoordinator(presenter: nav, album: album)
            coordinator.start()
            
            XCTAssertEqual(coordinator.albumViewController?.viewModel?.album.tracks?.data.count, 3)
            XCTAssertEqual(coordinator.albumViewController?.viewModel?.album.title, "Upperground - EP")
            XCTAssertEqual(coordinator.albumViewController?.viewModel?.album.id, 81332322)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testAlbumViewModel() {
        let bundle = Bundle(for: DeezerTests.self)
        guard let url = bundle.url(forResource: "albums", withExtension: "json") else { return }
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let album = try decoder.decode(Album.self, from: data)
            
            let viewModel = AlbumViewModel(with: album)
            let albumViewController = AlbumViewController.loadFromNib()
            albumViewController.viewModel = viewModel
            
            XCTAssertEqual(viewModel.album.tracks?.data.count, 3)
            XCTAssertEqual(viewModel.album.title, "Upperground - EP")
            XCTAssertEqual(viewModel.album.id, 81332322)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
