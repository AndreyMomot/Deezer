//
//  API.swift
//  Deezer
//
//  Created by Andrii Momot on 20.04.2022.
//

import Foundation

protocol APIProtocol {
    func search(for artist: String, completion: @escaping (Result<[Artist], Error>) -> Void)
    func getAlbums(for artistID: Int, completion: @escaping (Result<[Album], Error>) -> Void)
    func getAlbumInfo(_ albumID: Int, completion: @escaping (Result<Album, Error>) -> Void)
}

final class API: APIProtocol {
    private let baseURL = "https://api.deezer.com/"
    private let searchArtist = "search/artist?q="
    private let artist = "artist"
    private let album = "album"
    private let albums = "albums"
    
    func search(for artist: String, completion: @escaping (Result<[Artist], Error>) -> Void) {
        let path = "\(searchArtist)\(artist)"
        getRequest(path, decode: ArtistsResponse.self) { result in
            switch result {
            case .success(let response):
                completion(.success(response.data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getAlbums(for artistID: Int, completion: @escaping (Result<[Album], Error>) -> Void) {
        let path = "\(artist)/\(artistID)/\(albums)"
        getRequest(path, decode: AlbumsResponse.self) { result in
            switch result {
            case .success(let response):
                completion(.success(response.data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getAlbumInfo(_ albumID: Int, completion: @escaping (Result<Album, Error>) -> Void) {
        let path = "\(album)/\(albumID)"
        getRequest(path, decode: Album.self, completion: completion)
    }
        
    private func getRequest<T: Decodable>(_ path: String, decode decodable: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        let fullPath = "\(baseURL)\(path)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard let fullPath = fullPath, let url = URL(string: fullPath) else {
            let error = AppError.defaultError
            completion(.failure(error))
            return
        }
        let request = URLRequest(url: url)
        performRequest(request, decode: T.self, result: completion)
    }
    
    private func performRequest<T: Decodable>(_ request: URLRequest, decode decodable: T.Type, result: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            do {
                let object = try JSONDecoder().decode(decodable, from: data)
                result(.success(object))
            } catch {
                result(.failure(error))
            }
        }.resume()
    }
}
