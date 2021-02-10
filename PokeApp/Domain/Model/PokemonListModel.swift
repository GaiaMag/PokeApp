//
//  PokemonListModel.swift
//  PokeApp
//
//  Created by Gaia Magnani on 08/02/2021.
//

import Foundation

struct PokemonListModel {
    // next is null when the last pokemon available is present in the response
    let next: String?
    let pokemonList: [PokemonModel]
}
