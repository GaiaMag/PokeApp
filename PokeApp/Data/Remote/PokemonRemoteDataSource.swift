//
//  NetworkRemoteDataSource.swift
//  PokeApp
//
//  Created by Gaia Magnani on 08/02/2021.
//

import Foundation

class PokemonRemoteDataSource: PokemonRemoteDataSourceProtocol {
    
    private let initialUrl = "https://pokeapi.co/api/v2/pokemon"
    
    private let service: PokemonServiceProtocol
    
    init(pokemonService: PokemonServiceProtocol = PokemonService()) {
        self.service = pokemonService
    }
    
    func getInitialPokemonList(completion: @escaping (Result<PokemonListModel, Error>) -> ()) {
        self.getPokemonList(url: initialUrl, completion: completion)
    }
    
    func getPokemonList(url: String, completion: @escaping (Result<PokemonListModel, Error>) -> ()) {
        self.service.request(urlString: url) { (result : Result<NetworkPokemonResponseModel, Error>) in
            
            switch result {
            case .success(let result):
                let pokemonList = result.asDomain()
                completion(.success(pokemonList))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getPokemonDetail(url: String, completion: @escaping (Result<PokemonModel, Error>) -> ()) {
        self.service.request(urlString: url) { (result : Result<NetworkPokemonDetailResponseModel, Error>) in
            switch result {
            case .success(let result):
                guard let result = result.asDomainModel(url: url) else {
                    completion(.failure(NSError(domain: "", code: 1, userInfo: nil)))
                    return
                }
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
