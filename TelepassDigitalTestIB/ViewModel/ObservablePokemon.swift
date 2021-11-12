//
//  Pokemon.swift
//  TelepassDigitalTestIB
//
//  Created by Isaia Belladelli on 11/11/21.
//

import Foundation
import UIKit
import SwiftUI

protocol LocalizedStringFetcher {
    
    func fetchLocalizedName(pokemonID: Int, completion: @escaping (String) -> Void)
    
    func fetchLocalizedTypes(pokemonID: Int, completion: @escaping (String) -> Void)
    
    func fetchLocalizedStats(pokemonID: Int, statID: Int, completion: @escaping (String) -> Void)
    
    func fetchImage(pokemonID: Int, completion: @escaping (UIImage) -> Void)
}

class ObservablePokemon: ObservableObject {
    
    let localizedStringFetcher: LocalizedStringFetcher
    
    let pokemon: Pokemon
    
    @Published var image: UIImage?
    @Published var localizedName: String?
    @Published var localizedTypes: [String] = []
    @Published var localizedHpLabel: String = "Hp"
    @Published var localizedAttackLabel: String = "Attack"
    @Published var localizedDefenseLabel: String = "Defense"
    @Published var localizedSpecialAttackLabel: String = "Special Attack"
    @Published var localizedSpecialDefenseLabel: String = "Special Defense"
    @Published var localizedSpeedLabel: String = "Speed"
    
    internal init(pokemon: Pokemon, localizedStringFetcher: LocalizedStringFetcher) {
        self.pokemon = pokemon
        self.localizedStringFetcher = localizedStringFetcher
        
        self.localizedStringFetcher.fetchImage(pokemonID: self.pokemon.id, completion: { image in
            self.image = image
        } )
        
        self.localizedStringFetcher.fetchLocalizedName(pokemonID: self.pokemon.id, completion: { localizedString in
            self.localizedName = localizedString
        })       
    }
    
    func fetchLocalizedString() {
        
        // Fetches pokemon's localized types
        self.localizedStringFetcher.fetchLocalizedTypes(pokemonID: self.pokemon.id, completion: { type in
            self.localizedTypes.append(type)
        })
        
        self.localizedStringFetcher.fetchLocalizedStats(pokemonID: self.pokemon.id, statID: 0, completion: { localizedString in
            self.localizedHpLabel = localizedString
        })
        
        self.localizedStringFetcher.fetchLocalizedStats(pokemonID: self.pokemon.id, statID: 1, completion: { localizedString in
            self.localizedAttackLabel = localizedString
        })
        
        self.localizedStringFetcher.fetchLocalizedStats(pokemonID: self.pokemon.id, statID: 2, completion: { localizedString in
            self.localizedDefenseLabel = localizedString
        })
        
        self.localizedStringFetcher.fetchLocalizedStats(pokemonID: self.pokemon.id, statID: 3, completion: { localizedString in
            self.localizedSpecialAttackLabel = localizedString
        })
        
        self.localizedStringFetcher.fetchLocalizedStats(pokemonID: self.pokemon.id, statID: 4, completion: { localizedString in
            self.localizedSpecialDefenseLabel = localizedString
        })
        
        self.localizedStringFetcher.fetchLocalizedStats(pokemonID: self.pokemon.id, statID: 5, completion: { localizedString in
            self.localizedSpeedLabel = localizedString
        })
    }
    
}


