//
//  EndGameScene.swift
//  GameChallenge
//
//  Created by Cecilia Soares on 20/04/21.
//

import UIKit
import SpriteKit
class EndGameScene: SKScene {
    
    var goHomeButton = SKSpriteNode()
    var goHomeLabel = SKLabelNode()
    private var rectangle : SKShapeNode!
    override func didMove(to view: SKView) {
        let w = (self.size.width + self.size.height)
        self.rectangle = SKShapeNode.init(rectOf: CGSize.init(width: w*2, height: w), cornerRadius: 0)
        self.rectangle.fillColor = UIColor.background
        self.rectangle.zPosition = 1
        addChild(rectangle)
        
        let background = SKSpriteNode(imageNamed: "bgEndGame")
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        background.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        background.zPosition = 3
        addChild(background)
        let endGameLabel = formatLabel(text: "FIM DE JOGO", color: UIColor.text, fontSize: 34, vertical: .top, horizontal: .center)
        endGameLabel.preferredMaxLayoutWidth = background.frame.size.width
        endGameLabel.position = .init(x: 0, y: background.size.height/2 - 70)
        endGameLabel.lineBreakMode = .byWordWrapping
        endGameLabel.numberOfLines = .max
        background.addChild(endGameLabel)
        
        let text = formatLabel(text: "Você venceu!!", color: UIColor.text, fontSize: 30, vertical: .top, horizontal: .center)
        text.preferredMaxLayoutWidth = background.frame.size.width
        text.position = .init(x: 0, y: background.size.height/2 - 120)
        text.lineBreakMode = .byWordWrapping
        text.numberOfLines = .max
//        background.addChild(text)
        
        goHomeButton = setupButton(imageName: "bgButtonBack", positionY: size.height/2 - 50)
        addChild(goHomeButton)
        goHomeLabel = formatLabel(text: "SAIR", color: .textAction, fontSize: 28, vertical: .center, horizontal: .center)
        goHomeButton.addChild(goHomeLabel)

        
    }
    func setupButton(imageName: String, positionY: CGFloat) -> SKSpriteNode {
        let surrenderTex = SKTexture(imageNamed: imageName)
        let button = SKSpriteNode(texture: surrenderTex)
        button.position = CGPoint(x: size.width/2, y: positionY)
        button.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        button.zPosition = 4
        return button
    }
    func formatLabel(text: String, color: UIColor, fontSize: CGFloat, vertical: SKLabelVerticalAlignmentMode, horizontal: SKLabelHorizontalAlignmentMode  ) -> SKLabelNode {
        let label = SKLabelNode()
        label.zPosition = 5
        label.text = text
        label.fontName = "xilosa"
        label.fontSize = fontSize
        label.fontColor = color
        label.numberOfLines = 1
        label.verticalAlignmentMode = vertical
        label.horizontalAlignmentMode = horizontal
        return label
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let pos = touch.location(in: self)
            let node = self.atPoint(pos)
            
            if  node == goHomeButton || node == goHomeLabel {
                if view != nil {
                    let transition: SKTransition
                    transition = SKTransition.fade(withDuration: 1)
                    let scene: SKScene = HomeScene(size: self.size)
                    self.view?.presentScene(scene, transition: transition)
                }
            }
        }
    }
}
