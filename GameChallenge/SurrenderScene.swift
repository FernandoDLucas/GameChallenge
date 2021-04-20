//
//  SurrenderScene.swift
//  GameChallenge
//
//  Created by Cecilia Soares on 09/04/21.
//

import UIKit
import SpriteKit

class SurrenderScene: SKScene {
    var surrenderButton = SKSpriteNode()
    var surrenderLabel = SKLabelNode()
    var backButton = SKSpriteNode()
    var backLabel = SKLabelNode()
    var goHomeButton = SKSpriteNode()
    var goHomeLabel = SKLabelNode()
    private var rectangle : SKShapeNode!
    var model: GameModel!
    
    init(size: CGSize, model: GameModel) {
        super.init(size: size)
        self.model = model
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
//        MARK: Blur
//        let w = (self.size.width + self.size.height) * 0.05
//        let effectNode = SKEffectNode()
//        let blurFilter = CIFilter(name: "CIGaussianBlur", parameters: ["inputRadius": 75])
//        effectNode.filter = blurFilter
//        effectNode.shouldRasterize = true
//        effectNode.shouldEnableEffects = true
//        effectNode.zPosition = 2
//        self.addChild(effectNode)
//        self.rectangle = SKShapeNode.init(rectOf: CGSize.init(width: w*3, height: w*3), cornerRadius: w * 0.3)
//        self.rectangle.fillColor = UIColor.blue
//        self.rectangle.zPosition = 1
//        effectNode.addChild(rectangle)
        let background = SKSpriteNode(imageNamed: "bgEndGame")
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        background.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        background.zPosition = 1
        addChild(background)
        let text = formatLabel(text: "O que deseja fazer?", color: UIColor.text, fontSize: 34, vertical: .top, horizontal: .center)
        text.preferredMaxLayoutWidth = background.frame.size.width
        text.position = .init(x: 0, y: background.size.height/2 - 20)
        text.lineBreakMode = .byWordWrapping
        text.numberOfLines = .max
        background.addChild(text)
        
        surrenderButton = setupButton(imageName: "bgButtonSurrender", positionY: size.height/2 + 10)
        addChild(surrenderButton)
        surrenderLabel = formatLabel(text: "Render-se", color: UIColor.textAction, fontSize: 26, vertical: .center, horizontal: .center)
        surrenderButton.addChild(surrenderLabel)
        
        goHomeButton = setupButton(imageName: "bgButtonSurrender", positionY: surrenderButton.position.y - 50)
        addChild(goHomeButton)
        goHomeLabel = formatLabel(text: "Tela Inicial", color: .textAction, fontSize: 26, vertical: .center, horizontal: .center)
        goHomeButton.addChild(goHomeLabel)
        
        backButton = setupButton(imageName: "bgButtonBack", positionY: goHomeButton.position.y - 50)
        addChild(backButton)
        backLabel = formatLabel(text: "VOLTAR", color: .textAction, fontSize: 26, vertical: .center, horizontal: .center)
        backButton.addChild(backLabel)
    }
    func setupButton(imageName: String, positionY: CGFloat) -> SKSpriteNode {
        let surrenderTex = SKTexture(imageNamed: imageName)
        let button = SKSpriteNode(texture: surrenderTex)
        button.position = CGPoint(x: size.width/2, y: positionY)
        button.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        button.zPosition = 2
        return button
    }
    func formatLabel(text: String, color: UIColor, fontSize: CGFloat, vertical: SKLabelVerticalAlignmentMode, horizontal: SKLabelHorizontalAlignmentMode  ) -> SKLabelNode {
        let label = SKLabelNode()
        label.zPosition = 3
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
            if node == backButton || node == backLabel {
                if view != nil {
                    let transition: SKTransition
                    transition = SKTransition.fade(withDuration: 1)
                    let scene: SKScene = GameScene(size: self.size, model: self.model)
                    self.view?.presentScene(scene, transition: transition)
                }
                
            }
            if  node == surrenderButton || node == surrenderLabel {
                if view != nil {
                    let transition: SKTransition
                    transition = SKTransition.fade(withDuration: 1)
                    let scene: SKScene = EndGameScene(size: self.size)
                    self.view?.presentScene(scene, transition: transition)
                }
            }
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
