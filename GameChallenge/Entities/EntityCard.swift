//
//  EntityCard.swift
//  GameChallenge
//
//  Created by Fernando de Lucas da Silva Gomes on 15/03/21.
//

import SpriteKit

class EntityCard: Card {
    
    var defenseComponent = DefenseComponent()
//    var attackComponent: PowerComponent
//    var passiveComponent: PassiveComponent
//    var costComponent: CostComponent
    
    init(defense: String) {
        super.init()
        self.defenseComponent.labelNode.text = defense
        defenseComponent.position = CGPoint(x: 26, y: -40)
        addChild(defenseComponent)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
