//
//  AlbumsRequest.swift
//  Deezer
//
//  Created by Andrii Momot on 26.04.2022.
//

import Foundation

struct AlbumsRequest: APIRequest {
    typealias Response = AlbumsResponse
    
    var path: String {
        return "artist/\(artistID)/albums"
    }
    
    private(set) var artistID: Int
    
    init(artistID: Int) {
        self.artistID = artistID
    }
}
