//
//  CostComponent.swift
//  GameChallenge
//
//  Created by Fernando de Lucas da Silva Gomes on 16/03/21.
//

import SpriteKit

class CostComponent: SKSpriteNode {
        
    var costTexture: SKTexture?
    let labelNode = SKLabelNode(text: "0")
    var costValue: Int = 0 {
        didSet {
            labelNode.attributedText = NSAttributedString(string: String(self.costValue), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12), NSAttributedString.Key.foregroundColor: UIColor.text])
        }
    }
    
    init() {
        self.costTexture = SKTexture(imageNamed: "costCard")
        labelNode.position = CGPoint(x: -1, y: -10)
        super.init(texture: costTexture, color: .clear, size: CGSize(width: 20, height: 25))
        self.zPosition = Zpositions.cardAttributes.rawValue
        labelNode.zPosition = Zpositions.cardAttributes.rawValue
       
        addChild(labelNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func takenDamage(damage: Int) {
        costValue -= damage
    }
    
    func buffDefense(value: Int) {
        costValue += value
    }
}

extension CostComponent: Component {
    func returnSelf() -> SKSpriteNode {
        return self
    }
}
