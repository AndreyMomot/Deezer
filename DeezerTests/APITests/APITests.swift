//
//  APITests.swift
//  DeezerTests
//
//  Created by Andrii Momot on 23.04.2022.
//

import XCTest
@testable import Deezer

class APITests: XCTestCase {
    let api: API = AppAPI()
    
    func testSearchResponse() {
        let expectation = self.expectation(description: "expectation")

        let request = SearchRequest(artist: "artbat")
        api.send(request) { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.data.count, 25)
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 3.0, handler: nil)
    }
    
    func testAlbumsResponse() {
        let expectation = self.expectation(description: "expectation")

        let request = AlbumsRequest(artistID: 8911470)
        api.send(request) { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.data.count, 24)
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 3.0, handler: nil)
    }
    
    func testAlbumResponse() {
        let expectation = self.expectation(description: "expectation")

        let request = AlbumInfoRequest(albumID: 81332322)
        api.send(request) { result in
            switch result {
            case .success(let album):
                XCTAssertEqual(album.tracks?.data.count, 3)
                XCTAssertEqual(album.title, "Upperground - EP")
                XCTAssertEqual(album.id, 81332322)
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 3.0, handler: nil)
    }
    
    func testArtistModel() {
        let bundle = Bundle(for: DeezerTests.self)
        guard let url = bundle.url(forResource: "search", withExtension: "json") else { return }
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(ArtistsResponse.self, from: data)
            let albums = jsonData.data
            XCTAssertEqual(albums.count, 25)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testAlbumModel() {
        let bundle = Bundle(for: DeezerTests.self)
        guard let url = bundle.url(forResource: "artbat", withExtension: "json") else { return }
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(AlbumsResponse.self, from: data)
            let albums = jsonData.data
            XCTAssertEqual(albums.count, 24)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testTrackModel() {
        let bundle = Bundle(for: DeezerTests.self)
        guard let url = bundle.url(forResource: "albums", withExtension: "json") else { return }
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let album = try decoder.decode(Album.self, from: data)
            XCTAssertEqual(album.tracks?.data.count, 3)
            XCTAssertEqual(album.title, "Upperground - EP")
            XCTAssertEqual(album.id, 81332322)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
