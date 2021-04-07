//
//  HealPassive.swift
//  GameChallenge
//
//  Created by Fernando de Lucas da Silva Gomes on 06/04/21.
//
import SpriteKit

class HealPassive {
    var value: Int?
    
    init(value: Int) {
        self.value = value
    }
//    func heal(player: Player, value: Int) {
////        scene?.displayCard?.addCard(card: cards!)
//    }
    
}

extension HealPassive: Passive {
    func deActivate() {
        
    }
    
    func activate(on player: GameScene) {
//        self.heal(player: player)
    }

}
