//
//  Card.swift
//  GwentGame
//
//  Created by Chumikov Igor Valeryevich on 06.05.2023.
//

import Foundation

struct Card: Equatable, Identifiable {
    // MARK: - Properties
    
    let id = UUID()
    var attack: AttackCard
    var imageName: WarriorCard
    
    // MARK: - Inits

    init(attack: AttackCard, imageName: WarriorCard) {
        self.attack = attack
        self.imageName = imageName
    }
}
