//
//  Cards.swift
//  GameChallenge
//
//  Created by Fernando de Lucas da Silva Gomes on 15/03/21.
// swiftlint:disable unused_setter_value

import SpriteKit

enum CardLevel: CGFloat {
    case board = 10
    case moving = 100
    case enlarged = 200
}

class Card: SKSpriteNode {
    
    var frontTexture: SKTexture?
    var backTexture: SKTexture
    var faceUp: Bool = false
    private var initialPosition = CGPoint.zero
    
    override var isUserInteractionEnabled: Bool {
        get {
            return true
        }
        set {
            // ignore
        }
    }
    
    init() {
        self.backTexture = SKTexture(imageNamed: "papa")
        super.init(texture: backTexture, color: .clear, size: backTexture.size())
        zPosition = CardLevel.board.rawValue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func flip() {
        if faceUp {
            self.texture = backTexture
        } else {
            self.texture = frontTexture
        }
        faceUp = !faceUp
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let _ = parent as? DisplayCardHelper {
            initialPosition = self.position
            self.zPosition = CardLevel.moving.rawValue
            self.removeAction(forKey: "drop" )
            self.run(SKAction.scale(to: 1.2, duration: 0.25), withKey: "pickup")
        }
        
        // verificar se carta está no deck, se estiver fazer animação de flip
        // self.flip()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if let myParent = parent as? DisplayCardHelper {
                let location = touch.location(in: myParent)
                self.position = location
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let myParent = parent as? DisplayCardHelper {
            if self.position.y > self.size.height {
                myParent.removeCard(card: self)
            } else {
                self.zPosition = CardLevel.board.rawValue
                self.position = initialPosition
                self.removeAction(forKey: "pickup" )
                self.run(SKAction.scale(to: 1.0, duration: 0.25), withKey: "drop" )
            }
        }
    }
}
