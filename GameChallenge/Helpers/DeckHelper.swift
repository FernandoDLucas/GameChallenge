//
//  DeckHelper.swift
//  GameChallenge
//
//  Created by Kellyane Nogueira on 18/03/21.
//

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

        let size = CGSize(width: 40, height: 52)
        super.init(texture: texture, color: .blue, size: size)
        self.position = CGPoint(x: superView.frame.size.width - 48, y: superView.frame.size.height - 107)
        //inclinação da carta de acordo com números ímpares e pares, embora a posiçao seja a mesma
        
        addCardsInScene()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        popCard()
    }
    
    func addCardsInScene() {
        for card in listOfCards {
            card.flip()
           // card.zRotation = CGFloat(1)
            addChild(card)
        }
    }
    
    //Escolher uma carta aleatória e entregar ao DisplayCardHelper
    func popCard() {
        if !listOfCards.isEmpty {
            let card = listOfCards.removeLast()
            card.flip()
            
            if let scene = scene as? GameScene {
                let move = SKAction.move(to: CGPoint(x: superView.frame.width/2, y: scene.displayCard!.position.y/2), duration: 2)
                let moveDone = SKAction.removeFromParent()
                card.run(SKAction.sequence([move, moveDone]))
                scene.displayCard?.addCard(card: card)
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
