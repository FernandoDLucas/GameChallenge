//
//  DisplayCardHelper.swift
//  GameChallenge
//
//  Created by Lidiane Gomes Barbosa on 16/03/21.
//

import SpriteKit

class DisplayCardHelper: SKSpriteNode {
    
    private var cards: [Card]
    
    init(cards: [Card], texture: SKTexture?, size: CGSize) {
        self.cards = cards
        super.init(texture: texture, color: .clear, size: size)
        
        updateUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addChildHelper(cards: [Card]) {
        for card in cards {
            addChild(card)
        }
    }
    
    func addCard(card: Card) {
        if self.cards.count < 8 {
        cards.append(card)
        removeAllChildren()
        updateUI()
        }
    }
    
    func removeCardAt(indice: Int) {
        cards.remove(at: indice)
        removeAllChildren()
        updateUI()
    }
    
    func removeCard(card: Card) {
        removeAllChildren()
        cards.removeAll { myCard -> Bool in
            myCard == card
        }
        updateUI()
    }
    
    func updateUI() {
        addPosition(cards: self.cards, xCenter: getXCenterPosition())
        addChildHelper(cards: self.cards)
    }
    
    func addPosition(cards: [Card], xCenter: CGFloat) {
        let middle = cards.count / 2
        let isPair = cards.count % 2 == 0
        let yPosition = CGFloat(30)
        var xPosition = xCenter
    
        if !cards.isEmpty {
            let cardWidth = CGFloat(cards[0].size.width)
            if isPair {
                xPosition = xCenter - (cardWidth * 0.25)
                
                for ind in (0 ..< middle).reversed() {
                    cards[ind].position = CGPoint(x: xPosition, y: yPosition)
                    xPosition -= (cardWidth * 0.5)
                }
                
                xPosition = xCenter + (cardWidth * 0.25)
                for ind in middle..<cards.count {
                    cards[ind].position = CGPoint(x: xPosition, y: yPosition)
                    xPosition += (cardWidth * 0.5)
                }
                
            } else {
                cards[middle].position = CGPoint(x: xCenter, y: 30)
                xPosition = xCenter
                for ind in (0 ..< middle).reversed() {
                    xPosition -= (cardWidth * 0.5)
                    cards[ind].position = CGPoint(x: xPosition, y: yPosition)
                   
                }
           
                xPosition = xCenter
                for ind in (middle + 1)..<cards.count {
                    xPosition += (cardWidth * 0.5)
                    cards[ind].position = CGPoint(x: xPosition, y: yPosition)
                   
                }
            }
        }
        
    }
    
    func getXCenterPosition() -> CGFloat {
         size.width / 2
    }
}
