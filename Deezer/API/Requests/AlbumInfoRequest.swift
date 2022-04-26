//
//  AlbumInfoRequest.swift
//  Deezer
//
//  Created by Andrii Momot on 26.04.2022.
//

import Foundation

struct AlbumInfoRequest: APIRequest {
    typealias Response = Album
    
    var path: String {
        return "album/\(albumID)"
    }
    
    private(set) var albumID: Int
    
    init(albumID: Int) {
        self.albumID = albumID
    }
}
