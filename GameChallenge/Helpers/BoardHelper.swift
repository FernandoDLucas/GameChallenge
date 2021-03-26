//
//  BoardHelper.swift
//  GameChallenge
//
//  Created by Fernando de Lucas da Silva Gomes on 22/03/21.
//

import SpriteKit

class Cell {
    var index: Int
    var x: Int
    var y: Int
    var free : Bool = true
    var card: Card?
    var node = SKSpriteNode(imageNamed: "backTexture")
    
    init(index: Int, x: Int, y: Int, free: Bool){
        self.index = index
        self.x = x
        self.y = y
        self.free = free
    }
}

class BoardHelper {
    var attackCells = [Cell.init(index: 1, x: 2, y: 0, free: true), Cell.init(index: 2, x: 2, y: 1, free: true), Cell.init(index: 3, x: 2, y: 2, free: true), Cell.init(index: 4, x: 2, y: 3, free: true), Cell.init(index: 5, x: 2, y: 4, free: true)]
    
     var cells = [Cell.init(index: 1, x: 3, y: 0, free: true), Cell.init(index: 2, x: 3, y: 1, free: true), Cell.init(index: 3, x: 3, y: 2, free: true), Cell.init(index: 4, x: 3, y: 3, free: true), Cell.init(index: 5, x: 3, y: 4, free: true)]
    let grid: Grid
    
    init(grid: Grid) {
        self.grid = grid
        self.buildNodes()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BoardHelper {
    
    func addCardToBoard(add card: Card) {
        guard let freeCell = cells.first(where: {$0.free == true}) else {return}
        guard let freeIndex = cells.firstIndex(where: {$0.free == true}) else {return}
        var freePosition = grid.gridPosition(row: freeCell.x, col: freeCell.y)
        card.position = freePosition
        cells[freeIndex].card = card
        cells[freeIndex].free = false
        grid.addChild(card)
    }
    
    func hadSpaceOnBoard() -> Bool {
        if let _ = cells.first(where: {$0.free == true}) {
            return true
        } else {
            return false 
        }
    }

    func removeCardFromBoard(remove card: Card) {
        let removableIndex = cells.firstIndex(where: {$0.card == card})
        cells[removableIndex!].free = true
        cells[removableIndex!].card = nil
        card.removeFromParent()
    }
    
    func addCardToAttack(add card: Card, to cell: Cell) {
        card.position = cell.node.position
        card.removeAction(forKey: "pickup")
        card.run(SKAction .scale(to: 1.0, duration: 0.25 ), withKey: "drop" )
        card.onAttack = true
        cell.free = false
    }
    
    func buildNodes() {
        attackCells.forEach {
            $0.node.position = grid.gridPosition(row: $0.x, col: $0.y)
            $0.node.alpha = 0 
            grid.addChild($0.node)
        }
    }
    
    func attackNodes() -> [Cell] {
        var array: [Cell] = []
        attackCells.forEach {
            if $0.free == true { array.append($0) }
        }
        return array
    }
    
    func deactivateAttackCell(index: Int) {
        attackCells[index].free = false
    }
    
    func hadSpaceOnAttack(index: Int) -> Bool {
        if attackCells[index].free == true {
            return true
        } else { return false }
    }
    
    func reactivateCell(cell: Cell){
        cell.free = true
    }
}
