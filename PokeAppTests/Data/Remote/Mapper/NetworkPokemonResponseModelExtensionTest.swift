//
//  NetworkPokemonResponseModelExtensionTest.swift
//  PokeAppTests
//
//  Created by Gaia Magnani on 10/02/2021.
//

import XCTest
@testable import PokeApp


class NetworkPokemonResponseModelExtensionTest: XCTestCase {
    
    private let pokemonResponseModel = NetworkPokemonResponseModel(count: 0, next: "next", previous: "previous", results: [NetworkPokemonResponseModel.NetworkPokemonResult(name: "first", url: "firstUrl"), NetworkPokemonResponseModel.NetworkPokemonResult(name: "second", url: "secondUrl")])
    
    func testExtensionAsDomain() {
        let pokemonListModel = pokemonResponseModel.asDomain()
        XCTAssertEqual("next", pokemonListModel.next)
        XCTAssertEqual(2, pokemonListModel.pokemonList.count)
        XCTAssertEqual("first", pokemonListModel.pokemonList[0].name)
        XCTAssertEqual("secondUrl", pokemonListModel.pokemonList[1].url)
        XCTAssertNil(pokemonListModel.pokemonList[0].imageUrl)
        XCTAssertEqual([], pokemonListModel.pokemonList[1].type)
        XCTAssertEqual(0, pokemonListModel.pokemonList[1].stats.count)
    }
}
