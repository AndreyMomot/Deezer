//
//  API.swift
//  Deezer
//
//  Created by Andrii Momot on 20.04.2022.
//

import Foundation

protocol API {
    func send<T>(_ request: T, completion: @escaping (Result<T.Response, Error>) -> Void) where T: APIRequest
}
