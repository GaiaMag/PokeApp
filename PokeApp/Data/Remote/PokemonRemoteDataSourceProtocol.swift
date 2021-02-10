//
//  PokemonRemoteDataSourceProtocol.swift
//  PokeApp
//
//  Created by Gaia Magnani on 10/02/2021.
//

import Foundation

protocol PokemonRemoteDataSourceProtocol {
    func getInitialPokemonList(completion: @escaping (Result<PokemonListModel, Error>) -> ())
    
    func getPokemonList(url: String, completion: @escaping (Result<PokemonListModel, Error>) -> ())
    
    func getPokemonDetail(url: String, completion: @escaping (Result<PokemonModel, Error>) -> ())
}
