//
//  PokemonRepository.swift
//  PokeApp
//
//  Created by Gaia Magnani on 08/02/2021.
//

import Foundation

class PokemonRepository: PokemonRepositoryProtocol {
    
    let pokemonList: Box<[PokemonModel]> = Box([])
    
    private let remoteDataSource: PokemonRemoteDataSourceProtocol
    
    private var nextPageUrl: String? = ""
    
    private var isFetchInProgress: Bool = false
    
    init(remoteDataSource: PokemonRemoteDataSourceProtocol = PokemonRemoteDataSource()) {
        self.remoteDataSource = remoteDataSource
    }
    
    func loadPokemon() {
        guard !isFetchInProgress else {
            return
        }
        isFetchInProgress = true
        if nextPageUrl == "" {
            remoteDataSource.getInitialPokemonList { [weak self] result in
                self?.onRemoteResponseReceived(result: result)
            }
        } else if let nextPageUrl = nextPageUrl {
            remoteDataSource.getPokemonList(url: nextPageUrl) { [weak self] result in
                self?.onRemoteResponseReceived(result: result)
            }
        }
    }
    
    private func onRemoteResponseReceived(result: Result<PokemonListModel, Error>) {
        self.isFetchInProgress = false
        switch result {
        case .success(let model):
            nextPageUrl = model.next
            updatePokemonDetails(pokemonList: model.pokemonList)
        case .failure(_):
            break
        }
    }
    
    private func updatePokemonDetails(pokemonList: [PokemonModel]) {
        
        DispatchQueue.global(qos: .userInitiated).async {
            var localPokemon: [PokemonModel] = []
            let downloadGroup = DispatchGroup()
            for pokemon in pokemonList {
                downloadGroup.enter()
                self.remoteDataSource.getPokemonDetail(url: pokemon.url) { (result) in
                    downloadGroup.leave()
                    switch result {
                    case .success(let model):
                        localPokemon.append(model)
                    case .failure(_):
                        break
                    }
                }
            }
            downloadGroup.wait()
        
            DispatchQueue.main.async {
                self.pokemonList.value.append(contentsOf: localPokemon)
            }
        }
    }
}
