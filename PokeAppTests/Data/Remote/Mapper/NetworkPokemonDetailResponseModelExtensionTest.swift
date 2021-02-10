//
//  NetworkPokemonDetailResponseModelExtensionTest.swift
//  PokeAppTests
//
//  Created by Gaia Magnani on 10/02/2021.
//

import XCTest
@testable import PokeApp

private let pokemonStat = [NetworkPokemonDetailResponseModel.NetworkPokemonStat(baseStat: 1, effort: 2, stat: NetworkPokemonDetailResponseModel.NetworkPokemonStat.NetworkPokemonStat(name: "statName", url: "statUrl"))]

private let pokemonSprites = NetworkPokemonDetailResponseModel.NetworkPokemonSprite.init(backDefault: nil, backFemale: nil, backShiny: nil, backShinyFemale: nil, frontDefault: "frontDefault", frontFemale: nil, frontShiny: nil, frontShinyFemale: nil)

private let pokemonTypes = [NetworkPokemonDetailResponseModel.NetworkPokemonType.init(slot: 1, type:  NetworkPokemonDetailResponseModel.NetworkPokemonType.NetworkPokemonTypeDetail(name: "fire", url: "fireUrl")), NetworkPokemonDetailResponseModel.NetworkPokemonType.init(slot: 1, type:  NetworkPokemonDetailResponseModel.NetworkPokemonType.NetworkPokemonTypeDetail(name: "test", url: "testUrl"))]

fileprivate let pokemonResponseModel = NetworkPokemonDetailResponseModel(id: 1,
                                                                     name: "name",
                                                                     height: 20,
                                                                     baseExperience: 20,
                                                                     isDefault: true,
                                                                     locationAreaEncounters: nil,
                                                                     order: nil,
                                                                     weight: nil,
                                                                     stats: pokemonStat,
                                                                     sprites: pokemonSprites,
                                                                     types: pokemonTypes)

class NetworkPokemonDetailResponseModelExtensionTest: XCTestCase {

    func testExtensionAsDomain()  {
        let pokemonModel = pokemonResponseModel.asDomainModel(url: "url")
        XCTAssertEqual("name", pokemonModel?.name)
        XCTAssertEqual("url", pokemonModel?.url)
        XCTAssertEqual("frontDefault", pokemonModel?.imageUrl)
        XCTAssertEqual(1, pokemonModel?.stats.count)
        XCTAssertEqual("statName", pokemonModel?.stats.first?.name)
        XCTAssertEqual(1, pokemonModel?.stats.first?.value)
        XCTAssertEqual(2, pokemonModel?.type.count)
        XCTAssertEqual(.fire, pokemonModel?.type.first)
        XCTAssertEqual(.generic, pokemonModel?.type[1])
    }
}
