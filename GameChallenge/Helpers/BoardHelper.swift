//
//  BoardHelper.swift
//  GameChallenge
//
//  Created by Fernando de Lucas da Silva Gomes on 22/03/21.
//

import SpriteKit

struct Cell {
    var index: Int
    var x: Int
    var y: Int
    var free: Bool
    var card: Card?
}

class BoardHelper: SKSpriteNode {
     var cells = [Cell.init(index: 1, x: 2, y: 3, free: true), Cell.init(index: 2, x: 1, y: 3, free: true), Cell.init(index: 3, x: 3, y: 3, free: true), Cell.init(index: 4, x: 0, y: 3, free: true), Cell.init(index: 5, x: 4, y: 3, free: true)]
    let grid: Grid
    
    init(grid: Grid, texture: SKTexture, size: CGSize) {
        self.grid = grid
        super.init(texture: texture, color: .clear, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BoardHelper {
    
    func addCardToBoard(add card: Card) {
        guard let freeCell = cells.first(where: {$0.free == true}) else {return}
        guard let freeIndex = cells.firstIndex(where: {$0.free == true}) else {return}
        let freePosition = grid.gridPosition(row: freeCell.x, col: freeCell.y)
        card.position = freePosition
        cells[freeIndex].card = card
        cells[freeIndex].free = false
        addChild(card)
    }

    func removeCardFromBoard(remove card: Card) {
        let removableIndex = cells.firstIndex(where: {$0.card == card})
        cells[removableIndex!].free = true
        cells[removableIndex!].card = nil
        card.removeFromParent()
    }
    
    func addCardToAttack(add card: Card) {
        
    }
}
