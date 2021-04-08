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
    
    var frontTexture: SKTexture
    var backTexture: SKTexture
    var faceUp: Bool = true
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

        self.frontTexture = SKTexture(imageNamed: "bgCardSpell")
        self.backTexture = SKTexture(imageNamed: "backCard")
        super.init(texture: frontTexture, color: .clear, size: CARD_HAND_SIZE)

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
      let firstHalfFlip = SKAction.scaleX(to: 0.0, duration: 0.25)
      let secondHalfFlip = SKAction.scaleX(to: 1.0, duration: 0.25)
      
      setScale(1.0)
      
      if faceUp {
        run(firstHalfFlip) {
          self.texture = self.backTexture
          self.run(secondHalfFlip)
        }
      } else {
        run(firstHalfFlip) {
          self.texture = self.frontTexture
          self.run(secondHalfFlip)
        }
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
    
    func changeTexture(to newTexture: String, size: CGSize) {
        let texture = SKTexture(imageNamed: newTexture)
        self.size = size
        let action = SKAction.setTexture(texture)
        self.run(action)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

            if let _ = parent as? DisplayCardHelper {
                for touch in touches where touch.tapCount > 1 {
                  self.enlarge()
                  return
                }

                if self.enlarged { return }
                
                savedPosition = self.position
                initialZPosition = self.zPosition
                self.zPosition = CardLevel.moving.rawValue
                self.removeAction(forKey: "drop" )
                self.run(SKAction.scale(to: 1.2, duration: 0.25), withKey: "pickup")
            }
            
            if let _ = parent as? Grid {
                if !onAttack {
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

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.enlarged { return }
        for touch in touches {
            if let myParent = parent as? DisplayCardHelper {
                let location = touch.location(in: myParent)
                self.position = location
            }
            if let myParent = parent as? Grid, let _ = self.scene as? GameScene {
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
        
        if let _ = self.parent as? Grid, let scene = self.scene as? GameScene {
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
        }
    }
}
