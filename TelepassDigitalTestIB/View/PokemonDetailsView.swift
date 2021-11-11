//
//  PokemonDetailsView.swift
//  TelepassDigitalTestIB
//
//  Created by Isaia Belladelli on 11/11/21.
//

import SwiftUI

struct PokemonDetailsView: View {
    
    let pokemon: Pokemon
    let imageWidth: CGFloat
    var titleDisplayMode: NavigationBarItem.TitleDisplayMode
    var textFontSize: CGFloat
    
    @State var types: [String] = []
    
    @State var hpLabel: String = "Hp"
    @State var attackLabel: String = "Attack"
    @State var defenseLabel: String = "Defense"
    @State var specialAttackLabel: String = "Special Attack"
    @State var specialDefenseLabel: String = "Special Defense"
    @State var speedLabel: String = "Speed"
    
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
                 Text(self.pokemon.name)
                    .font(.system(size: self.textFontSize * 1.5)))
                    .bold()
            }
            
            HStack {
                
                VStack {
                    
                    ZStack {
                        
                        Circle()
                            .fill(Color.blue.opacity(0.3))
                            .frame(width: self.imageWidth, height: self.imageWidth)                            
                        
                        Image(uiImage: pokemon.image ?? UIImage())
                            .resizable()
                            .scaledToFit()
                            .frame(width: self.imageWidth, height: self.imageWidth)
                            .clipShape(Circle())
                    }
                    
                    ForEach(self.types, id: \.self) { type in
                        
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
                        
                        Text("\(self.hpLabel): ").bold()
                        + Text("\(self.pokemon.stats[0].value)")
                        
                        (Text("\(self.attackLabel): ").bold()
                         + Text("\(self.pokemon.stats[1].value)"))
                        
                        
                        (Text("\(self.defenseLabel): ").bold()
                         + Text("\(self.pokemon.stats[2].value)"))
                        
                        (Text("\(self.specialAttackLabel): ").bold()
                         + Text("\(self.pokemon.stats[3].value)"))
                        
                        (Text("\(self.specialDefenseLabel): ").bold()
                         + Text("\(self.pokemon.stats[4].value)"))
                        
                        (Text("\(self.speedLabel): ").bold()
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
                
                self.pokemon.fetchLocalizedTypes(completion: { localizedTypeName in
                    self.types.append(localizedTypeName)
                })
                
                self.pokemon.fetchLocalizedStats(statIndex: 0, completion: { localizedStatName in
                    self.hpLabel = localizedStatName
                })
                
                self.pokemon.fetchLocalizedStats(statIndex: 1, completion: { localizedStatName in
                    self.attackLabel = localizedStatName
                })
                
                self.pokemon.fetchLocalizedStats(statIndex: 2, completion: { localizedStatName in
                    self.defenseLabel = localizedStatName
                })
                
                self.pokemon.fetchLocalizedStats(statIndex: 3, completion: { localizedStatName in
                    self.specialAttackLabel = localizedStatName
                })
                
                self.pokemon.fetchLocalizedStats(statIndex: 4, completion: { localizedStatName in
                    self.specialDefenseLabel = localizedStatName
                })
                
                self.pokemon.fetchLocalizedStats(statIndex: 5, completion: { localizedStatName in
                    self.speedLabel = localizedStatName
                })
            }
        }
    }
}
