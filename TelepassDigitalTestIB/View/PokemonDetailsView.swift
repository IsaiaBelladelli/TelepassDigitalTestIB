//
//  PokemonDetailsView.swift
//  TelepassDigitalTestIB
//
//  Created by Isaia Belladelli on 11/11/21.
//

import SwiftUI

struct PokemonDetailsView: View {
    
    @ObservedObject var pokemon: Pokemon
    
    let imageWidth: CGFloat
    let titleDisplayMode: NavigationBarItem.TitleDisplayMode
    let textFontSize: CGFloat
    
    init(pokemon: Pokemon) {
        self.pokemon = pokemon
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            self.imageWidth = 250
            self.titleDisplayMode = .inline
            self.textFontSize = 30
        } else {
            self.imageWidth = 130
            self.titleDisplayMode = .large
            self.textFontSize = 20
        }
    }
    
    var body: some View {
        
        VStack {
            
            HStack {
                
                (Text("#\(self.pokemon.id) ")
                    .font(.system(size: self.textFontSize * 0.8))
                 +
                 Text(self.pokemon.localizedName ?? "???")
                    .font(.system(size: self.textFontSize * 1.5)))
                    .bold()
            }
            
            HStack {
                
                VStack {
                    
                    ZStack {
                        
                        Circle()
                            .fill(Color.blue.opacity(0.25))
                            .frame(width: self.imageWidth, height: self.imageWidth)                            
                        
                        Image(uiImage: self.pokemon.image ?? UIImage())
                            .resizable()
                            .scaledToFit()
                            .frame(width: self.imageWidth, height: self.imageWidth)
                            .clipShape(Circle())
                    }
                    
                    ForEach(self.pokemon.localizedTypes, id: \.self) { type in
                        
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
                        
                        Text("\(self.pokemon.localizedHpLabel): ").bold()
                        + Text("\(self.pokemon.stats[0].value)")
                        
                        (Text("\(self.pokemon.localizedAttackLabel): ").bold()
                         + Text("\(self.pokemon.stats[1].value)"))                        
                        
                        (Text("\(self.pokemon.localizedDefenseLabel): ").bold()
                         + Text("\(self.pokemon.stats[2].value)"))
                        
                        (Text("\(self.pokemon.localizedSpecialAttackLabel): ").bold()
                         + Text("\(self.pokemon.stats[3].value)"))
                        
                        (Text("\(self.pokemon.localizedSpecialDefenseLabel): ").bold()
                         + Text("\(self.pokemon.stats[4].value)"))
                        
                        (Text("\(self.pokemon.localizedSpeedLabel): ").bold()
                         + Text("\(self.pokemon.stats[5].value)"))
                        
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
                self.pokemon.fetchLocalizedString()
            }
        }
    }
}
