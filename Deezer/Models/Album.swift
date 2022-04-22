//
//  Album.swift
//  Deezer
//
//  Created by Andrii Momot on 20.04.2022.
//

import Foundation

struct AlbumsResponse: Decodable {
    let data: [Album]
}

struct Album: Decodable {
    let id: Int
    let title: String
    let cover: String?
    let artist: Artist?
    let tracks: TracksResponse?
}
