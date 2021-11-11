//
//  Pokedex.swift
//  TelepassDigitalTestIB
//
//  Created by Isaia Belladelli on 11/11/21.
//

import Foundation

protocol PokemonListFetcher {
    
    func fetchPokemonList(completion: @escaping ([Pokemon]) -> Void)    
}

class Pokedex: ObservableObject {
    
    let apiManager: PokemonListFetcher = APIManager.shared
    
    @Published var pokemons: [Pokemon] = []
    
    func fetchPokemonList() {
        self.apiManager.fetchPokemonList(completion: { pokemons in
            self.pokemons += pokemons
            self.pokemons.sort(by: { $0.id < $1.id })
        })
    }
}
