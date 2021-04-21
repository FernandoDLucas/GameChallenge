//
//  Associeted Component.swift
//  GameChallenge
//
//  Created by Fernando de Lucas da Silva Gomes on 15/03/21.
//

import SpriteKit

class AssocietedCard: Card {
    
    var defenseComponent = DefenseComponent()
    var powerComponent = PowerComponent()
    var passiveComponent = PassiveComponent()
    var costComponent = CostComponent()
    
    init(cost: Int, power: Int, defense: Int, passiveDescription: String) {
        super.init(cardName: "")
        self.defenseComponent.defenseValue = defense
        self.powerComponent.powerValue = power
        self.costComponent.costValue = cost
        self.passiveComponent.labelNode.text = passiveDescription
        defenseComponent.position = CGPoint(x: 26, y: -40)
        addChild(defenseComponent)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
}
