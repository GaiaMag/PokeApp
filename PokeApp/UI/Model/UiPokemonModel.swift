//
//  UiPokemonModel.swift
//  PokeApp
//
//  Created by Gaia Magnani on 09/02/2021.
//

import Foundation
import UIKit

struct UiPokemonModel {
    let name: String
    let imageUrl: String?
    let mainColor: UIColor
    var type: [UiPokemonType]
    let stats: [UiPokemonStat]
    
    struct UiPokemonType {
        let type: String
        let color: UIColor
    }
    
    struct UiPokemonStat {
        let name: String
        let value: Int
    }
    
    init(model: PokemonModel) {
        name = model.name.capitalized
        imageUrl = model.imageUrl
        stats = model.stats.map { UiPokemonStat(name: $0.name, value: $0.value) }
        mainColor = UiPokemonModel.getColorForType(type: model.type.first).withAlphaComponent(0.9)
        type = model.type.map{ UiPokemonType(type: $0.rawValue, color: UiPokemonModel.getColorForType(type: $0)) }
    }
    
    private static func getColorForType(type: PokemonModel.PokemonType?) -> UIColor {
        let color: UIColor
        switch type {
        case .fire:
            color =  UIColor(red: 234/256, green: 117/256, blue: 113/256, alpha: 1.0)
        case .water:
            color =  UIColor(red: 133/256, green: 188/256, blue: 248/256, alpha: 1.0)
        case .poison:
            color = UIColor(red: 121/256, green: 105/256, blue: 167/256, alpha: 1.0)
        case .grass:
            color = UIColor(red: 112/256, green: 205/256, blue: 117/256, alpha: 1.0)
        case .electric:
            color = UIColor(red: 248/256, green: 207/256, blue: 99/256, alpha: 1.0)
        case .flying:
            color = UIColor(red: 195/256, green: 220/256, blue: 242/256, alpha: 1.0)
        case .bug:
            color = UIColor(red: 223/256, green: 116/256, blue: 149/256, alpha: 1.0)
        default:
            color = UIColor(red: 178/256, green: 160/256, blue: 143/256, alpha: 1.0)
        }
        return color
    }
}

