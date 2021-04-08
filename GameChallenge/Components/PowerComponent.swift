//
//  PowerComponent.swift
//  GameChallenge
//
//  Created by Fernando de Lucas da Silva Gomes on 16/03/21.
//

import SpriteKit

class PowerComponent: SKSpriteNode {
        
    var powerTexture: SKTexture?
    let labelNode = SKLabelNode(text: "0")
    var powerValue: Int = 0 {
        didSet {
            labelNode.text = String(self.powerValue)
        }
    }
    
    init() {
        self.powerTexture = SKTexture(imageNamed: "powerCard")
        labelNode.fontSize = 8
        super.init(texture: powerTexture, color: .clear, size: COMPONENT_SIZE)
        addChild(labelNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func takenDamage(damage: Int) {
        powerValue -= damage
    }
    
    func buffDefense(value: Int) {
        powerValue += value
    }
}

extension PowerComponent: Component {
    func returnSelf() -> SKSpriteNode {
        return self
    }
}
