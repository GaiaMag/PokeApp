//
//  PokemonViewModelTest.swift
//  PokeAppTests
//
//  Created by Gaia Magnani on 10/02/2021.
//

import XCTest
@testable import PokeApp

class PokemonViewModelTest: XCTestCase {
    
    private var viewModel: PokemonViewModel?
    private var repository: FakeRepository?
    
    private let pokemonModel = PokemonModel(name: "name", url: "url", imageUrl: "imageUrl", type: [], stats: [])
    
    override func setUp()  {
        repository = FakeRepository()
    }

    override func tearDown()  {
       viewModel = nil
    }

    func testLoadRepositoryIsCalled() {
        viewModel = PokemonViewModel(repository: repository!)
        XCTAssertEqual(1, repository?.testNumber)
        viewModel?.loadPokemon()
        XCTAssertEqual(2, repository?.testNumber)
    }
    
    func testPokemonListIsUpdated() {
        viewModel = PokemonViewModel(repository: repository!)
        XCTAssertEqual(0, viewModel?.pokemonList.value.count)
        repository?.updatePokemonList(list: [pokemonModel])
        XCTAssertEqual("Name", viewModel?.pokemonList.value[0].name)
    }
    
    func testPokemonNavigation() {
        viewModel = PokemonViewModel(repository: repository!)
        XCTAssertNil(viewModel?.navigateToDetail.value)
        viewModel?.onCellClick(model: UiPokemonModel(model: pokemonModel))
        XCTAssertEqual("Name", viewModel?.navigateToDetail.value?.name)
        viewModel?.navigationDone()
        XCTAssertNil(viewModel?.navigateToDetail.value)
    }

    
    class FakeRepository: PokemonRepositoryProtocol {
        var testNumber = 0
        func loadPokemon() {
            testNumber += 1
        }
        
        let pokemonList: Box<[PokemonModel]> = Box([])
        
        func updatePokemonList(list: [PokemonModel]) {
            self.pokemonList.value = list
        }
    }
}
