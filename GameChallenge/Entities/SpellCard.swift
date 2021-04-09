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
        self.passiveComponent.passive = DamagePassive(value: 12)
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
    
    override init() {
        super.init()
    }
    
    override func createCopy() -> SpellCard {
        let card = SpellCard()
        card.passiveComponent = self.passiveComponent
        card.costComponent = self.costComponent
        card.backTexture = self.backTexture
        card.frontTexture = self.frontTexture
        card.size = self.size
        card.color = self.color
        card.texture = self.texture
        return card
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
