//
//  GameScene.swift
//  GameChallenge
//
//  Created by Fernando de Lucas da Silva Gomes on 12/03/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
  
    var displayCard: DisplayCardHelper!
    var grid: Grid!
    var itemsPlayer: ItemsPlayer!
    var itemsEnemy: ItemsEnemy!
    var surrender: Surrender!
    var cactus: Cactus!
    var mainButton: ButtonMainAction!
    var attack: AttackScythe!
    
    override func didMove(to view: SKView) {

        self.backgroundColor = .background
        
        var Cards = BuildCards().buildAllEntities()
        Cards += BuildCards().buildAllEntities()
        grid = Grid(blockWidth: (UIScreen.main.bounds.width * 0.7)/5, blockHeight: (UIScreen.main.bounds.height*0.6)/4, rows: 4, cols: 5)!
        grid.position = CGPoint(x: (self.view?.bounds.width)!/2, y: (self.view?.bounds.maxY)! - grid.size.height/2 - 10)
        grid.zPosition = Zpositions.grid.rawValue
       
        addChild(grid)
        
        attack = AttackScythe(superView: view)
        attack.zPosition = Zpositions.attack.rawValue
        addChild(attack)
        
        itemsPlayer = ItemsPlayer(superView: view)
        itemsPlayer.zPosition = Zpositions.tableau.rawValue
        addChild(itemsPlayer)
      
        itemsEnemy = ItemsEnemy(superView: view)
        itemsEnemy.zPosition = Zpositions.tableau.rawValue
        addChild(itemsEnemy)
      
        cactus = Cactus(superView: view)
        cactus.zPosition = Zpositions.cactus.rawValue
        addChild(cactus)
      
        self.displayCard = DisplayCardHelper(cards: Cards, superView: view)
        displayCard.zPosition = Zpositions.display.rawValue
        addChild(displayCard!)
     
        surrender = Surrender(superView: view)
        surrender.zPosition = Zpositions.surrender.rawValue
        addChild(surrender)
        
        mainButton = ButtonMainAction(superView: view)
        mainButton.zPosition = Zpositions.mainButton.rawValue
        addChild(mainButton)
    
    }
}
