//
//  GameViewModelProtocol.swift
//  GwentGame
//
//  Created by Chumikov Igor Valeryevich on 06.05.2023.
//

import Foundation

typealias AnyGameViewModel = any IGameViewModel

protocol IGameViewModel: AnyObservableObject {
    var playerDeck: [Card] { get set }
    var computerDeck: [Card] { get set }
    var playerHand: [Card] { get set }
    var computerHand: [Card] { get set }
    var playerCardsBattlefield: [Card] { get set }
    var computerCardsBattlefield: [Card] { get set }
    var currentRound: Int { get set }
    var playerScore: Int { get set }
    var computerScore: Int { get set }
    var playerVictory: Int { get set }
    var computerVictory: Int { get set }
    var isPlayerMove: Bool { get set }
    var gameResultText: String { get set }
    var isPlayerPass: Bool { get set }
    var isComputerPass: Bool { get set }
    
    func playCard(_ card: Card)
    func pass()
    func passTurn()
}
