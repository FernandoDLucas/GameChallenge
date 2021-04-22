//
//  itemsPlayer.swift
//  GameChallenge
//
//  Created by Kellyane Nogueira on 24/03/21.
//

import SpriteKit

class ItemsPlayer: SKSpriteNode {
    var superView: SKView
    var mana: Item!
    var life: Item!
    var deck: DeckHelper!
    
    init(superView: SKView) {
        self.superView = superView
        
        super.init(texture: SKTexture(imageNamed: "bgPlayer"), color: .clear, size: TABLEAU_SIZE)
        
        self.position = CGPoint(x: superView.frame.size.width - (size.width/2 + 40), y: superView.frame.size.height/2 + 20)
        self.setupMana()
        self.setupLife()
        self.setupDeck()
      
    }
    
    private func setupMana() {
        let textureMana = SKTexture(imageNamed: "manaPlayer")
        self.mana = Item(value: 1, texture: textureMana, size: MANA_SIZE, positionLabel: CGPoint(x: -1, y: -5))
        mana.position = CGPoint(x: 0, y: -12)
        mana.zPosition = 10
        addChild(mana)
    }
    
    private func setupLife() {
        let textureLife = SKTexture(imageNamed: "lifePlayer")
        self.life = Item(value: 20, texture: textureLife, size: LIFE_SIZE, positionLabel: CGPoint(x: 0, y: -5))
        life.position = CGPoint(x: 0, y: (LIFE_SIZE.height/2 + 15))
        life.zPosition = 10
        addChild(life)
    }
    
    private func setupDeck() {
        let cardsToDeck = BuildCards().buildAllSpells()
        self.deck = DeckHelper(listOfCards: cardsToDeck, texture: nil)
        deck.position = CGPoint(x: 0, y: -(DECK_SIZE.height + 25))
        deck.zPosition = 10
        addChild(deck)
    }
    
    func updateValues(mana: Int, life: Int, cardsOnDeck: [SpellCard]) {
        self.mana.changeValue(mana)
        self.life.changeValue(life)
        self.deck.updateCards(cards: cardsOnDeck)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
