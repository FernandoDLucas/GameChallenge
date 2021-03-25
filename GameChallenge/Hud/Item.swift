//
//  Item.swift
//  GameChallenge
//
//  Created by Kellyane Nogueira on 24/03/21.
//

import SpriteKit

class Item: SKSpriteNode {
    private var label = SKLabelNode()
    
    init(value: Int, texture: SKTexture, size: CGSize) {
        super.init(texture: texture, color: .clear, size: size)
        label.text = convertToString(value)
        label.position = CGPoint(x: 0, y: 0)
        
        formatLabel()
        addChild(label)
    }
    
    private func convertToString(_ value: Int) -> String {
        String(value)
    }
    
    func changeValue(_ newValue: Int) {
        label.text = convertToString(newValue)
    }
    
    func formatLabel() {
        label.fontColor = .black
        label.zPosition = 12
        label.fontSize = 18
        label.numberOfLines = 1
        label.verticalAlignmentMode = .center
        label.horizontalAlignmentMode = .center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
