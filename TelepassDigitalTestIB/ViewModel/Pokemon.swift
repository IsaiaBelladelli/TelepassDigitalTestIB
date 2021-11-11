//
//  Pokemon.swift
//  TelepassDigitalTestIB
//
//  Created by Isaia Belladelli on 11/11/21.
//

import Foundation
import UIKit
import SwiftUI

protocol localizedFieldNameFetcher {
    
    func fetchLocalizedFieldName(urlString: String, completion: @escaping (String) -> Void)
    
}

class Pokemon: ObservableObject {
    
    let apiManager: localizedFieldNameFetcher = APIManager.shared
    
    let id: Int
    let types: Set<PokemonType>
    let stats: [PokemonStat]
    
    @Published var image: UIImage?
    @Published var name: String
    
    internal init(id: Int, name: String, types: Set<PokemonType>, stats: [PokemonStat], localizedNameUrlString: String, imageUrlString: String) {
        self.id = id
        self.name = name
        self.types = types
        self.stats = stats
        
        self.fetchImage(urlString: imageUrlString)
        
        self.apiManager.fetchLocalizedFieldName(urlString: localizedNameUrlString, completion: { localizedString in
            self.name = localizedString
        })       
    }
    
    func fetchImage(urlString: String) {
        
        if let url = URL(string: urlString) {
            
            URLSession.shared.dataTask(with: url) { data, _, error in
                guard error == nil, let data = data else { return }
                
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
                
            }.resume()
        }
    }
    
    func fetchLocalizedTypes(completion: @escaping (String) -> Void) {
        
        for type in types {
            
            if let urlString = type.urlString {
                
                self.apiManager.fetchLocalizedFieldName(urlString: urlString, completion: { localizedName in
                    
                    completion(localizedName)
                })
            }
        }
    }
    
    func fetchLocalizedStats(statIndex: Int, completion: @escaping (String) -> Void) {
        
        if let urlString = self.stats[statIndex].urlString {
            
            self.apiManager.fetchLocalizedFieldName(urlString: urlString, completion: { localizedName in
                
                completion(localizedName)
            })
        }
    }
}

struct PokemonType: Hashable {
    
    let name: String
    let urlString: String?
}

struct PokemonStat {
    
    let name: String
    let value: Int
    let urlString: String?
}
