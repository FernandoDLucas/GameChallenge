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
    var displayCard: DisplayCardHelper?
    var grid: Grid!
    var boardHelper: BoardHelper!
    
    override func didMove(to view: SKView) {
        self.backgroundColor = .white
        let Cards = BuildCards().buildAllCards()
        print(Cards.count)
        self.displayCard = DisplayCardHelper(cards: Cards, texture: nil, superView: view)
        
        grid = Grid(blockWidth: (UIScreen.main.bounds.width * 0.8)/5, blockHeight: (UIScreen.main.bounds.height*0.7)/4, rows: 4, cols: 5)!
        grid.position = CGPoint(x: (self.view?.bounds.width)!/2, y: (self.view?.bounds.maxY)! - grid.size.height/2 - 10)
        addChild(grid)
        self.boardHelper = BoardHelper(grid: self.grid, texture: grid.texture!, size: grid.size)
        addChild(boardHelper)
        // pega a posicao do quadro no grid e repassa para a carta
        addChild(displayCard!)
    }
}
