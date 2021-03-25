//
//  ItemsEnemy.swift
//  GameChallenge
//
//  Created by Kellyane Nogueira on 24/03/21.
//

import SpriteKit

class ItemsEnemy: SKSpriteNode {
    var superView: SKView
    var mana: Item!
    var life: Item!
    var handCards: Item!
    
    init(superView: SKView) {
        self.superView = superView
        
        super.init(texture: SKTexture(imageNamed: "bgPlayer"), color: .clear, size: TABLEAU_SIZE)
        self.position = CGPoint(x: self.frame.width/2 + 6, y: superView.frame.size.height/2 + 63)
        
        self.setupHandsCards()
        self.setupLife()
        self.setupMana()
      
    }
    
    private func setupHandsCards() {
        let textureHand = SKTexture(imageNamed: "handEnemy")
        self.handCards = Item(value: 0, texture: textureHand, size: HAND_CARD_ENEMY_SIZE, positionLabel: CGPoint(x: -1, y: 3))
        handCards.position = CGPoint(x: 0, y: (LIFE_SIZE.height/2 + 15))
        handCards.zPosition = 10
        addChild(handCards)
    }
    
    private func setupLife() {
        let textureLife = SKTexture(imageNamed: "lifeEnemy")
        self.life = Item(value: 5, texture: textureLife, size: LIFE_SIZE, positionLabel: CGPoint(x: 0, y: -5))
        life.position = CGPoint(x: 0, y: -12)
        life.zPosition = 10
        addChild(life)
    }
    
    private func setupMana() {
        let textureMana = SKTexture(imageNamed: "manaEnemy")
        self.mana = Item(value: 1, texture: textureMana, size: MANA_SIZE, positionLabel: CGPoint(x: -1, y: -5))
        mana.position = CGPoint(x: 0, y: -(MANA_SIZE.height + 25))
        mana.zPosition = 10
        addChild(mana)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
