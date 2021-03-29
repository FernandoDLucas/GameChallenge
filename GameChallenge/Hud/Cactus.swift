//
//  Cactus.swift
//  GameChallenge
//
//  Created by Lidiane Gomes Barbosa on 25/03/21.
//

import SpriteKit
class Cactus: SKSpriteNode {
    
    init(superView: SKView) {
        
        let texture = SKTexture(imageNamed: "cactus")
        super.init(texture: texture, color: .clear, size: CACTUS_SIZE)
        
        self.position = CGPoint(x: 95, y: 130)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
