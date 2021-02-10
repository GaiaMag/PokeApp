//
//  NetworkPokemonResponseModel.swift
//  PokeApp
//
//  Created by Gaia Magnani on 08/02/2021.
//

import Foundation

struct NetworkPokemonResponseModel: Codable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [NetworkPokemonResult]?
    
    struct NetworkPokemonResult: Codable {
        let name: String?
        let url: String?
    }
}


