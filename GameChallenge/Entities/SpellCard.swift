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
  
    init(cost: Int, passiveDescription: String, passiveDamage: Int, cardName: String) {
        super.init(cardName: cardName)
        self.costComponent.costValue = cost
        self.passiveComponent.descriptionLabel = passiveDescription
        self.passiveComponent.passive = DamagePassive(value: passiveDamage)
        addChild(costComponent)
        setCostPosition()
        addChild(passiveComponent)
    }
    
    init(cost: Int, passiveDescription: String, passiveHeal: Int, cardName: String) {
        super.init(cardName: cardName)
        self.costComponent.costValue = cost
        self.passiveComponent.descriptionLabel = passiveDescription
        self.passiveComponent.passive = HealPassive(value: passiveHeal)
        addChild(costComponent)
        setCostPosition()
        addChild(passiveComponent)
        passiveComponent.zPosition = 1
    }
    
    init() {
        super.init(cardName: "")
    }
    
    func setCostPosition() {
        if let parentCost = costComponent.parent {
            costComponent.position = CGPoint(x: (-parentCost.frame.width/2) * 0.7, y: (parentCost.frame.height/2) * 0.7)
        }
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
