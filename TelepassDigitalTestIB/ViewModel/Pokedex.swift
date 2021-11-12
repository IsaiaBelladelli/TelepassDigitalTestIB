//
//  Pokedex.swift
//  TelepassDigitalTestIB
//
//  Created by Isaia Belladelli on 11/11/21.
//

import Foundation

protocol PokemonListFetcher {
    
    func fetchPokemonList(completion: @escaping ([ObservablePokemon]) -> Void)    
}

class Pokedex: ObservableObject {
    
    let pokemonListFetcher: PokemonListFetcher = APIManager()
    
    @Published var observablePokemons: [ObservablePokemon] = []
    
    func fetchPokemonList() {
        self.pokemonListFetcher.fetchPokemonList(completion: { newObsPokemons in
            self.observablePokemons += newObsPokemons
            self.observablePokemons.sort(by: { $0.pokemon.id < $1.pokemon.id })
        })
    }
}
