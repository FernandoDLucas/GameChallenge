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
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        popCard()
    }
    
//    func move(object: SKSpriteNode) {
//        SKAction.move(to: CGPoint(x: , y: ),
//                                       duration: TimeInterval())
//        object.run(SKAction.sequence([actionMove, loseAction, actionMoveDone]))
//
//    }
    
    //Escolher uma carta aleatória e entregar ao DisplayCardHelper
    func popCard() {
        //add textura frente e verso na ultima
        if !listOfCards.isEmpty {
            let card = listOfCards.removeLast()
            card.flip()
            addChild(card)
            card.flip()
            // animacao
            
            if let scene = scene as? GameScene {
                card.removeFromParent()
                scene.displayCard?.addCard(card: card)
            }
        }
        
    }
    
    
    //Mudar a visualização de acordo com a quantidade de cartas
    func changeViewDeck() {
        if listOfCards.isEmpty {
            self.color = .white
        } else if listOfCards.count == 15 {
            self.color = .green
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
