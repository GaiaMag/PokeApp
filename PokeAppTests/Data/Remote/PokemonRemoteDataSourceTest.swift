//
//  PokemonRemoteDataSourceTest.swift
//  PokeAppTests
//
//  Created by Gaia Magnani on 10/02/2021.
//

import XCTest
@testable import PokeApp

fileprivate let firstPokemonResultModel = NetworkPokemonResponseModel.NetworkPokemonResult(name: "first", url: "firstUrl")
fileprivate let secondPokemonResultModel = NetworkPokemonResponseModel.NetworkPokemonResult(name: "second", url: "secondUrl")
fileprivate let pokemonDetailModel = NetworkPokemonDetailResponseModel(id: 0, name: "detail", height: 0, baseExperience: 0, isDefault: false, locationAreaEncounters: nil, order: 0, weight: 0, stats: [], sprites: NetworkPokemonDetailResponseModel.NetworkPokemonSprite(backDefault: nil, backFemale: nil, backShiny: nil, backShinyFemale: nil, frontDefault: "detailImageUrl", frontFemale: nil, frontShiny: nil, frontShinyFemale: nil), types: [])
fileprivate let initalPokemonResponseNetworkModel = NetworkPokemonResponseModel(count: 0, next: "initial", previous: nil, results: [firstPokemonResultModel, secondPokemonResultModel])
fileprivate let nextPokemonResponseNetworkModel = NetworkPokemonResponseModel(count: 0, next: "next", previous: nil, results: [secondPokemonResultModel, firstPokemonResultModel])

class PokemonRemoteDataSourceTest: XCTestCase {
    
    private var remoteDataSource: PokemonRemoteDataSourceProtocol?
    private var service: PokemonServiceProtocol?
    
    override func tearDown() {
        self.remoteDataSource = nil
        self.service = nil
    }
    
    func testGetInitialPokemonList() {
        service = FakePokemonService()
        var nextUrl: String?
        var firstPokemonName: String?
        var firstPokemonUrl: String?
        var secondPokemonName: String?
        var secondPokemonUrl: String?
        var pokemonCount: Int?
        remoteDataSource = PokemonRemoteDataSource(pokemonService: service!)
        let expectations = self.expectation(description: "loadingData")
        remoteDataSource?.getInitialPokemonList(completion: { (result) in
            switch result {
            case .success(let model):
                nextUrl = model.next
                pokemonCount = model.pokemonList.count
                firstPokemonName = model.pokemonList[0].name
                firstPokemonUrl = model.pokemonList[0].url
                secondPokemonName = model.pokemonList[1].name
                secondPokemonUrl = model.pokemonList[1].url
                break
            case .failure(_):
                break
            }
            expectations.fulfill()
        })
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual("initial", nextUrl)
        XCTAssertEqual("first", firstPokemonName)
        XCTAssertEqual("firstUrl", firstPokemonUrl)
        XCTAssertEqual("second", secondPokemonName)
        XCTAssertEqual("secondUrl", secondPokemonUrl)
        XCTAssertEqual(2, pokemonCount)
    }
    
    func testGetPokemonList() {
        service = FakePokemonService()
        var nextUrl: String?
        var firstPokemonName: String?
        var firstPokemonUrl: String?
        var secondPokemonName: String?
        var secondPokemonUrl: String?
        var pokemonCount: Int?
        remoteDataSource = PokemonRemoteDataSource(pokemonService: service!)
        let expectations = self.expectation(description: "loadingData")
        remoteDataSource?.getPokemonList(url: "next", completion: { (result) in
            switch result {
            case .success(let model):
                nextUrl = model.next
                pokemonCount = model.pokemonList.count
                firstPokemonName = model.pokemonList[0].name
                firstPokemonUrl = model.pokemonList[0].url
                secondPokemonName = model.pokemonList[1].name
                secondPokemonUrl = model.pokemonList[1].url
                break
            case .failure(_):
                break
            }
            expectations.fulfill()
        })
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual("next", nextUrl)
        XCTAssertEqual("second", firstPokemonName)
        XCTAssertEqual("secondUrl", firstPokemonUrl)
        XCTAssertEqual("first", secondPokemonName)
        XCTAssertEqual("firstUrl", secondPokemonUrl)
        XCTAssertEqual(2, pokemonCount)
    }
    
    func testGetPokemonDetail() {
        service = FakePokemonService()
        var detailName: String?
        var detailUrl: String?
        var detailImageUrl: String?
        remoteDataSource = PokemonRemoteDataSource(pokemonService: service!)
        let expectations = self.expectation(description: "loadingData")
        remoteDataSource?.getPokemonDetail(url: "detailUrl", completion: { (result) in
            switch result {
            case .success(let model):
                detailName = model.name
                detailUrl = model.url
                detailImageUrl = model.imageUrl
                break
            case .failure(_):
                break
            }
            expectations.fulfill()
        })
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual("detail", detailName)
        XCTAssertEqual("detailUrl", detailUrl)
        XCTAssertEqual("detailImageUrl", detailImageUrl)
    }
}

fileprivate class FakePokemonService: PokemonServiceProtocol {
    func request<T>(urlString: String, completion: @escaping (Result<T, Error>) -> ()) where T : Decodable, T : Encodable {
        if urlString == "https://pokeapi.co/api/v2/pokemon" {
            if let pokemonResponse = initalPokemonResponseNetworkModel as? T {
                completion(.success(pokemonResponse))
            } else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: nil)))
            }
        } else if urlString == "next" {
            if let pokemonResponse = nextPokemonResponseNetworkModel as? T {
                completion(.success(pokemonResponse))
            } else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: nil)))
            }
        } else if urlString == "detailUrl" {
            if let pokemonModel = pokemonDetailModel as? T {
                completion(.success(pokemonModel))
            } else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: nil)))
            }
        }
    }
    
    
}
