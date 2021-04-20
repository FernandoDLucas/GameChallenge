//
//  BoardHelper.swift
//  GameChallenge
//
//  Created by Fernando de Lucas da Silva Gomes on 22/03/21.
//

import SpriteKit

class BoardHelper {
    let grid: Grid
    
    var freeSpace: Bool = true
    
    init(grid: Grid) {
        self.grid = grid
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BoardHelper {
    
    func addCardToBoard(add card: Card) {
        var freePosition = grid.gridPosition(row: 1, col: 2)
        freePosition.y -= grid.blockHeight/2
        card.position = freePosition
        grid.addChild(card)
        self.freeSpace = false
    }
    
    func removeFromBoard(remove card: Card) {
        card.removeFromParent()
        self.freeSpace = true 
    }
}
