//
//  CostComponent.swift
//  GameChallenge
//
//  Created by Fernando de Lucas da Silva Gomes on 16/03/21.
//

import SpriteKit

class CostComponent: SKSpriteNode {
        
    var costTexture: SKTexture?
    let labelNode = SKLabelNode(text: "0")
    var costValue: Int = 0 {
        didSet {
            labelNode.text = String(self.costValue)
        }
    }
    
    init() {
        self.costTexture = SKTexture(imageNamed: "costCard")
        labelNode.fontColor = .red
        labelNode.fontSize = 8
        super.init(texture: costTexture, color: .clear, size: COMPONENT_SIZE)
        addChild(labelNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func takenDamage(damage: Int) {
        costValue -= damage
    }
    
    func buffDefense(value: Int) {
        costValue += value
    }
}

extension CostComponent: Component {
    func returnSelf() -> SKSpriteNode {
        return self
    }
}
