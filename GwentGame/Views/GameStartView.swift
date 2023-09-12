//
//  GameStartView.swift
//  GwentGame
//
//  Created by Chumikov Igor Valeryevich on 06.05.2023.
//

import SwiftUI

struct GameStartView: View {
    // MARK: - Properties
    
    @State private var showGameView = false
    private let viewModel = GameAssembly.assemble()
    
    // MARK: - Inits
    
    init(showGameView: Bool = false) {
        self.showGameView = showGameView
    }
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            Image("window")
                .resizable()
                .scaledToFit()
            Button("Start Game") {
                showGameView = true
            }
            .bold()
            .offset(y: 200)
        }
        .fullScreenCover(isPresented: $showGameView) {
            GameView(viewModel: viewModel)
        }
    }
}

struct GameStartView_Previews: PreviewProvider {
    static var previews: some View {
        GameStartView()
    }
}

