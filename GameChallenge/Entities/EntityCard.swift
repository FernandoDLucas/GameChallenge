//
//  EntityCard.swift
//  GameChallenge
//
//  Created by Fernando de Lucas da Silva Gomes on 15/03/21.
//

import SpriteKit

class EntityCard: Card {
    
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
        setPositions()
       addChildren([defenseComponent, powerComponent, costComponent])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setPositions() {
        defenseComponent.position = CGPoint(x: self.size.width*0.4, y: -self.size.height*0.375)
        powerComponent.position = CGPoint(x: -(self.size.width*0.375), y: -(self.size.height*0.375))
        costComponent.position = CGPoint(x: -self.size.width*0.8/2, y: (self.size.height*0.4))
    }
    
    func addChildren(_ children: [Component]) {
        children.forEach {
            addChild($0.returnSelf())
        }
    }
}
