//
//  APIManager.swift
//  TelepassDigitalTestIB
//
//  Created by Isaia Belladelli on 11/11/21.
//

import Foundation
import UIKit

class APIManager: PokemonListFetcher {
    
    let baseURLString = "https://pokeapi.co/api/v2/"
    
    var lastApiResult: APIResult
    
    var apiPokemons: [APIPokemon] = []
    
    init() {
        self.lastApiResult = APIResult(next: self.baseURLString + "pokemon?offset=0&limit=20", results: [])
    }
    
    func fetchPokemonList(completion: @escaping ([ObservablePokemon]) -> Void) {
        
        if let url = URL(string: self.lastApiResult.next) {
            
            URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
                guard error == nil, let data = data else {return}
                
                do {
                    let apiResult = try JSONDecoder().decode(APIResult.self, from: data)
                    
                    self.lastApiResult = apiResult
                    
                    for apiBasePokemon in apiResult.results {
                        
                        self.fetchPokemon(urlString: apiBasePokemon.url, completion: completion)
                    }
                    
                } catch let error{
                    print(error.localizedDescription)
                }
            }).resume()
        }
    }
    
    func fetchPokemon(urlString: String, completion: @escaping ([ObservablePokemon]) -> Void) {
        
        if let url = URL(string: urlString) {
            
            URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
                guard error == nil, let data = data else {return}
                
                do {
                    
                    let apiPokemon = try JSONDecoder().decode(APIPokemon.self, from: data)
                    
                    self.apiPokemons.append(apiPokemon)
                    
                    let pokemon = ObservablePokemon(pokemon:
                                                        Pokemon(id: apiPokemon.id,
                                                                name: apiPokemon.species.name,
                                                                types: Set(apiPokemon.types.map { $0.type.name }),
                                                                hp: apiPokemon.stats[0].base_stat,
                                                                attack: apiPokemon.stats[1].base_stat,
                                                                defense: apiPokemon.stats[2].base_stat,
                                                                specialAttack: apiPokemon.stats[3].base_stat,
                                                                specialDefense: apiPokemon.stats[4].base_stat,
                                                                speed: apiPokemon.stats[5].base_stat),
                                                    localizedStringFetcher: self)
                    
                    DispatchQueue.main.async {
                        completion( [pokemon] )
                    }
                    
                } catch let error{
                    print(error.localizedDescription)
                }
            }).resume()
        }
    }
}

extension APIManager: LocalizedStringFetcher {
    
    func fetchImage(pokemonID: Int, completion: @escaping (UIImage) -> Void) {
        
        if let pokemon = self.apiPokemons.filter({$0.id == pokemonID}).first, let url = URL(string: pokemon.sprites.front_default) {
            
            URLSession.shared.dataTask(with: url) { data, _, error in
                guard error == nil, let data = data else { return }
                
                DispatchQueue.main.async {
                    
                    if let image = UIImage(data: data) {
                        completion(image)
                    } else {
                        completion(UIImage())
                    }
                }
                
            }.resume()
        }
    }
    
    func fetchLocalizedName(pokemonID: Int, completion: @escaping (String) -> Void) {
        
        if let pokemon = self.apiPokemons.filter({$0.id == pokemonID}).first {
            
            self.fetchLocalizedString(urlString: pokemon.species.url, completion: completion)
        }
    }
    
    func fetchLocalizedTypes(pokemonID: Int, completion: @escaping (String) -> Void) {
        
        if let pokemon = self.apiPokemons.filter({$0.id == pokemonID}).first {
            
            for baseType in pokemon.types {
            
                self.fetchLocalizedString(urlString: baseType.type.url, completion: completion)
            }
        }
    }
    
    func fetchLocalizedStats(pokemonID: Int, statID: Int, completion: @escaping (String) -> Void) {
        
        if let pokemon = self.apiPokemons.filter({$0.id == pokemonID}).first {
            
            self.fetchLocalizedString(urlString: pokemon.stats[statID].stat.url, completion: completion)
            
        }
    }
    
    func fetchLocalizedString(urlString: String, completion: @escaping (String) -> Void) {
        
        if let url = URL(string: urlString) {
            
            URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
                guard error == nil, let data = data else {return}
                
                do {                    
                    let apiFieldDetails = try JSONDecoder().decode(APIFieldDetails.self, from: data)
                    
                    if let localizedString = apiFieldDetails.names.filter({ $0.language.name == Locale.current.languageCode}).first?.name {
                        
                        DispatchQueue.main.async {
                            completion(localizedString)
                        }                        
                    }
                } catch let error{
                    print(error.localizedDescription)
                }
            }).resume()
        }
    }
}
