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
    var itemsPlayer: ItemsPlayer!
    var itemsEnemy: ItemsEnemy!
    
    override func didMove(to view: SKView) {

        self.backgroundColor = .white
        
        let Cards = BuildCards().buildAllEntities()

        self.displayCard = DisplayCardHelper(cards: Cards, superView: view)
        
        grid = Grid(blockWidth: (UIScreen.main.bounds.width * 0.7)/5, blockHeight: (UIScreen.main.bounds.height*0.6)/4, rows: 4, cols: 5)!
        grid.position = CGPoint(x: (self.view?.bounds.width)!/2, y: (self.view?.bounds.maxY)! - grid.size.height/2 - 10)
        addChild(grid)
        
        // pega a posicao do quadro no grid e repassa para a carta
        addChild(displayCard!)
        
        itemsPlayer = ItemsPlayer(superView: view)
        addChild(itemsPlayer)
        
        itemsEnemy = ItemsEnemy(superView: view)
        addChild(itemsEnemy)
        
    }
}
