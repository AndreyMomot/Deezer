//
//  SearchRequest.swift
//  Deezer
//
//  Created by Andrii Momot on 26.04.2022.
//

import Foundation

struct SearchRequest: APIRequest {    
    typealias Response = ArtistsResponse
    
    var path: String {
        return "search/artist"
    }
    
    private(set) var artist: String
    
    init(artist: String) {
        self.artist = artist
    }
    
    func parameters() -> Any? {
        return ["q": artist]
    }
}
