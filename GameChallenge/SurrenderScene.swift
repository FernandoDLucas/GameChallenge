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
    let surrenderText = SKLabelNode(fontNamed: "xilosa")
    var backButton = SKSpriteNode()
    
    override func didMove(to view: SKView) {
       
//        if let effectNode = self.childNode(withName: "EffectNode") as? SKEffectNode {
//        let blurFilter = CIFilter(name: "CIGaussianBlur", parameters: ["inputRadius": 75])
//        self.filter = blurFilter
//        self.zPosition = -1
//        self.shouldRasterize = true
//        self.shouldEnableEffects = true

            let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = self.view!.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            //let fillTexture = self.view?.texture(from: contentNode, crop: blurNode.frame)
//            self.view!.addSubview(blurEffectView)
        let background = SKSpriteNode(imageNamed: "bgEndGame")
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        background.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        background.zPosition = -1
        
        addChild(background)
        let text = SKLabelNode(fontNamed: "xilosa")
        text.text = "Deseja abandonar a partida?"
        text.lineBreakMode = .byWordWrapping
        text.numberOfLines = .max
        text.position = CGPoint(x: size.width * 0.355, y: size.height * 0.219 )
        text.fontSize = 28
        text.zPosition = 2
//        text.verticalAlignmentMode = .top
        text.horizontalAlignmentMode = .center
        text.fontColor = SKColor.text
        background.addChild(text)
        
        let surrenderTex = SKTexture(imageNamed: "bgButtonSurrender")
        surrenderButton = SKSpriteNode(texture: surrenderTex)
        surrenderButton.position = CGPoint(x: size.width/2, y: size.height/2)
        surrenderButton.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        surrenderButton.zPosition = 1
        addChild(surrenderButton)
        
        let backbuttonTex = SKTexture(imageNamed: "bgButtonBack")
        backButton = SKSpriteNode(texture: backbuttonTex)
        backButton.position = CGPoint(x: size.width/2, y: surrenderButton.position.y - 50)
        backButton.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        backButton.zPosition = 1
        addChild(backButton)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let pos = touch.location(in: self)
            let node = self.atPoint(pos)
            
//            if node == playButton || node == playText {
                if view != nil {
                    let transition: SKTransition
                    transition = SKTransition.fade(withDuration: 1)
                    let scene: SKScene = GameScene(size: self.size)
                    self.view?.presentScene(scene, transition: transition)
                }
            }
//        }
    }
}

   
