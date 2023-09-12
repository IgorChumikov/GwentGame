//
//  GameViewModel.swift
//  GwentGame
//
//  Created by Chumikov Igor Valeryevich on 06.05.2023.
//

import Foundation

final class GameViewModel: ObservableObject, IGameViewModel {
    // MARK: - Properties
    
    // Колоды карт
    @Published var playerDeck: [Card] = []
    @Published var computerDeck: [Card] = []
    
    // Карты на руке
    @Published var playerHand: [Card] = []
    @Published var computerHand: [Card] = []
    
    // Карты на поле битвы
    @Published var playerCardsBattlefield: [Card] = []
    @Published var computerCardsBattlefield: [Card] = []
    
    // Раунд
    @Published var currentRound: Int = 1
    
    // Сила
    @Published var playerScore: Int = 0
    @Published var computerScore: Int = 0
    
    // Победа
    @Published var playerVictory: Int = 0
    @Published var computerVictory: Int = 0
    
    @Published var isPlayerMove: Bool = true
    
    @Published var gameResultText: String = ""
    
    @Published var isPlayerPass: Bool = false
    @Published var isComputerPass: Bool = false
    
    
    // MARK: - Private Properties
    
    private let totalRounds = 4
    private let initialCardsCount = 5
    private let computerPlaybackDelay: TimeInterval = 3
    
    
    // MARK: - Init
    
    init() {
        self.playerDeck = createDeck(isPlayerDeck: true)
        self.computerDeck = createDeck(isPlayerDeck: false)
        self.playerHand = playerDrawCards(numberOfCards: initialCardsCount)
        self.computerHand = computerDrawCards(numberOfCards: initialCardsCount)
    }
    
    // MARK: - Public methods
    
    // Перемещение карты из руки игрока и компьютера в массивы поле боя
    func playCard(_ card: Card) {
        if let index = playerHand.firstIndex(of: card) {
            playerCardsBattlefield.append(playerHand[index])
            playerHand.remove(at: index)
        }
        
        playerScore = playerCardsBattlefield.reduce(0, { $0 + $1.attack.rawValue })
    }
    
    func pass() {
        isPlayerMove = false
        isPlayerPass = true
        computerPlay()
    }
    
    func passTurn() {
        guard !isComputerPass else {
            return
        }
        
        isPlayerMove = false
        computerPlay()
    }
    
    // MARK: - Private Methods
    
    // Создание массива карт с заданными атаками
    private func createDeck(isPlayerDeck: Bool) -> [Card] {
        var deck: [Card] = []
        for _ in 1...2 {
            deck.append(Card(attack: .six, imageName: isPlayerDeck ? .warrior6 : .noWarrior))
        }
        for _ in 1...3 {
            deck.append(Card(attack: .four, imageName: isPlayerDeck ? .warrior4 : .noWarrior))
        }
        for _ in 1...5 {
            deck.append(Card(attack: .two, imageName: isPlayerDeck ? .warrior2 : .noWarrior))
        }
        for _ in 1...10 {
            deck.append(Card(attack: .one, imageName: isPlayerDeck ? .warrior1 : .noWarrior))
        }
        return deck
    }
    
    // Выбор случайных карт из колоды и удаление их из колоды
    private func playerDrawCards(numberOfCards: Int) -> [Card] {
        return drawCards(deck: &playerDeck, numberOfCards: numberOfCards)
    }
    
    private func computerDrawCards(numberOfCards: Int) -> [Card] {
        return drawCards(deck: &computerDeck, numberOfCards: numberOfCards)
    }
    
    private func drawCards(deck: inout [Card], numberOfCards: Int) -> [Card] {
        var cards: [Card] = []
        for _ in 1...numberOfCards {
            if let card = deck.randomElement() {
                cards.append(card)
                if let index = deck.firstIndex(of: card) {
                    deck.remove(at: index)
                }
            }
        }
        return cards
    }
    
    private func computerPlay() {
        guard computerHand.count > 1 else {
            if isPlayerPass {
                DispatchQueue.main.asyncAfter(deadline: .now() + computerPlaybackDelay) { [weak self] in
                    self?.startNewRound()
                }
            } else {
                isPlayerMove = true
                isComputerPass = true
            }
            return
        }
        
        if !isComputerPass {
            isComputerPass = Bool.random()
        }
        
        if isComputerPass && isPlayerPass {
            DispatchQueue.main.asyncAfter(deadline: .now() + computerPlaybackDelay) { [weak self] in
                self?.startNewRound()
            }
        } else {
            runComputer()
        }
    }
    
    private func runComputer() {
        for _ in 0..<2 {
            let randomIndex = Int.random(in: 0..<computerHand.count)
            var randomCard = computerHand[randomIndex]
            switch randomCard.attack {
            case .one:
                randomCard.imageName = .warrior1
            case .two:
                randomCard.imageName = .warrior2
            case .four:
                randomCard.imageName = .warrior4
            case .six:
                randomCard.imageName = .warrior6
            }
            
            computerCardsBattlefield.append(randomCard)
            computerHand.remove(at: randomIndex)
        }
        computerScore = computerCardsBattlefield.reduce(0, { $0 + $1.attack.rawValue })
        
        if isPlayerPass {
            computerPlay()
        } else {
            isPlayerMove = true
        }
    }
    
    private func startNewRound() {
        // Определяем победителя раунда
        if playerScore > computerScore {
            playerVictory += 1
        } else if playerScore < computerScore {
            computerVictory += 1
        } else {
            playerVictory += 1
            computerVictory += 1
        }
        
        isPlayerPass = false
        isComputerPass = false
        
        // Очищаем силу
        playerScore = 0
        computerScore = 0
        
        // Очищаем поля боя
        playerCardsBattlefield.removeAll()
        computerCardsBattlefield.removeAll()
        
        // Прибавляем номер текущего раунда
        currentRound += 1
        
        // Выдаем дополнительные карты для каждого игрока
        for _ in 0..<3 {
            if let playerCard = playerDeck.popLast() {
                playerHand.append(playerCard)
            }
            if let computerCard = computerDeck.popLast() {
                computerHand.append(computerCard)
            }
        }
        
        if currentRound == totalRounds {
            gameEnd()
        } else {
            isPlayerMove = true
        }
    }
    
    private func gameEnd() {
        //Проверяем, закончилась ли игра
        if playerVictory > computerVictory {
            gameResultText = "Твоя сила победила!"
        } else if playerVictory < computerVictory {
            gameResultText =  "Поражение - это не конец"
        } else {
            gameResultText = "Ничья, поражение для Ведьмака"
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + computerPlaybackDelay) { [weak self] in
            self?.restartGame()
        }
    }
    
    private func restartGame() {
        gameResultText = ""
        currentRound = 1
        playerVictory = 0
        computerVictory = 0
        playerDeck = createDeck(isPlayerDeck: true)
        computerDeck = createDeck(isPlayerDeck: false)
        playerHand = playerDrawCards(numberOfCards: 5)
        computerHand = computerDrawCards(numberOfCards: 5)
        isPlayerMove = true
    }
    
}
