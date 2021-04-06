//
//  GameScene.swift
//  GameChallenge
//
//  Created by Fernando de Lucas da Silva Gomes on 12/03/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var label: SKLabelNode?
    private var spinnyNode: SKShapeNode?
    var displayCard: DisplayCardHelper!
    var grid: Grid!
    var deck: DeckHelper!
    var boardHelper: BoardHelper!
    
    override func didMove(to view: SKView) {

        self.backgroundColor = .white
        
        let Cards = BuildCards().buildAllSpells()

        self.displayCard = DisplayCardHelper(cards: Cards, texture: nil, superView: view)
        
        grid = Grid(blockWidth: (UIScreen.main.bounds.width * 0.7)/5, blockHeight: (UIScreen.main.bounds.height*0.6)/4, rows: 4, cols: 5)!
        grid.position = CGPoint(x: (self.view?.bounds.width)!/2, y: (self.view?.bounds.maxY)! - grid.size.height/2 - 10)
        addChild(grid)
        self.boardHelper = BoardHelper(grid: self.grid)

        addChild(displayCard!)
        
        let cards2 = BuildCards().buildAllSpells()
        deck = DeckHelper(listOfCards: cards2, texture: nil, superView: view)
        addChild(deck)
    }
}
