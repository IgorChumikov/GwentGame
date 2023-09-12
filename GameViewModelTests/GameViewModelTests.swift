//
//  GameViewModelTests.swift
//  GameViewModelTests
//
//  Created by Chumikov Igor Valeryevich on 06.05.2023.
//

import XCTest
@testable import GwentGame

final class GameViewModelTests: XCTestCase {
    
    var viewModel: AnyGameViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = GameViewModel()
    }
    
    override func tearDown() {
        weak var testViewModel = viewModel
        
        viewModel = nil
        super.tearDown()
        
        XCTAssertNil(testViewModel, "Instance should have been deallocated. Potential memory leak!")
    }
    
    func testStartGame() {
        // Given
        let deckOfCards: Int = 15
        let cardsInHand: Int = 5
        let currentRound: Int = 1
        
        // Then
        XCTAssertEqual(viewModel.playerDeck.count, deckOfCards)
        XCTAssertEqual(viewModel.computerDeck.count, deckOfCards)
        XCTAssertEqual(viewModel.playerHand.count, cardsInHand)
        XCTAssertEqual(viewModel.playerHand.count, cardsInHand)
        XCTAssertEqual(viewModel.playerCardsBattlefield.count, .zero)
        XCTAssertEqual(viewModel.computerCardsBattlefield.count, .zero)
        XCTAssertEqual(viewModel.currentRound, currentRound)
        XCTAssertEqual(viewModel.playerScore, .zero)
        XCTAssertEqual(viewModel.computerScore, .zero)
        XCTAssertEqual(viewModel.playerVictory, .zero)
        XCTAssertEqual(viewModel.computerVictory, .zero)
        XCTAssertEqual(viewModel.isPlayerMove, true)
        XCTAssertEqual(viewModel.gameResultText, "")
        XCTAssertEqual(viewModel.isPlayerPass, false)
        XCTAssertEqual(viewModel.isComputerPass, false)
    }
    
    func testPass() {
        // Given
        let deckOfCards: Int = 15
        let cardsInHand: Int = 5
        let currentRound: Int = 1
        
        // When
        viewModel.pass()
        
        // Then
        XCTAssertEqual(viewModel.playerDeck.count, deckOfCards)
        XCTAssertEqual(viewModel.computerDeck.count, deckOfCards)
        XCTAssertEqual(viewModel.playerHand.count, cardsInHand)
        XCTAssertEqual(viewModel.playerCardsBattlefield.count, .zero)
        XCTAssertEqual(viewModel.currentRound, currentRound)
        XCTAssertEqual(viewModel.playerScore, .zero)
        XCTAssertEqual(viewModel.playerVictory, .zero)
        XCTAssertEqual(viewModel.computerVictory, .zero)
        XCTAssertEqual(viewModel.isPlayerMove, false)
        XCTAssertEqual(viewModel.gameResultText, "")
        XCTAssertEqual(viewModel.isPlayerPass, true)
    }
    
    func testPutAllCardsOnTable() {
        // Given
        let deckOfCards: Int = 15
        let cardsInHand: Int = 5
        let currentRound: Int = 1
        let playerCardsBattlefieldCount: Int = 5
        
        // When
        for _ in 0..<5 {
            if let firstCard = viewModel.playerHand.first {
                viewModel.playCard(firstCard)
            }
        }
        
        // Then
        XCTAssertEqual(viewModel.playerDeck.count, deckOfCards)
        XCTAssertEqual(viewModel.computerDeck.count, deckOfCards)
        XCTAssertEqual(viewModel.playerHand.count, .zero)
        XCTAssertEqual(viewModel.computerHand.count, cardsInHand)
        XCTAssertEqual(viewModel.playerCardsBattlefield.count, playerCardsBattlefieldCount)
        XCTAssertEqual(viewModel.computerCardsBattlefield.count, .zero)
        XCTAssertEqual(viewModel.currentRound, currentRound)
        XCTAssertNotEqual(viewModel.playerScore, .zero)
        XCTAssertEqual(viewModel.computerScore, .zero)
        XCTAssertEqual(viewModel.playerVictory, .zero)
        XCTAssertEqual(viewModel.computerVictory, .zero)
        XCTAssertEqual(viewModel.isPlayerMove, true)
        XCTAssertEqual(viewModel.gameResultText, "")
        XCTAssertEqual(viewModel.isPlayerPass, false)
        XCTAssertEqual(viewModel.isComputerPass, false)
    }
    
    
    func testPassTurn() {
        // Given
        let deckOfCards: Int = 15
        let cardsInHand: Int = 5
        let currentRound: Int = 1
        
        // When
        viewModel.passTurn()
        
        // Then
        XCTAssertEqual(viewModel.playerDeck.count, deckOfCards)
        XCTAssertEqual(viewModel.computerDeck.count, deckOfCards)
        XCTAssertEqual(viewModel.playerHand.count, cardsInHand)
        XCTAssertEqual(viewModel.playerHand.count, cardsInHand)
        XCTAssertEqual(viewModel.playerCardsBattlefield.count, .zero)
        XCTAssertEqual(viewModel.currentRound, currentRound)
        XCTAssertEqual(viewModel.playerScore, .zero)
        XCTAssertEqual(viewModel.playerVictory, .zero)
        XCTAssertEqual(viewModel.computerVictory, .zero)
        XCTAssertEqual(viewModel.isPlayerMove, true)
        XCTAssertEqual(viewModel.gameResultText, "")
        XCTAssertEqual(viewModel.isPlayerPass, false)
    }
}
