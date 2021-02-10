//
//  NetworkPokemonDetailResponseModelExtension.swift
//  PokeApp
//
//  Created by Gaia Magnani on 08/02/2021.
//

import Foundation

extension NetworkPokemonDetailResponseModel {
    func asDomainModel(url: String) -> PokemonModel? {
        guard let name = name else {return nil}
        return PokemonModel(name: name,
                            url: url,
                            imageUrl: self.sprites?.frontDefault,
                            type: self.types?.map {
                                guard let name = $0.type?.name else {
                                    return .generic
                                }
                                return PokemonModel.PokemonType.init(rawValue: name) ?? .generic
                            } ?? [],
                            stats: self.stats?.compactMap {
                                guard let stat = $0.stat?.name, let base = $0.baseStat else {
                                    return nil
                                }
                                return PokemonModel.PokemonStat(name: stat, value: base)} ?? [])
    }
}
