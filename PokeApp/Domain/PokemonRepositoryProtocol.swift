//
//  PokemonRepositoryProtocol.swift
//  PokeApp
//
//  Created by Gaia Magnani on 10/02/2021.
//

import Foundation

protocol PokemonRepositoryProtocol {
    func loadPokemon()
    var pokemonList: Box<[PokemonModel]> { get }
}
