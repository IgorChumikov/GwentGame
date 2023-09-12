//
//  GameView.swift
//  GwentGame
//
//  Created by Chumikov Igor Valeryevich on 06.05.2023.
//

import SwiftUI

struct GameView: View {
    // MARK: - Properties
    
    @Store
    private var viewModel: AnyGameViewModel
    
    // MARK: - Inits
    
    init(viewModel: AnyGameViewModel) {
        _viewModel = Store(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            informationBoard
            VStack {
                machineWorkplace
                Spacer()
                userWorkplace
            }
        }
    }
    
    private var informationBoard: some View {
        ZStack {
            createPassButton(title: "Я пасс", color: .blue)
                .hidden(!viewModel.isPlayerPass, mode: .removed)
                .frame(width: 100)
                .offset(x: -130, y: 0)
            
            createPassButton(title: "ИИ пас", color: .red)
                .hidden(!viewModel.isComputerPass, mode: .removed)
                .frame(width: 100)
                .offset(x: 130, y: 0)
            VStack {
                Text("Победы ИИ: \(viewModel.computerVictory)")
                    .foregroundColor(.red)
                    .font(.headline)
                HStack(alignment: .center, spacing: 0) {
                    stateOfRound
                }
                Text("Ваши победы: \(viewModel.playerVictory)")
                    .foregroundColor(.blue)
                    .font(.headline)

                   
            }
        }
    }
    
    private var machineWorkplace: some View {
        VStack {
            VStack(alignment: .center, spacing: -145) {
                PocketСardView(cards: viewModel.computerHand)
                    .disabled(true)
                    .frame(height: 100)
                CardDeckView(isPlayerComputer: true, textColor: .red, numberOfCards: viewModel.computerDeck.count)
                    .offset(x: 130, y: 22)
            }
            VStack(alignment: .center, spacing: -12) {
                Text("Сила войска вражеского отряда: \(viewModel.computerScore)")
                    .foregroundColor(.red)
                    .font(.headline)
                BattlefieldView(cardsOnBattlefield: viewModel.computerCardsBattlefield)
            }
            .padding(.horizontal, 40)
            .hidden(viewModel.computerCardsBattlefield.isEmpty, mode: .removed)
        }
    }
    
    private var userWorkplace: some View {
        VStack {
            VStack(alignment: .center, spacing: -12) {
                BattlefieldView(cardsOnBattlefield: viewModel.playerCardsBattlefield)
                Text("Сила войска вашего отряда: \(viewModel.playerScore)")
                    .foregroundColor(.blue)
                    .font(.headline)
            }
            .padding(.horizontal, 40)
            .hidden(viewModel.playerCardsBattlefield.isEmpty , mode: .removed)
            VStack(alignment: .center, spacing: -100) {
                PocketСardView(cards: viewModel.playerHand) { card in
                    viewModel.playCard(card)
                }
                .disabled(!viewModel.isPlayerMove)
                .frame(height: 100)
                CardDeckView(isPlayerComputer: false, textColor: .blue, numberOfCards: viewModel.playerDeck.count)
                    .offset(x: 130, y: -25)
                HStack(spacing: 10) {
                    passButton
                        .disabled(!viewModel.isPlayerMove)
                    passTurnButton
                        .disabled(!viewModel.isPlayerMove)
                }
                .offset(x: -50, y: 10)
            }
        }
    }
    
    private var stateOfRound: some View {
            Text(viewModel.gameResultText.isEmpty ? "Раунд \(viewModel.currentRound) из 3" : viewModel.gameResultText)
                .fontWeight(.medium)
                .font(.title3)
                .padding()
                .foregroundColor(.white)
                .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.black, Color.blue]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(20)
                .shadow(color: .red, radius: 5, x: -5, y: -5)
                .shadow(color: .blue, radius: 5, x: 5, y: 5)
    }
    
    private var passButton: some View {
        Button {
            viewModel.pass()
        } label: {
            HStack {
                Text("Пропуск")
                    .fontWeight(.medium)
            }
            .padding()
            .foregroundColor(.white)
            .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.black]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(40)
            .shadow(color: .blue, radius: 5, x: -5, y: -5)
            .shadow(color: .black, radius: 5, x: 5, y: 5)
        }
    }
    
    private var passTurnButton: some View {
        Button {
            viewModel.passTurn()
        } label: {
            HStack {
                Text("Передать ход")
                    .fontWeight(.medium)
            }
            .padding()
            .foregroundColor(.white)
            .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.black]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(40)
            .shadow(color: .blue, radius: 5, x: -5, y: -5)
            .shadow(color: .black, radius: 5, x: 5, y: 5)
        }
        .disabled(viewModel.isComputerPass)
    }
    
    private func createPassButton(title: String, color: Color) -> some View {
        return HStack {
            Text(title)
                .fontWeight(.medium)
        }
        .padding()
        .foregroundColor(.white)
        .background(LinearGradient(gradient: Gradient(colors: [color, Color.black]), startPoint: .leading, endPoint: .trailing))
        .cornerRadius(40)
        .shadow(color: color, radius: 5, x: -5, y: -5)
        .shadow(color: .black, radius: 5, x: 5, y: 5)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: GameAssembly.assemble())
    }
}
