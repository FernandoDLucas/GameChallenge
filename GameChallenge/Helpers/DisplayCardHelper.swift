//
//  DisplayCardHelper.swift
//  GameChallenge
//
//  Created by Lidiane Gomes Barbosa on 16/03/21.
//

import SpriteKit

class DisplayCardHelper: SKSpriteNode {
    
    private var cards: [Card]
    private var superView: SKView
    
    init(cards: [Card], texture: SKTexture?, superView: SKView) {
        self.cards = cards
        self.superView = superView
        let size = CGSize(width: superView.frame.width, height: superView.frame.height * 0.5)
        
        super.init(texture: texture, color: .clear, size: size)
        
        position = CGPoint.init(x: superView.center.x, y: 0)
        setAllPositions(cards: cards)
        addAllCards(cards: cards)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    func addAllCards(cards: [Card]) {
        for card in cards {
            addChild(card)
        }
    }
    
    func addCard(card: Card) {
        cards.append(card)
        addChild(card)
        setAllPositions(cards: cards)
    }
    
    func removeCardAt(indice: Int) {
        if !cards.isEmpty {
            let cardRemoved = cards.remove(at: indice)
            removeCard(card: cardRemoved)
            setAllPositions(cards: cards)
        }
    }
    
    func removeCard(card: Card) {
        cards = cards.filter({ $0 != card})
        card.removeFromParent()
        setAllPositions(cards: cards)
    }

    func setAllPositions(cards: [Card]) {
        let xCenter = CGFloat.zero
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

}
