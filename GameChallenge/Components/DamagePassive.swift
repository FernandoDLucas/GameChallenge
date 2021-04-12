//
//  DamagePassive.swift
//  GameChallenge
//
//  Created by Fernando de Lucas da Silva Gomes on 07/04/21.
//

import SpriteKit

class DamagePassive {
    var value: Int?
    var type = PassiveType.damage

    init(value: Int) {
        self.value = value
    }
//    func damage(player: Player, value: Int) {
//      scene?.displayCard?.addCard(card: cards!)
//    }
    
}

extension DamagePassive: Passive {
    func getPassive() -> PassiveType {
        return self.type
    }
    
    func getValue() -> Int {
        return self.value ?? 0 
    }
}
