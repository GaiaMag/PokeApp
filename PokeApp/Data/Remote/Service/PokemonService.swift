//
//  PokemonService.swift
//  PokeApp
//
//  Created by Gaia Magnani on 10/02/2021.
//

import Foundation

class PokemonService: PokemonServiceProtocol {
    
    private let session : URLSession
    
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    func request<T: Codable>(urlString: String, completion: @escaping (Result<T, Error>) -> ()) {
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "ServiceError", code: 1000, userInfo: nil) ))
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            
            guard response != nil, let data = data else {
                completion(.failure(NSError(domain: "ServiceError", code: 1001, userInfo: nil)))
                return
            }
            
            DispatchQueue.main.async {
                if let responseObject = try? JSONDecoder().decode(T.self, from: data) {
                    completion(.success(responseObject))
                } else {
                    let error = NSError(domain: "ServiceError", code: 1002, userInfo: nil)
                    completion(.failure(error))
                }
            }
        }
        
        dataTask.resume()
    }
    
}
