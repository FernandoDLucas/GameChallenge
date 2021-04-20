//
//  HealPassive.swift
//  GameChallenge
//
//  Created by Fernando de Lucas da Silva Gomes on 07/04/21.
//

import Foundation

class HealPassive {
    var value: Int?
    var type = PassiveType.heal
    
    init(value: Int) {
        self.value = value
    }
    
}

extension HealPassive: Passive {

    func getPassive() -> PassiveType {
        return self.type
    }
    
    func getValue() -> Int {
        return self.value ?? 0
    }

}

enum PassiveType {
    case heal, damage
}
