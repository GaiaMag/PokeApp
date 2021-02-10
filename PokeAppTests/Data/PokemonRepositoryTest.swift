//
//  PokemonRepositoryTest.swift
//  PokeAppTests
//
//  Created by Gaia Magnani on 10/02/2021.
//

import XCTest
@testable import PokeApp

fileprivate let initialPokemonList = PokemonListModel(next: "next", pokemonList: [PokemonModel(name: "firstName", url: "firstUrl", imageUrl: nil, type: [], stats: [])])
fileprivate let nextPokemonList = PokemonListModel(next: "", pokemonList: [PokemonModel(name: "secondName", url: "secondUrl", imageUrl: nil, type: [], stats: [])])
fileprivate let firstPokemonModel = PokemonModel(name: "first", url: "firstUrl", imageUrl: "firstImageUrl", type: [], stats: [])
fileprivate let secondPokemonModel = PokemonModel(name: "second", url: "secondUrl", imageUrl: "secondImageUrl", type: [], stats: [])

class PokemonRepositoryTest: XCTestCase {
    private var remoteDataSource: PokemonRemoteDataSourceProtocol?
    private var repository: PokemonRepositoryProtocol?
    
    override func tearDown() {
        remoteDataSource = nil
        repository = nil
    }
    
    func testLoadPokemon() {
        remoteDataSource = FakePokemonRemoteDataSource()
        repository = PokemonRepository(remoteDataSource: remoteDataSource!)
        var firstName: String?
        var firstUrl: String?
        var firstImageUrl: String?
        var firstPokemonCount: Int?
        var secondName: String?
        var secondUrl: String?
        var secondImageUrl: String?
        var secondPokemonCount: Int?
        XCTAssertEqual(0, repository?.pokemonList.value.count)
        let loadingExpectation = self.expectation(description: "firstExpectation")
        repository?.pokemonList.bind(listener: { (model) in
            if model.count > 1 {
                secondName = model[1].name
                secondUrl = model[1].url
                secondImageUrl = model[1].imageUrl
                secondPokemonCount = model.count
                loadingExpectation.fulfill()
            } else if model.count > 0 {
                firstName = model[0].name
                firstUrl = model[0].url
                firstImageUrl = model[0].imageUrl
                firstPokemonCount = model.count
                self.repository?.loadPokemon()
            }
        })
        repository?.loadPokemon()
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual("first", firstName)
        XCTAssertEqual("firstUrl", firstUrl)
        XCTAssertEqual("firstImageUrl", firstImageUrl)
        XCTAssertEqual(1, firstPokemonCount)
        XCTAssertEqual("second", secondName)
        XCTAssertEqual("secondUrl", secondUrl)
        XCTAssertEqual("secondImageUrl", secondImageUrl)
        XCTAssertEqual(2, secondPokemonCount)
    }
}

fileprivate class FakePokemonRemoteDataSource : PokemonRemoteDataSourceProtocol {
    func getInitialPokemonList(completion: @escaping (Result<PokemonListModel, Error>) -> ()) {
        completion(.success(initialPokemonList))
    }
    
    func getPokemonList(url: String, completion: @escaping (Result<PokemonListModel, Error>) -> ()) {
        if url == "next" {
            completion(.success(nextPokemonList))
        } else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: nil)))
        }
    }
    
    func getPokemonDetail(url: String, completion: @escaping (Result<PokemonModel, Error>) -> ()) {
        if url == "firstUrl" {
            completion(.success(firstPokemonModel))
        } else if url == "secondUrl" {
            completion(.success(secondPokemonModel))
        } else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: nil)))
        }
    }
    
    
}
