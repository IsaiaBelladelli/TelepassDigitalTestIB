//
//  AsyncTest.swift
//  AsyncTest
//
//  Created by Isaia Belladelli on 12/11/21.
//

import XCTest
@testable import TelepassDigitalTestIB

class AsyncTest: XCTestCase {
    
    var sut: APIManager! // System Under Test

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        
        self.sut = APIManager()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        self.sut = nil
        
        try super.tearDownWithError()
    }
    
    func testPokemonList() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let promise = XCTestExpectation()
        
        self.sut.fetchPokemonList(completion: { obsPokemons in
            
            XCTAssertTrue(!obsPokemons.isEmpty)
            
            XCTAssertLessThanOrEqual(obsPokemons.first!.pokemon.id, 20)
            
            promise.fulfill()
        })
            
        wait(for: [promise], timeout: 25)
    }

    func testFetchPokemon() throws {
        
        let urlString = "https://pokeapi.co/api/v2/pokemon/100/"
        
        let promise = XCTestExpectation()
        
        self.sut.fetchPokemon(urlString: urlString, completion: { obsPokemons in
            
            XCTAssertTrue(!obsPokemons.isEmpty)
            
            XCTAssertEqual(obsPokemons.first!.pokemon.id, 100)
            
            promise.fulfill()
        })
            
        wait(for: [promise], timeout: 3)
    }
    
    func testFetchLocalizedName() throws {
        
        let promise = XCTestExpectation()
        
        self.sut.apiPokemons.append(APIPokemon(id: 1,
                                               species: APISpecies(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon-species/1/"),
                                               sprites: APISprite(front_default: ""),
                                               stats: [],
                                               types: []))
            
        self.sut.fetchLocalizedName(pokemonID: 1, completion: { localizedName in
            
            XCTAssertTrue(!localizedName.isEmpty)
            
            // Set in test schema: Options -> App language = Italian
            XCTAssertEqual(localizedName, "Bulbasaur")
            
            promise.fulfill()
        })
        
        wait(for: [promise], timeout: 5)
    }
    
    func testFetchLocalizedTypes() throws {
        
        let promise = XCTestExpectation()
        
        self.sut.apiPokemons.append(APIPokemon(id: 1,
                                               species: APISpecies(name: "", url: ""),
                                               sprites: APISprite(front_default: ""),
                                               stats: [],
                                               types: [APIBaseType(type:
                                                                    APIType(name: "grass", url: "https://pokeapi.co/api/v2/type/12/")),
                                                       APIBaseType(type:
                                                                    APIType(name: "poison", url: "https://pokeapi.co/api/v2/type/4/")) ] ))
        
        self.sut.fetchLocalizedTypes(pokemonID: 1, completion: { localizedType in
            
            XCTAssertTrue(!localizedType.isEmpty)
            
            // Set in test schema: Options -> App language = Italian
            XCTAssertTrue(localizedType == "Erba" || localizedType == "Veleno")
            
            promise.fulfill()
        })
        
        wait(for: [promise], timeout: 5)
    } 

}
