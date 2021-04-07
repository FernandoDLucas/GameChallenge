//
//  HomeScene.swift
//  GameChallenge
//
//  Created by Cecilia Soares on 06/04/21.
//

import UIKit
import GameplayKit

class HomeScene: SKScene {
    var playButton = SKSpriteNode()
    let playButtonTex = SKTexture(imageNamed: "BgPlay")
    let playText = SKLabelNode(fontNamed: "xilosa")
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "bgHome")
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        background.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        background.zPosition = -1
        addChild(background)
        
        playButton = SKSpriteNode(texture: playButtonTex)
        playButton.position = CGPoint(x: size.width/2, y: size.height/2)
        playButton.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        playButton.zPosition = 1
        self.addChild(playButton)
        
        playText.text = "JOGAR"
        playText.fontSize = 28
        playText.zPosition = 2
        playText.verticalAlignmentMode = .center
        playText.horizontalAlignmentMode = .center
        playText.fontColor = SKColor.textAction
        playButton.addChild(playText)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let pos = touch.location(in: self)
            let node = self.atPoint(pos)
            
            if node == playButton || node == playText {
                if view != nil {
                    let transition: SKTransition
                    transition = SKTransition.fade(withDuration: 1)
                    let scene: SKScene = GameScene(size: self.size)
                    self.view?.presentScene(scene, transition: transition)
                }
            }
        }
    }
}
