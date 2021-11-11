//
//  ContentView.swift
//  TelepassDigitalTestIB
//
//  Created by Isaia Belladelli on 11/11/21.
//

import SwiftUI

struct PokemonListView: View {
    
    @ObservedObject var pokedex: Pokedex = Pokedex()
    
    var body: some View {
        NavigationView {
            
            List {
                
                ForEach(pokedex.pokemons, id: \.id) { pokemon in
                    
                    NavigationLink(destination: PokemonDetailsView(pokemon: pokemon)) {
                        
                        PokemonRowView(pokemon: pokemon)
                    }
                    
                }
                
                Text("...")
                    .onAppear(perform: {
                        self.pokedex.fetchPokemonList()
                    })
            }
            .navigationBarTitle("Pokedex")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
    }
}

struct PokemonRowView: View {
    
    @ObservedObject var pokemon: Pokemon
    
    var body: some View {
        
        HStack {
            
            Image(uiImage: pokemon.image ?? UIImage()) // Or an image placeholder if present
            
            (Text("#\(self.pokemon.id) ")
                .font(.callout)
            +
            Text(self.pokemon.name)
                .font(.title))
            .lineLimit(1)
            .minimumScaleFactor(0.5)
        }
    }
}
