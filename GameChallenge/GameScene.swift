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
    
    override func didMove(to view: SKView) {
        let bg = SKSpriteNode(imageNamed: "background")
        bg.anchorPoint = CGPoint.zero
        addChild(bg)
        
        let cardCreated = EntityCard(cost: 3, power: 2, defense: 1, passives: [])
        let cardCreated2 = EntityCard(cost: 3, power: 2, defense: 1, passives: [])
        
        let card = EntityCard(cost: 10, power: 3, defense: 7, passives: [CreateCardsPassive(on: self, cards: cardCreated)])
        
        self.displayCard = DisplayCardHelper(cards: [card], texture: nil, size: self.size)
        
        let grid = Grid(blockWidth: (UIScreen.main.bounds.width * 0.8)/5, blockHeight: (UIScreen.main.bounds.height*0.7)/4, rows: 4, cols: 5)!
        grid.position = CGPoint(x: (self.view?.bounds.width)!/2, y: (self.view?.bounds.maxY)! - grid.size.height/2 - 10)
        addChild(grid)
        
        // pega a posicao do quadro no grid e repassa para a carta
        addChild(displayCard!)
        
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            card.passiveComponent.passives?.first?.activate()
        }
    }
    
    func touchDown(atPoint pos: CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos: CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos: CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
