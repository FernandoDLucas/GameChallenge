//
//  Grid.swift
//  GameChallenge
//
//  Created by Fernando de Lucas da Silva Gomes on 16/03/21.
//

import SpriteKit

class Grid: SKSpriteNode {
    var rows: Int!
    var cols: Int!
    var blockWidth: CGFloat!
    var blockHeight: CGFloat!

    convenience init?(blockWidth: CGFloat, blockHeight: CGFloat, rows: Int, cols: Int) {
        guard let texture = Grid.gridTexture(blockWidth:blockWidth, blockHeight: blockHeight, rows: rows, cols: cols) else {
            return nil
        }
        self.init(texture: texture, color: SKColor.clear, size: texture.size())
        self.blockWidth = blockWidth
        self.blockHeight = blockHeight
        self.rows = rows
        self.cols = cols
    }

    class func gridTexture(blockWidth: CGFloat, blockHeight: CGFloat, rows: Int, cols: Int) -> SKTexture? {
        // Add 1 to the height and width to ensure the borders are within the sprite
        let size = CGSize(width: CGFloat(cols)*blockWidth+1.0, height: CGFloat(rows)*blockHeight+1.0)
        UIGraphicsBeginImageContext(size)

        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        let bezierPath = UIBezierPath()
        let offset: CGFloat = 0.5
        
        // Draw vertical lines
        for i in 0...cols {
            let x = CGFloat(i)*blockWidth + offset
            bezierPath.move(to: CGPoint(x: x, y: 0))
            bezierPath.addLine(to: CGPoint(x: x, y: size.height))
        }
        // Draw horizontal lines
        for i in 0...rows {
            let y = CGFloat(i)*blockHeight + offset
            bezierPath.move(to: CGPoint(x: 0, y: y))
            bezierPath.addLine(to: CGPoint(x: size.width, y: y))
        }
        SKColor.red.setStroke()
        bezierPath.lineWidth = 1
        bezierPath.stroke()
        context.addPath(bezierPath.cgPath)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return SKTexture(image: image!)
    }

    func gridPosition(row: Int, col: Int) -> CGPoint {
        let yOffset = blockHeight / 2.0 + 0.5
        let xOffset = blockWidth / 2.0 + 0.5
        let x = CGFloat(col) * blockWidth - (blockWidth * CGFloat(cols)) / 2.0 + xOffset
        let y = CGFloat(rows - row - 1) * blockHeight - (blockHeight * CGFloat(rows)) / 2.0 + yOffset
        return CGPoint(x: x, y: y)
    }
}
