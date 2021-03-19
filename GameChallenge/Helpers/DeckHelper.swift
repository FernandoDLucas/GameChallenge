//
//  DeckHelper.swift
//  GameChallenge
//
//  Created by Kellyane Nogueira on 18/03/21.
//

import SpriteKit

class DeckHelper: SKSpriteNode {
    var deck: [Card]
    var superView: SKView
    var quantity: Int
    
    init(listOfCards: [Card], texture: SKTexture?, superView: SKView) {
        self.deck = listOfCards
        self.superView = superView
        self.quantity = deck.count
    
        let size = CGSize(width: 70, height: 10)
        super.init(texture: texture, color: .clear, size: size)
    }
    
    //Mudar a visualização de acordo com a quantidade de cartas
    //Escolher uma carta aleatória e entregar ao DisplayCardHelper
    
    func changeViewDeck() {
        switch quantity {
        case 10:
            print("Half-full")
        case 5:
            print("Half-empty")
        default:
            print("Full")
        }
    }
    
    //func
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
