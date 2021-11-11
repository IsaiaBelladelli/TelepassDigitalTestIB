//
//  APIManager.swift
//  TelepassDigitalTestIB
//
//  Created by Isaia Belladelli on 11/11/21.
//

import Foundation

class APIManager: PokemonListFetcher {    
    
    static let shared = APIManager()
    
    let baseURLString = "https://pokeapi.co/api/v2/"
    
    var lastApiResult: APIResult
    
    init() {
        self.lastApiResult = APIResult(next: self.baseURLString + "pokemon?offset=0&limit=20", results: [])
    }
    
    func fetchPokemonList(completion: @escaping ([Pokemon]) -> Void) {
        
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
    
    func fetchPokemon(urlString: String, completion: @escaping ([Pokemon]) -> Void) {
        
        if let url = URL(string: urlString) {
            
            URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
                guard error == nil, let data = data else {return}
                
                do {
                    
                    let apiPokemon = try JSONDecoder().decode(APIPokemon.self, from: data)
                    
                    let pokemon = Pokemon(id: apiPokemon.id,
                                          types: Set(apiPokemon.types.map { PokemonType(name: $0.type.name, urlString: $0.type.url) }),
                                          stats: apiPokemon.stats.map { PokemonStat(name: $0.stat.name, value: $0.base_stat, urlString: $0.stat.url)},
                                          nameUrlString: apiPokemon.species.url,
                                          imageUrlString: apiPokemon.sprites.front_default)
                    
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

extension APIManager: localizedStringFetcher {
    
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
