//
//  NetworkPokemonResponseModelExtension.swift
//  PokeApp
//
//  Created by Gaia Magnani on 08/02/2021.
//

import Foundation

extension NetworkPokemonResponseModel {
    func asDomain() -> PokemonListModel {
        return PokemonListModel(next: next,
                                pokemonList: (results ?? []).compactMap {
                                    $0.asDomain()
                                })
    }
}

extension NetworkPokemonResponseModel.NetworkPokemonResult {
    fileprivate func asDomain() -> PokemonModel? {
        guard let name = name, let url = url else {
            return nil
        }
        return PokemonModel(name: name,
                            url: url,
                            imageUrl: nil,
                            type: [],
                            stats: [])
    }
}
