//
//  Item.swift
//  GameChallenge
//
//  Created by Kellyane Nogueira on 24/03/21.
//

import SpriteKit

class Item: SKSpriteNode {
    private var label = SKLabelNode()
    
    init(value: Int, texture: SKTexture, size: CGSize, positionLabel: CGPoint = CGPoint(x: 0, y: 0)) {
        super.init(texture: texture, color: .clear, size: size)
      
        let text = convertToString(value)
        formatLabel(text: text, position: positionLabel)
        addChild(label)
    }
    
    private func convertToString(_ value: Int) -> String {
        String(value)
    }
    
    func changeValue(_ newValue: Int) {
        let text = convertToString(newValue)
        label.attributedText = NSAttributedString(string: text, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18), NSAttributedString.Key.foregroundColor: UIColor.text])


    }
    
    func formatLabel(text: String, position: CGPoint) {
        label.zPosition = 12
        label.attributedText = NSAttributedString(string: text, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18), NSAttributedString.Key.foregroundColor: UIColor.text])
        label.numberOfLines = 1
        label.verticalAlignmentMode = .center
        label.horizontalAlignmentMode = .center
        label.position = position
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
