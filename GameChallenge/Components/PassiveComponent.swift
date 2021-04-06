//
//  PassiveComponent.swift
//  GameChallenge
//
//  Created by Fernando de Lucas da Silva Gomes on 17/03/21.
//

import SpriteKit

class PassiveComponent: SKSpriteNode {
    
    let labelNode = SKLabelNode(text: "0")
    var passives: Passive?
    
    init() {
        super.init(texture: .none, color: .clear, size: CGSize(width: 70, height: 70))
        labelNode.fontColor = .white
        labelNode.fontSize = 12
        labelNode.fontName = "TimesNewRomanPSMT"
        addChild(labelNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
