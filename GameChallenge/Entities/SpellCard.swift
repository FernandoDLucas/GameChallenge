//
//  SpellCard.swift
//  GameChallenge
//
//  Created by Fernando de Lucas da Silva Gomes on 15/03/21.
//

import SpriteKit

class SpellCard: Card {
    
    var passiveComponent = PassiveComponent()
    var costComponent = CostComponent()
        
    init(cost: Int, passiveDescription: String) {
        super.init()
        self.texture = SKTexture(imageNamed: "bgCardSpell")
        self.costComponent.costValue = cost
        self.passiveComponent.labelNode.text = passiveDescription
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
