//
//  Cards.swift
//  GameChallenge
//
//  Created by Fernando de Lucas da Silva Gomes on 15/03/21.
//

import SpriteKit

class Card: SKSpriteNode {
    
    var frontTexture: SKTexture?
    var backTexture: SKTexture
    var faceUp: Bool = false
    
    init() {
        self.backTexture = SKTexture(imageNamed: "papa")
        super.init(texture: backTexture, color: .clear, size: backTexture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
