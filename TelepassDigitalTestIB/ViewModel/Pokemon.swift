//
//  Pokemon.swift
//  TelepassDigitalTestIB
//
//  Created by Isaia Belladelli on 11/11/21.
//

import Foundation
import UIKit
import SwiftUI

protocol localizedStringFetcher {
    
    func fetchLocalizedString(urlString: String, completion: @escaping (String) -> Void)    
}

class Pokemon: ObservableObject {
    
    let apiManager: localizedStringFetcher = APIManager.shared
    
    let id: Int
    let types: Set<PokemonType>
    let stats: [PokemonStat]
    
    @Published var image: UIImage?
    @Published var localizedName: String?
    @Published var localizedTypes: [String] = []
    @Published var localizedHpLabel: String = "Hp"
    @Published var localizedAttackLabel: String = "Attack"
    @Published var localizedDefenseLabel: String = "Defense"
    @Published var localizedSpecialAttackLabel: String = "Special Attack"
    @Published var localizedSpecialDefenseLabel: String = "Special Defense"
    @Published var localizedSpeedLabel: String = "Speed"
    
    internal init(id: Int, types: Set<PokemonType>, stats: [PokemonStat], nameUrlString: String, imageUrlString: String) {
        self.id = id
        self.types = types
        self.stats = stats
        
        self.fetchImage(urlString: imageUrlString)
        
        self.apiManager.fetchLocalizedString(urlString: nameUrlString, completion: { localizedString in
            self.localizedName = localizedString
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
    
    func fetchLocalizedString() {
        self.fetchLocalizedTypes(completion: { localizedTypeName in
            self.localizedTypes.append(localizedTypeName)
        })
        
        self.fetchLocalizedStats(statIndex: 0, completion: { localizedStatName in
            self.localizedHpLabel = localizedStatName
        })
        
        self.fetchLocalizedStats(statIndex: 1, completion: { localizedStatName in
            self.localizedAttackLabel = localizedStatName
        })
        
        self.fetchLocalizedStats(statIndex: 2, completion: { localizedStatName in
            self.localizedDefenseLabel = localizedStatName
        })
        
        self.fetchLocalizedStats(statIndex: 3, completion: { localizedStatName in
            self.localizedSpecialAttackLabel = localizedStatName
        })
        
        self.fetchLocalizedStats(statIndex: 4, completion: { localizedStatName in
            self.localizedSpecialDefenseLabel = localizedStatName
        })
        
        self.fetchLocalizedStats(statIndex: 5, completion: { localizedStatName in
            self.localizedSpeedLabel = localizedStatName
        })
    }
    
    func fetchLocalizedTypes(completion: @escaping (String) -> Void) {
        
        for type in types {
            
            if let urlString = type.urlString {
                
                self.apiManager.fetchLocalizedString(urlString: urlString, completion: { localizedString in
                    
                    completion(localizedString)
                })
            }
        }
    }
    
    func fetchLocalizedStats(statIndex: Int, completion: @escaping (String) -> Void) {
        
        if let urlString = self.stats[statIndex].urlString {
            
            self.apiManager.fetchLocalizedString(urlString: urlString, completion: { localizedString in
                
                completion(localizedString)
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
