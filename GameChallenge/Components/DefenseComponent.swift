//
//  LifeComponent.swift
//  GameChallenge
//
//  Created by Fernando de Lucas da Silva Gomes on 15/03/21.
//

import SpriteKit

class DefenseComponent: SKSpriteNode {
        
    var defenseTexture: SKTexture?
    let labelNode = SKLabelNode(text: "0")
    var defenseValue: Int = 0 {
        didSet {
            labelNode.text = String(self.defenseValue)
        }
    }
    
    init() {
//        self.defenseTexture = SKTexture(imageNamed: "elipse")
        labelNode.fontSize = 8
        super.init(texture: defenseTexture, color: .clear, size: COMPONENT_SIZE)
        addChild(labelNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func takenDamage(damage: Int) {
        defenseValue -= damage
    }
    
    func buffDefense(value: Int) {
        defenseValue += value
    }
}

extension DefenseComponent : Component {
    func returnSelf() -> SKSpriteNode {
        return self
    }
}
