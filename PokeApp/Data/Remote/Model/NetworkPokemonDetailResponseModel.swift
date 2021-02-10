//
//  NetworkPokemonDetailResponseModel.swift
//  PokeApp
//
//  Created by Gaia Magnani on 08/02/2021.
//

import Foundation

struct NetworkPokemonDetailResponseModel: Codable {
    let id: Int?
    let name: String?
    let height: Int?
    let baseExperience: Int?
    let isDefault: Bool?
    let locationAreaEncounters: String?
    let order: Int?
    let weight: Int?
    let stats: [NetworkPokemonStat]?
    let sprites: NetworkPokemonSprite?
    let types: [NetworkPokemonType]?
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case height
        case baseExperience = "base_experience"
        case isDefault = "is_default"
        case locationAreaEncounters = "location_area_encounters"
        case order
        case weight
        case stats
        case sprites
        case types
    }
    
    struct NetworkPokemonStat: Codable {
        let baseStat: Int?
        let effort: Int?
        let stat: NetworkPokemonStat?
        
        enum CodingKeys: String, CodingKey {
            case baseStat = "base_stat"
            case effort
            case stat
        }
        
        struct NetworkPokemonStat: Codable {
            let name: String?
            let url: String?
        }
    }

    struct NetworkPokemonSprite: Codable {
        let backDefault: String?
        let backFemale: String?
        let backShiny: String?
        let backShinyFemale: String?
        let frontDefault: String?
        let frontFemale: String?
        let frontShiny: String?
        let frontShinyFemale: String?
        
        enum CodingKeys: String, CodingKey {
            case backDefault = "back_default"
            case backFemale = "back_female"
            case backShiny = "back_shiny"
            case backShinyFemale = "back_shiny_female"
            case frontDefault = "front_default"
            case frontFemale = "front_female"
            case frontShiny = "front_shiny"
            case frontShinyFemale = "front_shiny_female"
        }
    }
    
    struct NetworkPokemonType: Codable {
        let slot: Int?
        let type: NetworkPokemonTypeDetail?
        
        struct NetworkPokemonTypeDetail: Codable {
            let name: String?
            let url: String?
        }
    }
}



