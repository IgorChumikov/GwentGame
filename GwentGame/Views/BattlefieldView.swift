//
//  BattlefieldView.swift
//  GwentGame
//
//  Created by Chumikov Igor Valeryevich on 06.05.2023.
//

import SwiftUI

struct BattlefieldView: View {
    // MARK: - Properties
    
    let cardsOnBattlefield: [Card]
    
    // MARK: - Inits
    
    init(cardsOnBattlefield: [Card]) {
        self.cardsOnBattlefield = cardsOnBattlefield
    }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
           HStack(spacing: -20) {
                ForEach(cardsOnBattlefield) { card in
                    CardView(card: card) {}
                        .disabled(true)
                        .scaleEffect(0.75)
                }
            }
           .shadow(color: .black, radius: 3, x: 1, y: 1)
        }
    }
}

struct BattlefieldView_Previews: PreviewProvider {
    static var previews: some View {
            BattlefieldView(
                cardsOnBattlefield: [
                    Card(attack: .one, imageName: .warrior1),
                    Card(attack: .four, imageName: .warrior2),
                    Card(attack: .one, imageName: .warrior1),
                    Card(attack: .one, imageName: .warrior1),
                    Card(attack: .one, imageName: .warrior1),
                    Card(attack: .four, imageName: .warrior2),
                    Card(attack: .one, imageName: .warrior1),
                    Card(attack: .one, imageName: .warrior1)
                ]
            )
    }
}
