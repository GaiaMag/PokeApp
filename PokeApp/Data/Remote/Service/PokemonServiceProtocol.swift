//
//  PokemonServiceProtocol.swift
//  PokeApp
//
//  Created by Gaia Magnani on 10/02/2021.
//

import Foundation

protocol PokemonServiceProtocol {
    func request<T: Codable>(urlString: String, completion: @escaping (Result<T, Error>) -> ())
}
