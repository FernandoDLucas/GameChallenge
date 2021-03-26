//
//  Cards.swift
//  GameChallenge
//
//  Created by Fernando de Lucas da Silva Gomes on 15/03/21.
// swiftlint:disable unused_setter_value

import SpriteKit

enum CardLevel: CGFloat {
    case board = 0
    case moving = 100
    case enlarged = 200
}

class Card: SKSpriteNode {
    
    var frontTexture: SKTexture?
    var backTexture: SKTexture
    var faceUp: Bool = false
    private var initialPosition = CGPoint.zero
    private var savedPosition = CGPoint.zero
    var enlarged = false
    var initialZPosition = CGFloat.zero
    var onAttack: Bool = false
    var cell: Cell?
    
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
    
    func createCopy() -> Card {
        let card = Card()
        card.backTexture = self.backTexture
        card.frontTexture = self.frontTexture
        card.size = self.size
        card.color = self.color
        card.texture = self.texture
        return card
    }
    
    func flip() {
        if faceUp {
            self.texture = backTexture
        } else {
            self.texture = frontTexture
        }
        faceUp = !faceUp
    }
    
    func enlarge() {
      if enlarged {
        enlarged = false
        zPosition = CardLevel.board.rawValue
        position = savedPosition
        removeAllActions()
        setScale(1.0)
        zRotation = 0
      } else {
        enlarged = true
        savedPosition = position
        if let parent = parent as? DisplayCardHelper {
            position = CGPoint(x: 0, y: parent.size.height)
            self.zPosition = CardLevel.enlarged.rawValue
        }
        
        removeAllActions()
        setScale(2.0)
      }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if touch.tapCount > 1 {
              self.enlarge()
              return
            }

            if self.enlarged { return }
            if let _ = parent as? DisplayCardHelper {
                savedPosition = self.position
                initialZPosition = self.zPosition
                self.zPosition = CardLevel.moving.rawValue
                self.removeAction(forKey: "drop" )
                self.run(SKAction.scale(to: 1.2, duration: 0.25), withKey: "pickup")
            }
            
            if let _ = parent as? Grid{
                if !onAttack{
                    savedPosition = self.position
                    initialZPosition = self.zPosition
                    self.zPosition = CardLevel.moving.rawValue
                    self.removeAction(forKey: "drop" )
                    self.run(SKAction.scale(to: 1.2, duration: 0.25), withKey: "pickup")
                }
            }
        }
        
        // verificar se carta está no deck, se estiver fazer animação de flip
        // self.flip()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.enlarged { return }
        for touch in touches {
            if let myParent = parent as? DisplayCardHelper {
                let location = touch.location(in: myParent)
                self.position = location
            }
            if let myParent = parent as? Grid, let scene = self.scene as? GameScene{
                let location = touch.location(in: myParent)
                self.position = location
                self.onAttack = false
                self.cell?.free = true
            }
        }
    }

    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

        if self.enlarged { return }
        
        if let parent = self.parent as? DisplayCardHelper, let scene = self.scene as? GameScene {

            if scene.grid.intersects(self), !parent.intersects(self) {
                let card = self.createCopy()
                if scene.boardHelper.hadSpaceOnBoard() {
                    parent.removeCard(card: self)
                    scene.boardHelper.addCardToBoard(add: card)
                } else {
                    self.zPosition = initialZPosition
                    self.position = savedPosition
                    self.removeAction(forKey: "pickup" )
                    self.run(SKAction .scale(to: 1.0, duration: 0.25 ), withKey: "drop" )
                }

            } else {
                self.zPosition = initialZPosition
                self.position = savedPosition
                self.removeAction(forKey: "pickup" )
                self.run(SKAction .scale(to: 1.0, duration: 0.25 ), withKey: "drop" )

            }
        }
        
        if let parent = self.parent as? Grid, let scene = self.scene as? GameScene {
            let attackCells = scene.boardHelper.attackNodes()
            
            attackCells.forEach {
                if self.intersects($0.node) {
                    scene.boardHelper.addCardToAttack(add: self, to: $0)
                    self.cell = $0
                }
            }
            
            if !onAttack {
                self.zPosition = initialZPosition
                self.position = savedPosition
                self.removeAction(forKey: "pickup" )
                self.run(SKAction .scale(to: 1.0, duration: 0.25 ), withKey: "drop" )
            }
//            for i in 0..<5 {
//                if self.intersects(attackCells[i]) && scene.boardHelper.hadSpaceOnAttack(index: i) {
//                    self.position = attackCells[i].position
//                    self.removeAction(forKey: "pickup" )
//                    self.run(SKAction .scale(to: 1.0, duration: 0.25 ), withKey: "drop" )
//                    scene.boardHelper.deactivateAttackCell(index: i)
//                    onAttack = true
//                    break
//                } else {
//                    self.zPosition = initialZPosition
//                    self.position = savedPosition
//                    self.removeAction(forKey: "pickup" )
//                    self.run(SKAction .scale(to: 1.0, duration: 0.25 ), withKey: "drop" )
//                    onAttack = false
//                }
//            }
        }
    }
}
