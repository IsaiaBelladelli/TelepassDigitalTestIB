//
//  APIModel.swift
//  TelepassDigitalTestIB
//
//  Created by Isaia Belladelli on 11/11/21.
//

import Foundation

struct APIResult: Decodable {
    
    let next: String
    let results: [APIBasePokemon]
}

struct APIBasePokemon: Decodable {
    
    let name: String
    let url: String
}

struct APIPokemon: Decodable {
    
    var id: Int
    var species: APISpecies
    let sprites: APISprite
    let stats: [APIBaseStat]
    let types: [APIBaseType]
}

struct APISpecies: Decodable {
    
    let name: String
    let url: String
}

struct APISprite: Decodable {
    
    let front_default: String
}

struct APIBaseStat: Decodable {
    
    let base_stat: Int
    let stat: APIStat
}

struct APIStat: Decodable {
    
    let name: String
    let url: String
}

struct APIBaseType: Decodable {
    
    let type: APIType
}

struct APIType: Decodable {
    
    let name: String
    let url: String
}

// Model for localized strings such name, types, stats's name.
struct APIFieldDetails: Decodable {
    
    let names: [APIFieldName]
}

struct APIFieldName: Decodable {
    
    let name: String
    let language: APIFieldLanguage
}

struct APIFieldLanguage: Decodable {
    
    let name: String
}
