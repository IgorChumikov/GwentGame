//
//  PocketСardView.swift
//  GwentGame
//
//  Created by Chumikov Igor Valeryevich on 06.05.2023.
//

import SwiftUI

struct PocketСardView: View {
    // MARK: - Properties
    
    var cards: [Card]
    var cardAction: ((Card) -> Void)?
    
    // MARK: - Inits
    
    init(cards: [Card], cardAction: ((Card) -> Void)? = nil) {
        self.cards = cards
        self.cardAction = cardAction
    }
    
    var body: some View {
        VStack {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 40))], spacing: 0) {
                ForEach(cards) { card in
                    CardView(card: card) {
                        cardAction?(card)
                    }
                }
            }
            .padding(.horizontal, 16)
            .frame(width: 500)
            .scaleEffect(0.75)
            .shadow(color: .black, radius: 5, x: 2, y: 10)
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            PocketСardView(cards: [
                Card(attack: .one, imageName: .warrior1),
                Card(attack: .six, imageName: .warrior1),
                Card(attack: .two, imageName: .warrior1),
                Card(attack: .one, imageName: .warrior1),
                Card(attack: .six, imageName: .warrior1),
                Card(attack: .two, imageName: .warrior1),
                Card(attack: .one, imageName: .warrior1),
                Card(attack: .six, imageName: .warrior1),
                Card(attack: .two, imageName: .warrior1)
                
            ]
            )
            Spacer()
            PocketСardView(cards: [
                Card(attack: .one, imageName: .warrior1),
                Card(attack: .six, imageName: .warrior1),
                Card(attack: .two, imageName: .warrior1),
                Card(attack: .one, imageName: .warrior1),
                Card(attack: .six, imageName: .warrior1),
                Card(attack: .two, imageName: .warrior1),
                Card(attack: .one, imageName: .warrior1),
                Card(attack: .six, imageName: .warrior1),
                Card(attack: .two, imageName: .warrior1)
            ]
            )
        }
    }
}
