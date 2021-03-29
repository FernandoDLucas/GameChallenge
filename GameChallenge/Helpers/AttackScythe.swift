//
//  AttackScythe.swift
//  GameChallenge
//
//  Created by Kellyane Nogueira on 26/03/21.
// swiftlint:disable unused_setter_value

import SpriteKit

class AttackScythe: SKSpriteNode {
    
    override var isUserInteractionEnabled: Bool {
        get {
            true
        }
        set {
           //
        }
    }
    
    init(superView: SKView) {
        let texture = SKTexture(imageNamed: "attack")
        super.init(texture: texture, color: .clear, size: ATTACK_SCYTHE_SIZE)
        position = CGPoint(x: superView.frame.width/2, y: superView.frame.height/2 + 50)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.zRotation = -1.5 //Se for o Player local, o valor será negativo
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
