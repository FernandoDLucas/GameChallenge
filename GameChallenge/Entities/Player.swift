//
//  Player.swift
//  GameChallenge
//
//  Created by Lidiane Gomes Barbosa on 07/04/21.
//

import Foundation
class Player {
    let playerId: UUID
    var life: Int
    var mana: Int
    var isActive: Bool
    var listOfCards: DisplayCardHelper
    private var items: ItemsPlayer
    
    init(items: ItemsPlayer, listOfCards: DisplayCardHelper) {
        self.items = items
        playerId = UUID()
        self.life = 20
        self.mana = 3
        self.isActive = false
        self.listOfCards = listOfCards
    }
    
    func incrementMana(value: Int) {
        mana += value
        items.mana.changeValue(mana)
    }
    
    func decrementMana(value: Int) {
        if value <= mana {
            mana -= value
        }
        items.mana.changeValue(mana)
    }
    
    func incrementLife(value: Int) {
        life += value
        items.life.changeValue(life)
    }
    
    func decrementLife(value: Int) {
        if value <= life {
            life -= value
        }
        items.life.changeValue(life)
    }
    
    func deckIsEmpty() -> Bool {
        items.deck.listOfCards.isEmpty
    }
        
}
