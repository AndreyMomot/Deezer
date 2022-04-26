//
//  AppAPI.swift
//  Deezer
//
//  Created by Andrii Momot on 26.04.2022.
//

import Foundation

class AppAPI: API {
    
    func send<T>(_ request: T, completion: @escaping (Result<T.Response, Error>) -> Void) where T: APIRequest {
        guard let path = "https://api.deezer.com/\(request.path)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        
        var components = URLComponents(string: path)
        if let parameters = request.parameters() as? [String: Any] {
            components?.queryItems = parameters.map { key, value in
                URLQueryItem(name: key, value: String(describing: value))
            }
        }
        
        guard let url = components?.url else {
                  let error = AppError.defaultError
                  completion(.failure(error))
                  return
              }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            do {
                let object = try JSONDecoder().decode(T.Response.self, from: data)
                completion(.success(object))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
