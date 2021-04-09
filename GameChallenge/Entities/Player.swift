//
//  Player.swift
//  GameChallenge
//
//  Created by Lidiane Gomes Barbosa on 07/04/21.
//

import Foundation
enum PlayerType: String {
    case playerOne, playerTwo
}

class Player: Equatable {
    let playerId: UUID
    var life: Int
    var mana: Int
    var isActive: Bool
    var cardsOnHand: [SpellCard]
    var cardsOnDeck: [SpellCard]
    let type: PlayerType
    let surrender: Bool = false
    
    init(cardsOnHand: [SpellCard], cardsOnDeck: [SpellCard], type: PlayerType) {
        self.type = type
        playerId = UUID()
        self.life = 20
        self.mana = 1
        self.isActive = false
        self.cardsOnHand = cardsOnHand
        self.cardsOnDeck = cardsOnDeck
    }
    
    static func == (lhs: Player, rhs: Player) -> Bool {
        lhs.playerId == rhs.playerId
    }
    
    func incrementMana(value: Int) {
        mana += value
    }
    
    func decrementMana(value: Int) {
        if value <= mana {
            mana -= value
        }
    }
    
    func incrementLife(value: Int) {
        life += value
    }
    
    func decrementLife(value: Int) {
        if value <= life {
            life -= value
        }
    }
}
