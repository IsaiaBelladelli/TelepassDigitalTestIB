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
                
                ForEach(self.pokedex.observablePokemons, id: \.pokemon.id) { pokemon in
                    
                    NavigationLink(destination: PokemonDetailsView(observedPokemon: pokemon)) {
                        
                        PokemonRowView(observedPokemon: pokemon)
                    }
                }
                
                Text("...")
                    .onAppear(perform: {
                        self.pokedex.fetchPokemonList()
                        
                        print("sono apparso ...")
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
    
    @ObservedObject var observedPokemon: ObservablePokemon
    
    var body: some View {
        
        HStack {
            
            Image(uiImage: self.observedPokemon.image ?? UIImage()) // Or an image placeholder if present
            
            (Text("#\(self.observedPokemon.pokemon.id) ")
                .font(.callout)
            +
            Text(self.observedPokemon.localizedName ?? "???")
                .font(.title))
            .lineLimit(1)
            .minimumScaleFactor(0.5)
        }
    }
}
