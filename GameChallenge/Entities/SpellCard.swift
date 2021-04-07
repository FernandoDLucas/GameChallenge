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
        
    init(cost: Int, passiveDescription: String, passiveDamage: Int) {
        super.init()
        self.texture = SKTexture(imageNamed: "bgCardSpell")
        self.costComponent.costValue = cost
        self.passiveComponent.labelNode.text = passiveDescription
        addChild(passiveComponent)
    }
    
    init(cost: Int, passiveDescription: String, passiveHeal: Int) {
        super.init()
        self.texture = SKTexture(imageNamed: "bgCardSpell")
        self.costComponent.costValue = cost
        self.passiveComponent.labelNode.text = passiveDescription
        self.passiveComponent.passive = HealPassive(value: 12)
        addChild(passiveComponent)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
