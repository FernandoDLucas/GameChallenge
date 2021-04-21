//
//  PassiveComponent.swift
//  GameChallenge
//
//  Created by Fernando de Lucas da Silva Gomes on 17/03/21.
//

import SpriteKit

class PassiveComponent: SKSpriteNode {
    
    let labelNode = SKLabelNode(text: "0")
    var descriptionLabel: String = "" {
        didSet {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            labelNode.attributedText = NSAttributedString(string: descriptionLabel, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12), NSAttributedString.Key.foregroundColor: UIColor.text, NSAttributedString.Key.paragraphStyle: paragraphStyle])
            
        }
    }
    var passive: Passive?

    init() {
        super.init(texture: .none, color: .clear, size: CGSize(width: 70, height: 10))
        self.labelNode.position = CGPoint(x: 0, y: 0)
        self.labelNode.numberOfLines = 0
        self.labelNode.preferredMaxLayoutWidth = CGFloat(70)
        self.labelNode.lineBreakMode = .byTruncatingMiddle
        self.labelNode.horizontalAlignmentMode = .center
        self.labelNode.verticalAlignmentMode = .center
        self.labelNode.zPosition = 1
        addChild(labelNode)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
