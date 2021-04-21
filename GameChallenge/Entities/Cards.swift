//
//  Cards.swift
//  GameChallenge
//
//  Created by Fernando de Lucas da Silva Gomes on 15/03/21.
// swiftlint:disable unused_setter_value

import SpriteKit

enum CardLevel: CGFloat {
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
    var cardName = SKLabelNode()
    
    override var isUserInteractionEnabled: Bool {
        get {
            return true
        }
        set {
            // ignore
        }
    }
    
    init(cardName: String) {
        self.frontTexture = SKTexture(imageNamed: "bgCardSpell")
        self.backTexture = SKTexture(imageNamed: "backCard")
        super.init(texture: frontTexture, color: .clear, size: CARD_HAND_SIZE)
        configureCardName(name: cardName)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCardName(name: String) {
       
        self.cardName.position = CGPoint(x: self.size.width / 2 * 0.1, y: self.size.height / 2 * 0.7)
        self.cardName.numberOfLines = 0
        self.cardName.preferredMaxLayoutWidth = CGFloat(60)
        self.cardName.lineBreakMode = .byTruncatingMiddle
        self.cardName.horizontalAlignmentMode = .center
        self.cardName.verticalAlignmentMode = .center
      
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        cardName.attributedText = NSAttributedString(string: name, attributes: [NSAttributedString.Key.font: UIFont(name: "xilosa", size: 12) ?? UIFont.systemFont(ofSize: 12), NSAttributedString.Key.foregroundColor: UIColor.text, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        addChild(cardName)
        cardName.zPosition = 1
    }
    
    func createCopy() -> Card {
        let card = Card(cardName: cardName.text!)
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
                self.cardName.isHidden = true
                self.texture = self.backTexture
                self.run(secondHalfFlip)
            }
        } else {
            run(firstHalfFlip) {
                self.cardName.isHidden = false
                self.texture = self.frontTexture
                self.run(secondHalfFlip)
            }
        }
        faceUp = !faceUp
    }
    
    func enlarge() {
        if enlarged {
            enlarged = false
            position = savedPosition
            zPosition = initialZPosition
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
        
        if let _ = parent as? Grid, let scene = self.scene as? GameScene {
            self.removeFromParent()
            scene.boardHelper.removeFromBoard(remove: self)
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
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if self.enlarged { return }
        
        if let parent = self.parent as? DisplayCardHelper, let scene = self.scene as? GameScene {

            if scene.grid.intersects(self), !parent.intersects(self), scene.canPlay {
                let card = self.createCopy()
                if scene.boardHelper.freeSpace {
                    parent.removeCard(card: self)
                    scene.boardHelper.addCardToBoard(add: card)
                    scene.gameManagement.playCard(self as! SpellCard)
                    scene.updateModel()
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
        
    }
}
