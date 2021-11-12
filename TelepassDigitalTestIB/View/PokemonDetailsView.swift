//
//  PokemonDetailsView.swift
//  TelepassDigitalTestIB
//
//  Created by Isaia Belladelli on 11/11/21.
//

import SwiftUI

struct PokemonDetailsView: View {
    
    @ObservedObject var observedPokemon: ObservablePokemon
    
    let imageWidth: CGFloat
    let textFontSize: CGFloat
    
    init(observedPokemon: ObservablePokemon) {
        self.observedPokemon = observedPokemon
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            self.imageWidth = 250
            self.textFontSize = 30
        } else {
            self.imageWidth = 130
            self.textFontSize = 20
        }
    }
    
    var body: some View {
        
        VStack {
            
            HStack {
                
                (Text("#\(self.observedPokemon.pokemon.id) ")
                    .font(.system(size: self.textFontSize * 0.8))
                 +
                 Text(self.observedPokemon.localizedName ?? "???")
                    .font(.system(size: self.textFontSize * 1.5)))
                    .bold()
            }
            
            HStack {
                
                VStack {
                    
                    ZStack {
                        
                        Circle()
                            .fill(Color.blue.opacity(0.25))
                            .frame(width: self.imageWidth, height: self.imageWidth)                            
                        
                        Image(uiImage: self.observedPokemon.image ?? UIImage())
                            .resizable()
                            .scaledToFit()
                            .frame(width: self.imageWidth, height: self.imageWidth)
                            .clipShape(Circle())
                    }
                    
                    ForEach(self.observedPokemon.localizedTypes, id: \.self) { type in
                        
                        Text(type)
                            .font(.system(size: self.textFontSize))
                            .bold()
                            .italic()
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                    }
                    .padding(.top, 5)
                    
                    Spacer()
                }
                .padding()
                
                VStack(alignment: .leading) {
                    
                    Group{
                        
                        Text("\(self.observedPokemon.localizedHpLabel): ").bold()
                        + Text("\(self.observedPokemon.pokemon.hp)")
                        
                        (Text("\(self.observedPokemon.localizedAttackLabel): ").bold()
                         + Text("\(self.observedPokemon.pokemon.attack)"))
                        
                        (Text("\(self.observedPokemon.localizedDefenseLabel): ").bold()
                         + Text("\(self.observedPokemon.pokemon.defense)"))
                        
                        (Text("\(self.observedPokemon.localizedSpecialAttackLabel): ").bold()
                         + Text("\(self.observedPokemon.pokemon.specialAttack)"))
                        
                        (Text("\(self.observedPokemon.localizedSpecialDefenseLabel): ").bold()
                         + Text("\(self.observedPokemon.pokemon.specialDefense)"))
                        
                        (Text("\(self.observedPokemon.localizedSpeedLabel): ").bold()
                         + Text("\(self.observedPokemon.pokemon.speed)"))
                        
                    }
                    .padding(.top, 10)
                    .font(.system(size: self.textFontSize))
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    
                    Spacer()
                }
                .padding()
                
            }
            .onAppear {
                self.observedPokemon.fetchLocalizedString()
            }
        }
    }
}
