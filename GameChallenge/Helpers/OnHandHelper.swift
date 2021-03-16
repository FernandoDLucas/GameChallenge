//
//  OnHandHelper.swift
//  GameChallenge
//
//  Created by Fernando de Lucas da Silva Gomes on 15/03/21.
//

import SpriteKit

class OnHandHelper {
    
    let listOfCards: [Card]
    
    init(cards: [Card]) {
        self.listOfCards = cards
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
