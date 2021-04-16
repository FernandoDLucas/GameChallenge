//
//  GameScene.swift
//  GameChallenge
//
//  Created by Fernando de Lucas da Silva Gomes on 12/03/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SurrenderDelegate {
    func surrenderTouch() {
        let transition: SKTransition
        transition = SKTransition.fade(withDuration: 1)
        let scene: SKScene = SurrenderScene(size: self.size)
        self.view?.presentScene(scene, transition: transition)
    }
    
  
    var displayCard: DisplayCardHelper!
    var grid: Grid!
    var itemsPlayer: ItemsPlayer!
    var itemsEnemy: ItemsEnemy!
    var surrender: Surrender!
    var cactus: Cactus!
    var mainButton: ButtonMainAction!
    var deck: DeckHelper!
    var boardHelper: BoardHelper!
    
    override func didMove(to view: SKView) {

        self.backgroundColor = .background
        var Cards = BuildCards().buildAllSpells()
        Cards += BuildCards().buildAllSpells()
        grid = Grid(blockWidth: (UIScreen.main.bounds.width * 0.7)/5, blockHeight: (UIScreen.main.bounds.height*0.6)/4, rows: 4, cols: 5)!
        grid.position = CGPoint(x: (self.view?.bounds.width)!/2, y: (self.view?.bounds.maxY)! - grid.size.height/2 - 10)
        grid.zPosition = Zpositions.grid.rawValue
        addChild(grid)
        
        itemsPlayer = ItemsPlayer(superView: view)
        itemsPlayer.zPosition = Zpositions.tableau.rawValue
        addChild(itemsPlayer)
      
        itemsEnemy = ItemsEnemy(superView: view)
        itemsEnemy.zPosition = Zpositions.tableau.rawValue
        addChild(itemsEnemy)
      
        cactus = Cactus(superView: view)
        cactus.zPosition = Zpositions.cactus.rawValue
        addChild(cactus)
      
        let spellCards = BuildCards().buildAllSpells()
        self.displayCard = DisplayCardHelper(cards: spellCards, superView: view)
        displayCard.zPosition = Zpositions.display.rawValue

        self.boardHelper = BoardHelper(grid: self.grid)
        // pega a posicao do quadro no grid e repassa para a carta

        addChild(displayCard!)
     
        surrender = Surrender(superView: view)
        surrender.zPosition = Zpositions.surrender.rawValue
        surrender.delegate = self
        addChild(surrender)
        
        mainButton = ButtonMainAction(superView: view)
        mainButton.zPosition = Zpositions.mainButton.rawValue
        addChild(mainButton)

    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let pos = touch.location(in: self)
            let node = self.atPoint(pos)
            
            if node == surrender {
                if view != nil {
                    let transition: SKTransition
                    transition = SKTransition.fade(withDuration: 1)
                    let scene: SKScene = SurrenderScene(size: self.size)
                    
                    self.view?.presentScene(scene, transition: transition)
                }
            }
        }
    }
    }

