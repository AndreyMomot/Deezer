//
//  Artist.swift
//  Deezer
//
//  Created by Andrii Momot on 20.04.2022.
//

import Foundation

struct ArtistsResponse: Decodable {
    let data: [Artist]
}

struct Artist: Decodable {
    let id: Int
    let name: String
    let picture: String?
}
