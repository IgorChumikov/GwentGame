//
//  CardDeckView.swift
//  GwentGame
//
//  Created by Chumikov Igor Valeryevich on 06.05.2023.
//

import SwiftUI

struct CardDeckView: View {
    // MARK: - Properties
    
    let cards: [Card] =  [
        Card(attack: .one, imageName: .noWarrior),
        Card(attack: .two, imageName: .noWarrior),
        Card(attack: .four, imageName: .noWarrior),
        Card(attack: .one, imageName: .noWarrior)
    ]
    let isPlayerComputer: Bool
    let textColor: Color
    let numberOfCards: Int
    
    // MARK: - Inits
    
    init(isPlayerComputer: Bool, textColor: Color, numberOfCards: Int) {
        self.isPlayerComputer = isPlayerComputer
        self.textColor = textColor
        self.numberOfCards = numberOfCards
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: -13) {
            if isPlayerComputer {
                Text("\(numberOfCards) карт")
                    .foregroundColor(textColor)
                    .font(.headline)
            }
            HStack {
                VStack(alignment: .trailing) {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: -3))], spacing: 0) {
                        ForEach(cards) { card in
                            CardView(card: card) {}
                        }
                    }
                    .padding(.horizontal, 0)
                    .frame(width: 15)
                    .scaleEffect(0.75)
                    .shadow(color: .black, radius: 3, x: 1, y: 1)
                }
            }
            .disabled(true)
            if !isPlayerComputer {
                Text("\(numberOfCards) карт")
                    .foregroundColor(textColor)
                    .font(.headline)
            }
        }
    }
}

struct CardDeckView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CardDeckView(isPlayerComputer: false, textColor: .blue, numberOfCards: 20)
        }
    }
}
