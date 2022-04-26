//
//  APIRequest.swift
//  Deezer
//
//  Created by Andrii Momot on 26.04.2022.
//

import Foundation

protocol APIRequest: Encodable {
    associatedtype Response: Decodable
    
    var path: String { get }
    func parameters() -> Any?
}

extension APIRequest {
    var jsonEncoder: JSONEncoder {
        return JSONEncoder()
    }
    
    func preperaParameters<T>(_ parameters: T) -> Any? where T: Encodable {
        guard let data = try? jsonEncoder.encode(parameters) else {
            return nil
        }
        
        return try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
    }
    
    func parameters() -> Any? {
        return preperaParameters(self)
    }
}
