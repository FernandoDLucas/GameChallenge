//
//  GameScene.swift
//  GameChallenge
//
//  Created by Fernando de Lucas da Silva Gomes on 12/03/21.
//

import SpriteKit
import GameplayKit
import GameKit

class GameScene: SKScene {
    var label: SKLabelNode!
    var displayCard: DisplayCardHelper!
    var grid: Grid!
    var itemsPlayer: ItemsPlayer!
    var itemsEnemy: ItemsEnemy!
    var surrender: Surrender!
    var cactus: Cactus!
    var mainButton: ButtonMainAction!
    var boardHelper: BoardHelper!
    var gameManagement: GameManagement!
    var model: GameModel!
    var canPlay: Bool = false
    
    init(size: CGSize, model: GameModel) {
        super.init(size: size)
        self.model = model
        self.canPlay = GameCenterHelper.helper.currentMatch?.isLocalPlayersTurn ?? false 
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        GameCenterHelper.helper.becameActiveDelegate = self 
        itemsPlayer = ItemsPlayer(superView: view)
        itemsPlayer.zPosition = Zpositions.tableau.rawValue
        addChild(itemsPlayer)
        
        itemsEnemy = ItemsEnemy(superView: view)
        itemsEnemy.zPosition = Zpositions.tableau.rawValue
        addChild(itemsEnemy)
       
        self.displayCard = DisplayCardHelper(superView: view)
        displayCard.zPosition = Zpositions.display.rawValue
        addChild(displayCard)
        self.backgroundColor = .background
        
        var Cards = BuildCards().buildAllSpells()
        Cards += BuildCards().buildAllSpells()
        grid = Grid(blockWidth: (UIScreen.main.bounds.width * 0.7)/5, blockHeight: (UIScreen.main.bounds.height*0.6)/4, rows: 4, cols: 5)!
        grid.position = CGPoint(x: (self.view?.bounds.width)!/2, y: (self.view?.bounds.maxY)! - grid.size.height/2 - 10)
        grid.zPosition = Zpositions.grid.rawValue
        addChild(grid)
        
        cactus = Cactus(superView: view)
        cactus.zPosition = Zpositions.cactus.rawValue
        addChild(cactus)
        
        self.boardHelper = BoardHelper(grid: self.grid)
        // pega a posicao do quadro no grid e repassa para a carta
      
        surrender = Surrender(superView: view)
        surrender.zPosition = Zpositions.surrender.rawValue
        addChild(surrender)
        
        mainButton = ButtonMainAction(superView: view)
        mainButton.zPosition = Zpositions.mainButton.rawValue
        addChild(mainButton)
        
        setupGame()
        setupLabel(view: view)
    }
    
    func setupGame() {
        // função com quantidade de cartas
        let cardsOnHandPlayerOne = BuildCards().buildAllSpells()
        let cardsOnHandPlayerTwo = BuildCards().buildAllSpells()
        let cardsOnDeck = BuildCards().buildAllSpells()
        
            let playerOne = Player(cardsOnHand: cardsOnHandPlayerOne, cardsOnDeck: cardsOnDeck.shuffled(), type: .playerOne, mana: self.model.localPlayerMana, life: self.model.localPlayerLife)
            let playerTwo = Player(cardsOnHand: cardsOnHandPlayerTwo, cardsOnDeck: cardsOnDeck.shuffled(), type: .playerTwo, mana: self.model.remotePlayerMana, life: self.model.remotePlayerLife)
            
            self.gameManagement = GameManagement(playerOne: playerOne, playerTwo: playerTwo, displayCard: self.displayCard, itemsPlayer: self.itemsPlayer, itemsEnemy: self.itemsEnemy)
            self.gameManagement.initGame()
    }
    
    // MARK: - Funções para fase de teste
    func setupLabel(view: SKView) {
        let playerName = self.canPlay ? "Sua vez" : "Turno do Oponente"
        label = SKLabelNode()
        label.attributedText = NSAttributedString(string: playerName, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 28), NSAttributedString.Key.foregroundColor: UIColor.text])
        label.position = view.center
        addChild(label)
    }

    func updateLabel() {
        let playerName = gameManagement.playerOne.isActive ? gameManagement.playerOne.type.rawValue : gameManagement.playerTwo.type.rawValue
        label.attributedText = NSAttributedString(string: playerName, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 28), NSAttributedString.Key.foregroundColor: UIColor.text])
    }
    
    func updateModel() {
        self.model.updateStatus(allyPlayer: gameManagement.playerOne, enemyPlayer: gameManagement.playerTwo)
        if gameManagement.isNewTurn() {
            self.model?.localPlayerMana += 1
            self.model?.remotePlayerMana += 1
        }
        updateRemote()
    }
    
    func updateRemote() {
          GameCenterHelper.helper.endTurn(self.model) {  error in print("Erro ao finalizar rodada: \(error)") }
    }
}

extension GameScene: BecameActiveProtocol {
    func activate() {
        self.canPlay = true
    }
    func deActivate() {
        self.canPlay = false 
    }
}
