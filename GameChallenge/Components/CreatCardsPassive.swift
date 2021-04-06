//
//  CreatCardsPassive.swift
//  GameChallenge
//
//  Created by Fernando de Lucas da Silva Gomes on 17/03/21.
//

import SpriteKit

class CreateCardsPassive {
    var scene: GameScene?
    var cards: SpellCard?
    
    convenience init(on scene: GameScene, cards: SpellCard) {
        self.init()
        self.scene = scene
        self.cards = cards
    }
    func create() {
        scene?.displayCard?.addCard(card: cards!)
    }
}

extension CreateCardsPassive: Passive {
    func deActivate() {
        
    }
    
    func activate() {
        self.create()
    }
}
