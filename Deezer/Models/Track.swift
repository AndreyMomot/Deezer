//
//  Track.swift
//  Deezer
//
//  Created by Andrii Momot on 20.04.2022.
//

import Foundation

struct TracksResponse: Decodable {
    let data: [Track]
}

struct Track: Decodable {
    var index: Int?
    let id: Int
    let title: String
    let artist: Artist?
    let duration: Int
}
