//
//  ButtonMainAction.swift
//  GameChallenge
//
//  Created by Lidiane Gomes Barbosa on 25/03/21.
//

import SpriteKit

class ButtonMainAction: SKSpriteNode {
    private var label = SKLabelNode()
    
    init(superView: SKView) {
        super.init(texture: nil, color: .clear, size: MAIN_BUTTON_SIZE)
        formatLabel(text: "Passar")
        label.position = CGPoint(x: 0, y: 0)
        
//        self.blendMode = SKBlendMode.alpha
//        self.colorBlendFactor = 1
//        self.color = .black
//        self.alpha = 0.75
        
//        self.lightingBitMask = 0b0001
//        self.shadowCastBitMask = 0b0001
        
        let shapeNode = SKShapeNode(circleOfRadius: size.height / 2)
        shapeNode.fillColor = .action
        shapeNode.strokeColor = .action
        shapeNode.blendMode = .replace
        //shapeNode.glowWidth = 1
       
        addChild(shapeNode)
        addChild(label)
        
        position = CGPoint(x: superView.frame.width - (size.width / 2 + 16), y: size.height / 2 + 12)
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLabel(text: String) {
        self.label.text = text
    }
    
    func formatLabel(text: String) {
        label.zPosition = 12
        label.attributedText = NSAttributedString(string: text, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18), NSAttributedString.Key.foregroundColor: UIColor.text])
        label.numberOfLines = 1
        label.verticalAlignmentMode = .center
        label.horizontalAlignmentMode = .center
    }
}
