//
//  CardView.swift
//  GwentGame
//
//  Created by Chumikov Igor Valeryevich on 06.05.2023.
//

import SwiftUI

struct CardView: View {
    // MARK: - Properties
    
    let card: Card
    let onPlay: () -> Void
    
    // MARK: - Inits
    
    init(card: Card, onPlay: @escaping () -> Void) {
        self.card = card
        self.onPlay = onPlay
    }
    
    var body: some View {
        Button {
            onPlay()
        } label: {
            cardContent
        }
    }
    
   private var cardContent: some View {
        VStack(spacing: 5) {
            Image(card.imageName.rawValue)
                .resizable()
                .frame(width: 80, height: 120)
        }
        .padding(10)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card(attack: .six, imageName: .warrior6)) {}
    }
}
