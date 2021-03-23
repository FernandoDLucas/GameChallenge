//
//  DeckHelper.swift
//  GameChallenge
//
//  Created by Kellyane Nogueira on 18/03/21.
// swiftlint:disable unused_setter_value

import SpriteKit

class DeckHelper: SKSpriteNode {
    var listOfCards: [Card]
    var superView: SKView

    override var isUserInteractionEnabled: Bool {
        get {
            return true
        }
        set {
            // ignore
        }
    }
    
    init(listOfCards: [Card], texture: SKTexture?, superView: SKView) {
        self.listOfCards = listOfCards
        self.superView = superView
        
        super.init(texture: texture, color: .gray, size: DECK_SIZE)
        self.position = CGPoint(x: superView.frame.size.width - 48, y: superView.frame.size.height - 107)
        //inclinação da carta de acordo com números ímpares e pares, embora a posiçao seja a mesma
        
        addCardsInScene()
    }
    
    func addCardsInScene() {
        for (index, card) in listOfCards.enumerated() {
            card.flip()
            card.size = CARD_DECK_SIZE
            if index % 2 == 0 {
                card.zRotation = CGFloat(-0.25)
            }
            addChild(card)
        }
    }
    
    //Escolher uma carta aleatória e entregar ao DisplayCardHelper
    func popCard() {
        if !listOfCards.isEmpty {
            let card = listOfCards.removeLast()
            card.flip()
            
            if let scene = scene as? GameScene {
                let move = SKAction.move(to: CGPoint(x: -superView.frame.width/2, y: -(superView.frame.height - scene.displayCard.size.height)), duration: 0.30)
                let zoom = SKAction.scale(to: 2, duration: 0.2)
              
                card.run(SKAction.sequence([zoom, move]))
                self.removeAllActions()
    
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.50) {
                    let copyCard = card.createCopy()
                    copyCard.size = CGSize(width: 102, height: 141)
                    card.removeFromParent()
                    scene.displayCard.addCard(card: copyCard)
                }
            }
        }
    }
    
    //Mudar a visualização de acordo com a quantidade de cartas
    func changeViewDeck() {
        if listOfCards.isEmpty {
            //self.texture = SKTexture(imageNamed: "")
            self.color = .white
        } else if listOfCards.count == 15 {
            self.color = .green
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
