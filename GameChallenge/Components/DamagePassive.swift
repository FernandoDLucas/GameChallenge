//
//  DamagePassive.swift
//  GameChallenge
//
//  Created by Fernando de Lucas da Silva Gomes on 06/04/21.
//
import SpriteKit

class DamagePassive {
    var value: Int?

    init(value: Int) {
        self.value = value
    }
//    func damage(player: Player, value: Int) {
//      scene?.displayCard?.addCard(card: cards!)
//    }
    
}

extension DamagePassive: Passive {
    func deActivate() {
        
    }
    
    func activate(on player: GameScene) {
//        self.damage(player: player)
    }
    
}
