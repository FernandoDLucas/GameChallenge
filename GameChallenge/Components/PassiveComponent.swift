//
//  PassiveComponent.swift
//  GameChallenge
//
//  Created by Fernando de Lucas da Silva Gomes on 17/03/21.
//

import SpriteKit

class PassiveComponent: SKSpriteNode {
    
    let labelNode = SKLabelNode(text: "0")
    var passive: Passive?

    init() {
        super.init(texture: .none, color: .clear, size: CGSize(width: 80, height: 100))
        labelNode.fontColor = .red
        labelNode.fontSize = 8
        addChild(labelNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
