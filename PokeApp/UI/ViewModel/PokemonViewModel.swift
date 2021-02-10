//
//  PokemonViewModel.swift
//  PokeApp
//
//  Created by Gaia Magnani on 08/02/2021.
//

import Foundation

class PokemonViewModel {
    
    private let repository: PokemonRepositoryProtocol
    let pokemonList: Box<[UiPokemonModel]> = Box([])
    let navigateToDetail: Box<UiPokemonModel?> = Box(nil)
    
    init(repository: PokemonRepositoryProtocol = PokemonRepository()) {
        self.repository = repository
        self.repository.pokemonList.bind { [weak self] (pokemons) in
            self?.pokemonList.value = pokemons.map{UiPokemonModel(model: $0)}
        }
        self.loadPokemon()
    }
    
    func loadPokemon() {
        repository.loadPokemon()
    }
    
    func onCellSelected(model: UiPokemonModel) {
        navigateToDetail.value = model
    }
    
    func navigationDone() {
        navigateToDetail.value = nil
    }
}
