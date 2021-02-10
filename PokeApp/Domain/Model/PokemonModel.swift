//
//  PokemonModel.swift
//  PokeApp
//
//  Created by Gaia Magnani on 08/02/2021.
//

import Foundation

struct PokemonModel {
    let name: String
    let url: String
    let imageUrl: String?
    let type: [PokemonType]
    let stats: [PokemonStat]
    
    enum PokemonType: String {
        case fire
        case normal
        case water
        case poison
        case grass
        case electric
        case flying
        case bug
        case generic
    }
    
    struct PokemonStat {
        let name: String
        let value: Int
    }
}
